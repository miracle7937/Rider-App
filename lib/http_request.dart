import 'dart:convert';

import 'package:http/http.dart' as http;

final String baseUrl = 'http://admin.bandofriders.com.ng/api/v1';

class ServerData {
  Future<HttpResponse> getData({String path}) async {
    try {
      var response = await http.get('$baseUrl$path');
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        return HttpData(data);
      } else {
        return HttpException(data);
      }
    } catch (e) {
      print('exception get $e');
      return HttpException('something wrong happened');
    }
  }

  Future postData({String path, Map body}) async {
    try {
      var response = await http.post('$baseUrl$path', body: body);
      var data = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 2001) {
        return HttpData(data);
      } else {
        print(data);
        return HttpException(data);
      }
    } catch (e) {
      print('exception post $e');
      // return HttpException('something wrong happened');
    }
  }
}

abstract class HttpResponse {
  dynamic data;
}

class HttpException extends HttpResponse {
  final data;

  HttpException(this.data);
}

class HttpData extends HttpResponse {
  final data;

  HttpData(this.data);
}
