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
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.width / 5.5,
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
            for (int i = 0; i < 6; i++) {
              if (widget.znak == ["×", "÷", "-", "+", ".", ")"][i]) c = true;
            }
            if (c) {
              c = false;
              for (int i = 0; i < 5; i++) {
                if (state.tekst.isEmpty ||
                    state.tekst[state.tekst.length - 1] ==
                        ["×", "÷", "-", "+", "."][i]) c = true;
              }
              if(widget.znak==")"){if((state.tekst.isEmpty || state.tekst[state.tekst.length - 1] == "("))c=true;
              int ile = 0;
              int value = state.tekst.length;
              for (int i = 0; i < value; i++) {
                if (state.tekst[i] == "(") ile++;
                if (state.tekst[i] == ")") ile--;}
              if(ile<1)c=true;
              }
            }
            if (widget.znak == ".") {
              for (int i = state.tekst.length - 1; i > 0; i--) {
                bool czy = false;
                for (int j = 0; j < 4; j++) {
                  if (state.tekst[i] == ["×", "÷", "-", "+"][j]) {
                    czy = true;
                    break;
                  }
                }
                if (czy) break;
                if (state.tekst[i] == ".") {
                  c = true;
                  break;
                }
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

  String usunNawiasy(String tekst){
    int ile = 0,start=-1,end=-1;
    int value = tekst.length;
    for (int i = 0; i < value; i++) {
      if (tekst[i] == "(") ile++;
      if (tekst[i] == ")") ile--;
      if(ile!=0&&start==-1)start=i;
      if(ile==0&&start!=-1){end=i;
      String z1="",z2="",w;
      if(start!=0&&["0", "1", "2", "3","4","5","6","7","8","9"].any((element) {if(element != tekst[start-1])return false;return true;}))z1="×";
      if(tekst.length>end+1&&["×", "÷", "-", "+"].every((element) {if(element!=tekst[end+1])return true;return false;}))z2="×";
      w=calculateTotalValue(tekst.substring(start+1,end));
      tekst = tekst.substring(0,start)+z1+w+z2+tekst.substring(end+1);
      start=-1;
      end=-1;
      tekst = usunNawiasy(tekst);
      break;
      }
    }
    if(start!=-1)return "?";
    return tekst;
  }
  String calculateTotalValue(String tekstBazowy) {
    String tekst = tekstBazowy;
    if(["×", "÷", "-", "+", "."].any((element){ if(tekst[tekst.length-1]==element)return true;return false;})){return "?";}
    tekst = usunNawiasy(tekst);
    if(tekst=="?")return "?";
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
      if (tekst[y - 1] == ".") {
        liczby.add(double.parse(tekst.substring(0, y - 1)));
      } else {
        liczby.add(double.parse(tekst.substring(0, y)));
      }
      if (y != tekst.length) {
        znaki += tekst.substring(y, y + 1);
        y++;
      }
      tekst = tekst.substring(y);
    }
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
    return liczby[0].toString();
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<Tekst>(context, listen: true);
    String tekst = "";
    if (state.tekst != "") {
      tekst = state.tekst + " = " + calculateTotalValue(state.tekst);
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
            const MyRow(lista: ["1", "2", "3", "(", ")"]),
            const MyRow(lista: ["4", "5", "6", "+", "-"]),
            const MyRow(lista: ["7", "8", "9", "×", "÷"]),
            const MyRow(lista: ["c", "0", "d", ".", ""]),
          ],
        ),
      ),
    );
  }
}
