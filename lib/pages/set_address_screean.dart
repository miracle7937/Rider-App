import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/custom_ui/custom_snackbar.dart';
import 'package:deliveryApp/custom_ui/package_details.dart';
import 'package:deliveryApp/logic/connectivity/connectivity_widget.dart';
import 'package:deliveryApp/logic/geolocation/geolocation.dart';
import 'package:deliveryApp/logic/time_and_price_controller/price_and_time_controller.dart';
import 'package:deliveryApp/static_content/API_KEY.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as a;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as cal;

class SetAddressScreen extends StatefulWidget {
  @override
  _SetAddressScreenState createState() => _SetAddressScreenState();
}

class _SetAddressScreenState extends State<SetAddressScreen> {
  MatrixController matrixController;
  var pickupLocation = 'Set Pick up Address ';
  LatLng pickupLatLng;

  var destinationLocation = 'Set delievry Address ';
  LatLng destinationLatLng;

  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  GoogleMapController _mapController;
  Set<Marker> _markers = HashSet<Marker>();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  Map<MarkerId, Marker> markers = {};

  var polylinePoints = a.PolylinePoints();

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  double calculateDistanceInKiloMeter({LatLng destination, LatLng pickuploc}) {
    var distanceBetweenPoints = cal.SphericalUtil.computeDistanceBetween(
        cal.LatLng(pickuploc.latitude, pickuploc.longitude),
        cal.LatLng(destination.latitude, destination.longitude));

    print(distanceBetweenPoints / 1000);
    return (distanceBetweenPoints / 1000);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     UserLocation().permit();
        //   },
        // ),
        body: Builder(builder: (
          context,
        ) {
          return ConnectivityWidget(
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: Set<Marker>.of(markers.values),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(6.5244, 3.3792),
                    zoom: 12,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  polylines: Set<Polyline>.of(polylines.values),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: FormCard(
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(AssetImages.dot),
                                Expanded(
                                    child: VerticalDivider(
                                  thickness: 2,
                                )),
                                Image.asset(AssetImages.triangle),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  placeHolder(
                                      showIcon: true,
                                      text: pickupLocation ??
                                          'Set Pick up Address ',
                                      callback: () {
                                        onSelectAgain();
                                        getPlace().then((value) {
                                          if (value != null) {
                                            setState(() {
                                              pickupLocation =
                                                  value['description'];
                                              pickupLatLng = value['latLong'];
                                            });
                                          }
                                        }).whenComplete(() {
                                          checksIfAllLocationIsSelected();
                                        });
                                      }),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  placeHolder(
                                      callback: () {
                                        onSelectAgain();
                                        getPlace().then((value) {
                                          if (value != null) {
                                            setState(() {
                                              destinationLocation =
                                                  value['description'];
                                              destinationLatLng =
                                                  value['latLong'];
                                            });
                                          }
                                        }).whenComplete(() {
                                          checksIfAllLocationIsSelected();
                                        });
                                      },
                                      showIcon: false,
                                      text: destinationLocation ??
                                          'Set delievry Address '),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    matrixController != null
                        ? timeAndAmountPlacehoder(
                            matrixController.amount, matrixController.time)
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      callback: () {
                        //pickupLatLng == null &&
                        //                             destinationLatLng == null &&
                        if (matrixController?.amount == null) {
                          errorSnackBar(
                              context, 'select pick up and drop locations');
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PackageDetails(
                                        amount: matrixController?.amount,
                                        pickUpLocation: pickupLocation,
                                        dropLocation: destinationLocation,
                                        distanceInKilloMeter:
                                            calculateDistanceInKiloMeter(
                                                pickuploc: pickupLatLng,
                                                destination: destinationLatLng),
                                      )));
                        }
                      },
                      title: 'Continue',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future getPlace() async {
    var p = await PlacesAutocomplete.show(
        types: [],
        context: context,
        apiKey: kGoogleApiKey,
        mode: Mode.overlay, // Mode.fullscreen
        language: "us",
        components: [Component(Component.country, "ng")]);
    var value = await displayPrediction(p, homeScaffoldKey.currentState);
    return value;
  }

  Future<Map> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      print('"${p.description} - $lat/$lng"');

      return {
        'description': p.description,
        'latLong': LatLng(lat, lng),
      };
    }
    return {};
  }

  timeAndAmountPlacehoder(amount, time) {
    var width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      width: amount == null ? 0 : width * 0.5,
      duration: Duration(seconds: 4),
      curve: Curves.easeIn,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),

      // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: width * 0.25,
                height: 60,
                child: Container(
                  color: appColor,
                  child: Center(
                    child: AutoSizeText(
                      time,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                )),
            SizedBox(
                width: width * 0.25,
                height: 60,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: AutoSizeText(
                      '₦ ${amount.toString()}',
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  placeHolder(
          {@required bool showIcon,
          @required String text,
          VoidCallback callback}) =>
      InkWell(
        onTap: callback,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              showIcon
                  ? InkWell(
                      onTap: () {
                        UserLocation.currentLocation().then((value) {
                          if (value != null) {
                            _mapController.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target:
                                        LatLng(value.latitude, value.longitude),
                                    zoom: 12.0,
                                    tilt: 12)));
                          }
                        });
                      },
                      child: Image.asset(AssetImages.place))
                  : Container()
            ],
          ),
        ),
      );

  checksIfAllLocationIsSelected() {
    polylineCoordinates.clear();
    polylines.clear(); //marking it empty
    markers.clear(); //
    // clear all maker
    if (pickupLatLng != null && destinationLatLng != null) {
      _getPolyline();

      _mapController
          .animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: pickupLatLng, zoom: 12.0, tilt: 12)))
          .then((value) {
        _addMarker(pickupLatLng, 'pickup location', AssetImages.pickupImage);
        _addMarker(destinationLatLng, 'destination location',
            AssetImages.destinationImage);
        TimeDistanceController(pickupLatLng, destinationLatLng)
            .converToAmount()
            .then((value) {
          print(' miracle $value');
          setState(() {
            matrixController = value;
          });
        });
      });
    }
  }

  onSelectAgain() {
    setState(() {
      matrixController = null;
    });
    if (pickupLatLng != null && destinationLatLng != null) {
      setState(() {});
    }
  }

  _getPolyline() async {
    a.PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        kGoogleApiKey,
        a.PointLatLng(pickupLatLng.latitude, pickupLatLng.longitude),
        a.PointLatLng(destinationLatLng.latitude, destinationLatLng.longitude),
        travelMode: a.TravelMode.driving,
        wayPoints: [a.PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((a.PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        geodesic: true,
        polylineId: id,
        color: appColor,
        width: 5,
        points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _addMarker(LatLng position, String id, String image) async {
    final descriptor = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(24, 24)), image);

    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
}

///solving the flow
///
///if first location is selection there should check if
///same for second check
