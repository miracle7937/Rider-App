import 'dart:convert';
import 'dart:io';

import 'package:deliveryApp/pref/localized_user_data.dart';
import 'package:http/http.dart' as http;

final String baseUrl = 'https://admin.bandofriders.com.ng/api/v1';

Future<Map> getHeader() async {
  var token = await getUserToken();
  var header = {
    'Authorization': 'Bearer $token',
    // 'content-type': 'application/json'
  };
  return header;
}

class ServerData {
  Future<HttpResponse> getData({String path}) async {
    var header = await getHeader();
    try {
      var response = await http.get('$baseUrl$path', headers: header);
      print('$baseUrl$path');
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
    var header = await getHeader();
    try {
      var response =
          await http.post('$baseUrl$path', body: body, headers: header);
      var data = jsonDecode(response.body);
      print('$baseUrl$path');
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future putData({String path, Map body}) async {
    var header = await getHeader();
    try {
      var response =
          await http.put('$baseUrl$path', body: body, headers: header);
      var data = jsonDecode(response.body);
      print('$baseUrl$path');
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  uploadFile({String path, Map body, File file}) async {
    final header = await getHeader();
    var postUri = Uri.parse('$baseUrl$path');
    var request = http.MultipartRequest(
      "PUT",
      postUri,
    );
    request.headers.addAll(header);

    body.forEach((key, value) {
      // print('$key $value');
      request.fields['$key'] = value.toString();
    });
  
    // request.fields['user'] = 'blah';
    request.files.add(new http.MultipartFile.fromBytes(
      'package_images',
      await file.readAsBytes(),
    ));
    request.send().then((response) {
      var data = jsonDecode(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpData(data);
      } else {
        return HttpException(data);
      }
    });
  }
}

//request  http request

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
