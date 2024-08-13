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

  /// [IsFlutter] をセットアップ
  /// [IsFlutterImpl] で具象クラスを実装
  @override
  void initState() {
    super.initState();
    IsFlutter.setUp(IsFlutterImpl());
    _fetchMessage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// [IsSwift]のAPIを呼び出す
  /// Native側で実装されたAPIをFlutter側で呼び出す
  Future<void> _fetchMessage() async {
    final api = IsSwift();
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
class IsFlutterImpl implements IsFlutter {
  @override
  Future<Message> flutterApi()  {
    final message = Message();
    message.message = "こんにちは！ Flutterからのメッセージです。";
    return Future.value(message);
  }
}
