import 'dart:io';

Future<bool> checkConnection() async {
  try {
    var result = await InternetAddress.lookup('google.com');

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return Future.value(true);
    }
  } on SocketException catch (e) {
    print(
      'not connect',
    );
    return Future.value(false);
  }
  return Future.value(false);
}
