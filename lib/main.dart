import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider.value(
  value: Tekst(),
  child: const MyApp(),
));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Kalkulator'),
    );
  }
}

class MyRow extends StatefulWidget {
  const MyRow({Key? key, required this.lista}) : super(key: key);
  final List<String> lista;

  @override
  State<MyRow> createState() => _MyRowState();
}

class _MyRowState extends State<MyRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyButton(znak: widget.lista[0]),
        MyButton(znak: widget.lista[1]),
        MyButton(znak: widget.lista[2]),
        MyButton(znak: widget.lista[3]),
        MyButton(znak: widget.lista[4])
      ],
    );
  }
}

class MyButton extends StatefulWidget {
  const MyButton({Key? key, required this.znak}) : super(key: key);
  final String znak;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.red.shade900,
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
            color: Colors.white54,
            gradient: RadialGradient(
                stops: const [0, 0.5, 0.9],
                radius: 0.8,
                colors: [
                  Colors.grey.shade400,
                  Colors.blue,
                  Colors.indigoAccent.shade700
                ]),
            border: Border.all(width: 1, color: Colors.black)),
        child: Center(
          child: widget.znak == "c"
              ? Icon(
            Icons.delete_forever,
            size: MediaQuery.of(context).size.width / 10,
          )
              : widget.znak == "d"
              ? Icon(
            Icons.backspace,
            size: MediaQuery.of(context).size.width / 12,
          )
              : Text(
            widget.znak,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 8,
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
      onTap: () {
        var state = Provider.of<Tekst>(context, listen: false);
        if (widget.znak == "d") {
          if (state.tekst != "") {
            state.tekst = state.tekst.substring(0, state.tekst.length - 1);
          }
        } else {
          if (widget.znak == "c") {
            state.tekst = "";
          } else {
            bool c = false;
            for (int i = 0; i < 4; i++) {
              if (widget.znak == ["×", "÷", "-", "+"][i]) c = true;
            }
            if (c) {
              c = false;
              for (int i = 0; i < 4; i++) {
                if (state.tekst.isEmpty ||
                    state.tekst[state.tekst.length - 1] ==
                        ["×", "÷", "-", "+"][i]) c = true;
              }
            }
            if (!c) state.tekst += widget.znak;
          }
        }
      },
    );
  }
}

class Tekst extends ChangeNotifier {
  String _tekst = "";

  String get tekst => _tekst;

  set tekst(String value) {
    _tekst = value;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String calculateTotalValue() {
    var state = Provider.of<Tekst>(context, listen: true);
    String tekst = state.tekst;
    List<double> liczby = [];
    String znaki = "";
    while (tekst != "") {
      List<int> z = [
        tekst.indexOf("+"),
        tekst.indexOf("-"),
        tekst.indexOf("×"),
        tekst.indexOf("÷")
      ];
      z.sort();
      int y = -1;
      for (int i = 0; i < 4; i++) {
        if (z[i] != -1) {
          y = z[i];
          break;
        }
      }
      if (y == -1) y = tekst.length;
      liczby.add(double.parse(tekst.substring(0, y)));
      if (y != tekst.length) {
        znaki += tekst.substring(y, y + 1);
        y++;
      }
      tekst = tekst.substring(y);
    }
    tekst = state.tekst;
    tekst += " = ";
    if (liczby.length > znaki.length) {
      while (liczby.length != 1) {
        int x = 0;
        if (znaki.contains("×") || znaki.contains("÷")) {
          x = znaki.indexOf("×");
          if (x == -1 || (znaki.contains("÷") && znaki.indexOf("÷") < x)) {
            x = znaki.indexOf("÷");
          }
          if (znaki[x] == "×") {
            liczby[x] = liczby[x] * liczby[x + 1];
          } else {
            liczby[x] = liczby[x] / liczby[x + 1];
          }
        } else {
          if (znaki[0] == "+") {
            liczby[x] = liczby[x] + liczby[x + 1];
          } else {
            liczby[x] -= liczby[x + 1];
          }
        }
        znaki = znaki.substring(0, x) + znaki.substring(x + 1);
        liczby.removeAt(x + 1);
      }
    }
    tekst += liczby[0].toString();
    return tekst;
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<Tekst>(context, listen: true);
    String tekst = "";
    if (state.tekst != "" && state.tekst != "błąd") {
      tekst = calculateTotalValue();
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 31,
                foreground: Paint()
                  ..shader = const LinearGradient(colors: [
                    Colors.yellowAccent,
                    Colors.redAccent,
                    Colors.purpleAccent
                  ]).createShader(
                      const Rect.fromLTWH(60.0, 0.0, 400.0, 300.0))),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: InteractiveViewer(
                scaleEnabled: true,
                maxScale: 3,
                child: Center(
                    child: Text(
                      tekst,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    )),
              ),
            ),
            const MyRow(lista: ["1", "2", "3","(", ")"]),
            const MyRow(lista: ["4", "5", "6", "+", "-"]),
            const MyRow(lista: ["7", "8", "9", "×", "÷"]),
            const MyRow(lista: ["c", "0", "d",","," "]),
          ],
        ),
      ),
    );
  }
}
