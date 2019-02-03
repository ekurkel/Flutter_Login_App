import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AboutUs extends StatefulWidget {
  @override
  AboutUsState createState() {
    return new AboutUsState();
  }
}

class AboutUsState extends State<AboutUs> {
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("About us")),
        body: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                    onPressed: _youtube,
                    child:
                        Text("YouTube", style: TextStyle(color: Colors.white)),
                    color: Colors.red),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  onPressed: mapController == null
                      ? null
                      : () {
                          mapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                            bearing: 270.0,
                            target: const LatLng(50.060070, 36.196172),
                            tilt: 30.0,
                            zoom: 15.0,
                          )));
                        },
                  child: Text("Map", style: TextStyle(color: Colors.white)),
                  color: Colors.green),
            ))
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 400.0,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  options: GoogleMapOptions(
                    myLocationEnabled: true,
                    compassEnabled: true,
                    cameraPosition: CameraPosition(
                      target: const LatLng(50.060070, 36.196172),
                      zoom: 10.0,
                    ),
                  ),
                )),
          ),
        ]));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(50.060070, 36.196172),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
  }

  void _youtube() {
    FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: "<API_KEY>",
      videoUrl: "https://youtu.be/fq4N0hgOWzU",
      autoPlay: true,
    );
  }
}
