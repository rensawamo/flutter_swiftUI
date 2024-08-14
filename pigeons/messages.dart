import 'package:pigeon/pigeon.dart';


@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/generated/messages.g.dart',
  dartOptions: DartOptions(),
  swiftOut: 'ios/Classes/Messages.swift',
  swiftOptions: SwiftOptions(),
))

// 返り値の型
class Message {
  String? message;
}

/// FlutterがNativeのAPIを呼び出す
/// Swift側で具象クラスを実装する必要がある
@HostApi()
abstract class SwiftApiClass {
  @async  
  Message hostApi();
}

/// NativeがFlutterのAPIを呼び出す
/// Flutter側で具象クラスを実装する必要がある
@FlutterApi()
abstract class FlutterApiClass {
  @async
  Message flutterApi();
}