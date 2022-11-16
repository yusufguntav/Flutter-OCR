import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter OCR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const home(),
    );
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<String> words = [];

  _startScan() async {
    List<OcrText> list;
    try {
      list = await FlutterMobileVision.read(
        multiple: true,
        waitTap: true,
        fps: 5,
      );
      for (OcrText text in list) {
        words.add(text.value);
        setState(() {});
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int x = 0; x < words.length; x++) ...[
            SelectableText(
              words[x],
            )
          ]
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          _startScan();
        }),
        child: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}
