import 'dart:io';

import 'package:deliveryApp/custom_ui/custom_snackbar.dart';
import 'package:deliveryApp/http_request.dart';
import 'package:flutter/cupertino.dart';

class Repository {
  final ServerData serverData;
  final Map data;
  final File file;
  final String path;
  final BuildContext context;
  Repository(
    this.serverData,
    this.context,
    this.path, [
    this.data,
    this.file
  ]);

  Future<HttpResponse> post() async {
    print('Post Request to $path');
    var value = await serverData.postData(path: path, body: data);
    print(value.runtimeType);
    if (value.runtimeType == HttpException) {
      errorSnackBar(context, value.data['message'].toString());
      return null;
    } else {
      successSnackBar(context, (value.data['message']).toString());
      return value;
    }
  }

  Future<HttpResponse> get() async {
    print('Get Request to $path');
    HttpResponse value = await serverData.getData(
      path: path,
    );
    if (value.runtimeType == HttpException) {
      errorSnackBar(context, value?.data.toString());
      return null;
    } else {
      successSnackBar(context, value.data.toString());
      return value;
    }
  }

  Future<HttpResponse> put() async {
    print('Post Request to $path');
    var value = await serverData.putData(path: path, body: data);
    print(value.runtimeType);
    if (value.runtimeType == HttpException) {
      errorSnackBar(context, value.data['message'].toString());
      return null;
    } else {
      successSnackBar(context, (value.data['message']).toString());
      return value;
    }
  }

  getNO() async {
    print('Get Request to $path');
    HttpResponse value = await serverData.getData(
      path: path,
    );
    if (value.runtimeType == HttpException) {
      // errorSnackBar(context, value?.data.toString());
      return null;
    } else {
      return value;
    }
  }

  Future<HttpResponse> putNO() async {
    print('Post Request to $path');
    var value = await serverData.putData(path: path, body: data);
    print(value.runtimeType);
    if (value.runtimeType == HttpException) {
      // errorSnackBar(context, value.data['message'].toString());
      return null;
    } else {
      // successSnackBar(context, (value.data['message']).toString());
      return value;
    }
  }

  Future<HttpResponse> makeRequest() async {
    print('Post Request to $path');
    var value = await serverData.uploadFile(path: path, body: data, file: file);
    print(value.runtimeType);
    if (value.runtimeType == HttpException) {
      errorSnackBar(context, 'error occurred');
      return null;
    } else {
      return value;
    }
  }
}
