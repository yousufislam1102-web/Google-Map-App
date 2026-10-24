
import 'package:flutter/material.dart';
import 'package:flutter_application_1/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() =>
      _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  BitmapDescriptor? _campuspin;

  @override
  void initState() {
    super.initState();
    _loadCampusPin();
  }

  Future<void> _loadCampusPin() async {
    final campuspin = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/campus_pin.png',
    );
    setState(() {
      _campuspin = campuspin;
    });
  }

  Marker _huepin(Landmark place, double hue) {
    return Marker(
      markerId: MarkerId(place.id),
      position: place.position,
      infoWindow: InfoWindow(
        title: place.name,
        snippet: place.fact,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(hue),
    );
  }

  Set<Marker> _markers() {
    return {
      _huepin(
        Places.parliament,
        BitmapDescriptor.hueAzure,
      ),
      _huepin(
        Places.shahidMinar,
        BitmapDescriptor.hueCyan,
      ),
      _huepin(
        Places.lalbaghFort,
        BitmapDescriptor.hueGreen,
      ),
      _huepin(
        Places.ahsanManzil,
        BitmapDescriptor.hueMagenta,
      ),
      _huepin(
        Places.hatirjheel,
        BitmapDescriptor.hueOrange,
      ),
      Marker(
        markerId: MarkerId(Places.university.id),
        position: Places.university.position,
        infoWindow: InfoWindow(
          title: Places.university.name,
          snippet: _campuspin == null
              ? 'Loading custom marker...'
              : 'Custom campus marker',
        ),
        icon: _campuspin ?? BitmapDescriptor.defaultMarker,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Marker'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Text(
                'Custom Marker Screen',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: Places.openingCamera,
              zoomControlsEnabled: false,
              markers: _markers(),
            ),
          ),
        ],
      ),
    );
  }
}
