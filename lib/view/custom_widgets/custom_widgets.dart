import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nominatim_geocoding/nominatim_geocoding.dart';

import 'app_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;

  const IconAndTextWidget(
      {Key? key,
      required this.text,
      this.color = const Color(0xFF76c5bb),
      this.iconColor = const Color(0xFF93ddd4),
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(
          width: 5,
        ),
        TextWidget(text: text, color: color)
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key,  required this.biryani}) : super(key: key);
 final String biryani;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.sizeOf(context).width > 400 ? 18.0 : 10, bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(biryani),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width > 400 ? 20 : 10,

              ),
              width:MediaQuery.sizeOf(context).width > 450 ? MediaQuery.sizeOf(context).width-200:null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 3.0, bottom: 3),
                    child: Text("Cumin Barbecue",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      "Cumin Barbecue",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Row(
                    mainAxisAlignment : MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.orange,
                          ),
                          SizedBox(
                            width:
                                MediaQuery.sizeOf(context).width > 400 ? 10 : 5,
                          ),
                          const Text("Normal"),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width > 400 ? 20 : 10,
                      ),
                      const IconAndTextWidget(
                        text: '1.7 Km',
                        icon: Icons.location_on,
                        color: Colors.grey,
                      ),
                      SizedBox(
                          width:
                              MediaQuery.sizeOf(context).width > 400 ? 20 : 10),
                      const IconAndTextWidget(
                        text: '32 min',
                        icon: Icons.timer_outlined,
                        color: Colors.grey,
                        iconColor: Colors.orange,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

SizedBox buildSizedBoxH30() => SizedBox(height: 30,);
SizedBox buildSizedBoxH40() => SizedBox(height: 40,);
ValueNotifier<bool> obscureNotifier = ValueNotifier<bool>(true);
ValueNotifier<Map> cityNotifier = ValueNotifier<Map>({});

InputDecoration buildInputDecoration(
  String name,
  IconData iconData,
) {
  return InputDecoration(
    fillColor: Colors.grey.shade300,
    filled: true,
    hintText: name,
    suffixIcon: IconButton(
      onPressed: () {
        if (name == "Password") {
          obscureNotifier.value = !obscureNotifier.value;
        }
      },
      icon: Icon(iconData),
    ),
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.green)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.red)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.blue)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.yellow)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.red)),
  );
}

/// Determine the current position of the device.

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition(
      forceAndroidLocationManager: true,
      desiredAccuracy: LocationAccuracy.high);
}

getAddress() async {
  Position position = await determinePosition();
  Coordinate coordinate =
      Coordinate(latitude: position.latitude, longitude: position.longitude);
  Geocoding geocoding =
      await NominatimGeocoding.to.reverseGeoCoding(coordinate);
  cityNotifier.value = {
    "city": geocoding.address.district,
    "local": geocoding.address.city
  };
}