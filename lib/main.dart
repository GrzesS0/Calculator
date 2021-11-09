import 'package:flutter/material.dart';

<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
void main() => runApp(ChangeNotifierProvider.value(
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
      value: Tekst(),
      child: const MyApp(),
    ));
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
=======
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
=======
=======
>>>>>>> chyba dobrze
=======
>>>>>>> Revert "Merge branch 'Grzegorz' into main"
=======
  value: Tekst(),
  child: const MyApp(),
));
>>>>>>> chyba dobrze
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
=======
>>>>>>> Revert "Merge branch 'Grzegorz' into main"
=======
void main() {
  runApp(const MyApp());
}
>>>>>>> Revert "Merge branch 'Grzegorz' into main"
>>>>>>> Revert "Merge branch 'Grzegorz' into main"
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
=======
>>>>>>> chyba dobrze
>>>>>>> chyba dobrze
=======
>>>>>>> Revert "Merge branch 'Grzegorz' into main"

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
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
        MyButton(znak: widget.lista[3])
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
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
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
=======
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
>>>>>>> chyba dobrze
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
=======
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
>>>>>>> Revert "Merge branch 'Grzegorz' into main"
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
            Expanded(
              child: InteractiveViewer(
                scaleEnabled: true,
                maxScale: 3,
                child: Center(
                    child: Text(
<<<<<<< e8a6a6073a9bedfe6adb7274cf57e86c8e256004
                  tekst,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )),
=======
                      tekst,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    )),
>>>>>>> chyba dobrze
              ),
=======
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
>>>>>>> Revert "Merge branch 'Grzegorz' into main"
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
