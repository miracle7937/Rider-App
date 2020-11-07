import 'dart:convert';

import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/models/Rate.dart';
import 'package:deliveryApp/static_content/API_KEY.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class TravelDetails {
  final time;
  final num distance;
  const TravelDetails({this.time, this.distance});

  factory TravelDetails.json(Map map) {
    num distanceInKM =
        map["rows"][0]["elements"][0]["distance"]["value"] / 1000;
    var time = map["rows"][0]["elements"][0]["duration"]["text"];
    return TravelDetails(distance: distanceInKM.toInt(), time: time);
  }
}

class TimeDistanceController {
  final LatLng pickup, destination;

  TimeDistanceController(this.pickup, this.destination);

  Future<TravelDetails> call() async {
    var url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${pickup.latitude},${pickup.longitude}&destinations=${destination.latitude},${destination.longitude}&key=$kGoogleApiKey';

    var client = http.Client();
    try {
      var response = await client.get(url);
      if (response.statusCode == 200 || response.statusCode == 200) {
        return TravelDetails.json(jsonDecode(response.body));
      } else {
        return null;
      }
    } finally {
      client.close();
    }
  }

  Future<MatrixController> converToAmount() async {
    var data = await call();

    var rate = await getRate(null);

    if (data != null || rate != null) {
      return MatrixController(
          time: data.time,
          amount: data.distance * rate.rate,
          distance: data.distance);
    } else {
      return null;
    }
  }
}

class MatrixController {
  final time, distance, amount;

  MatrixController({this.time, this.distance, this.amount});
}
