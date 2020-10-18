import 'package:deliveryApp/http_request.dart';
import 'package:flutter/cupertino.dart';

import '../repository.dart';

class NewUser extends Repository {
  final BuildContext context;
  NewUser(ServerData serverData, String path, this.context, {data})
      : super(serverData, context, path, data);
}


class UserWallet extends Repository{
   final BuildContext context;
   UserWallet(ServerData serverData, String path, this.context, {data})
      : super(serverData, context, path, data);

}
class TFRate extends Repository{
   final BuildContext context;
   TFRate(ServerData serverData, String path, this.context, {data})
      : super(serverData, context, path, data);

}
class DeductWallet extends Repository{
   final BuildContext context;
   DeductWallet(ServerData serverData, String path, this.context, {data, file})
      : super(serverData, context, path, data, file);

}