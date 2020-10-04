import 'package:deliveryApp/http_request.dart';
import 'package:flutter/cupertino.dart';

import '../repository.dart';

class NewUser extends Repository {
  final BuildContext context;
  NewUser(ServerData serverData, String path, this.context, {data})
      : super(serverData, context, path, data);
}
