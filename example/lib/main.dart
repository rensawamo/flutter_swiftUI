import 'package:flutter/material.dart';
import 'package:nativesample/src/generated/messages.g.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _message;

  /// [FlutterApiClass] をセットアップ
  /// [FlutterApiClassImpl] で具象クラスを実装
  @override
  void initState() {
    super.initState();
    FlutterApiClass.setUp(FlutterApiClassImpl());
    _fetchMessage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// [SwiftApiClass]のAPIを呼び出す
  /// Native側で実装されたAPIをFlutter側で呼び出す
  Future<void> _fetchMessage() async {
    final api = SwiftApiClass();
    try {
      final message = await api.hostApi();
      setState(() {
        _message = message.message;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter View '),
      ),
      body: Center(
        child: _message == null
            ? Text("no message")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Message from SwiftUI: $_message'),
                ],
              ),
      ),
    );
  }
}

/// Flutter側で実装されたAPIをNative側で呼び出す
/// Flutter側で具象クラスを実装する必要がある
/// [MessagesImpl.swift] で呼び出された際に、[flutterApi] が呼び出される
class FlutterApiClassImpl implements FlutterApiClass {
  @override
  Future<Message> flutterApi()  {
    final message = Message();
    message.message = "こんにちは！ Flutterからのメッセージです。";
    return Future.value(message);
  }
}
