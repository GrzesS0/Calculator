import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
    ChangeNotifierProvider.value(
      value: Tekst(),
      child: MyApp(),
    )
);


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
  const MyRow({Key? key, required this.Lista}) : super(key: key);
  final List<String> Lista;

  @override
  State<MyRow> createState() => _MyRowState();
}

class _MyRowState extends State<MyRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyButton(znak: widget.Lista[0]),
        MyButton(znak: widget.Lista[1]),
        MyButton(znak: widget.Lista[2]),
        MyButton(znak: widget.Lista[3])
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
            gradient: RadialGradient(stops: [0,0.5,0.9],radius: 0.8,colors: [Colors.grey.shade400, Colors.blue,Colors.indigoAccent.shade700]),
            border: Border.all(width: 1, color: Colors.black)),
        child: Center(
          child: Text(
            widget.znak,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 8,
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
class Tekst extends ChangeNotifier{
  String _tekst="";
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

class _MyHomePageState extends State<MyHomePage> {var state;
@override
void initState() {
  state= Provider.of<Tekst>(context, listen: true);
  super.initState();
}

String tekst = "";

  @override
  Widget build(BuildContext context) {try{tekst=state.tekst;}catch(_){}
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Text(tekst)),
            MyRow(Lista: ["1", "2", "3", "+"]),
            MyRow(Lista: ["4", "5", "6", "-"]),
            MyRow(Lista: ["7", "8", "9", "×"]),
            MyRow(Lista: [" ", "0", " ", "÷"]),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
