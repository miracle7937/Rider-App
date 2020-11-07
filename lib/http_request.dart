import 'dart:convert';
import 'dart:io';
import 'package:deliveryApp/pages/Auth/SignupPage.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:deliveryApp/pref/localized_user_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<HttpResponse> getData(
    BuildContext context, {
    String path,
  }) async {
    var header = await getHeader();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var response = await http.get('$baseUrl$path', headers: header);
      print('$baseUrl$path');
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 401) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
        prefs.remove('userData');
      }
      print(' app statuscode ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpData(data);
      } else {
        return HttpException(data);
      }
    } catch (e) {
      print('exception get $e');
      return HttpException('something wrong happened');
    }
  }

  Future postData(
    BuildContext context, {
    String path,
    Map body,
  }) async {
    var header = await getHeader();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var response =
          await http.post('$baseUrl$path', body: body, headers: header);
      var data = jsonDecode(response.body);
      print('$baseUrl$path');
      if (response.statusCode == 401) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
        prefs.remove('userData');
      }
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

  Future putData(
    BuildContext context, {
    String path,
    Map body,
  }) async {
    var header = await getHeader();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var response =
          await http.put('$baseUrl$path', body: body, headers: header);
      var data = jsonDecode(response.body);
      print('$baseUrl$path');
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 401) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
        prefs.remove('userData');
      }
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

  Future uploadNoFile(
    BuildContext context, {
    String path,
    Map body,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final header = await getHeader();
    var postUri = Uri.parse('$baseUrl$path');
    var request = http.MultipartRequest(
      "POST",
      postUri,
    );
    request.headers.addAll(header);

    body.forEach((key, value) {
      // print('$key $value');
      request.fields['$key'] = value.toString();
    });

    var response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());

    print(response);
    if (response.statusCode == 401) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
      prefs.remove('userData');
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('successful');
      return HttpData(data["data"]);
      // return true;
    } else {
      print('fails');
      return HttpException(null);
    }
  }

  Future uploadFile(BuildContext context,
      {String path, Map body, File file}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    final header = await getHeader();
    var postUri = Uri.parse('$baseUrl$path');
    var request = http.MultipartRequest(
      "POST",
      postUri,
    );
    request.headers.addAll(header);

    body.forEach((key, value) {
      request.fields['$key'] = value.toString();
    });
    var multipartFileSign = new http.MultipartFile(
        'package_images[]', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFileSign);

    var response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 401) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
      prefs.remove('userData');
    }

    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('successful');
      return HttpData(data["data"]);
      // return true;
    } else {
      print('fails');
      return HttpException(null);
    }
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
