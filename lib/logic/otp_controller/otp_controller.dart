import 'package:deliveryApp/http_request.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';

class OTPController {
  static Future otpRegistration(String number) async {
    var result =
        await OTPRepo(ServerData(), '/otp', null, data: {"phone": number})
            .postNO();
    if (result == null) {
      return null;
    } else {
      return result.data['data'];
    }
  }

  static otpVerification({String pinID, String pin}) async {
    var result = await OTPRepo(ServerData(), '/verifyOtp', null,
        data: {"pin_id": pinID, "pin": pin}).postNO();

    if (result == null) {
      return null;
    } else {
      return result.data;
    }
  }
}
