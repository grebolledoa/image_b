
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:image_b/image_b.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  String _res2 = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    /*try {
      platformVersion = await ImageBlur.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }*/
    platformVersion = 'Cargando..';
    setState(() {
      _platformVersion = platformVersion;
    });
    try {
      if (await Image_b.isImageBlurry(
          "https://www.allaboutvision.com/static/dca7ac0b2b77f938717971d612fe658d/18f60/visually-impaired-1200x630.png")) {
        _res2 = 'Borrosa';
      } else {
        _res2 = 'Buena';
      }
    } on Exception catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    platformVersion = 'Carga completada';

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detector de imagenes borrosas'),
        ),
        body: Center(
          child: new ListView(
            children: [
              Text('Estado: $_platformVersion\n'),
              new Image.network(
                "https://www.allaboutvision.com/static/dca7ac0b2b77f938717971d612fe658d/18f60/visually-impaired-1200x630.png",
                width: 400.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              Text('Estado de la imagen: $_res2\n'),
              new RaisedButton(
                  onPressed: initPlatformState,
                  textColor: Colors.white,
                  color: Colors.red,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Refresh",
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
