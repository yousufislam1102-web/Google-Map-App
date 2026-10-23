import 'package:flutter/material.dart';
import 'package:flutter_application_1/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylinesScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<PolylinesScreen> createState() => _PolylinesScreenState();
}

class _PolylinesScreenState extends State<PolylinesScreen> {
  List<LatLng>_point=[];

  void _AddPoint(LatLng Position){
    setState(() => _point=[..._point,Position],);
  }

  void _loadCampusRoute(){
    setState(() {
      _point=[for (final Landmark stop in Places.shuttlerout) stop.position];
    });
  }
 
  Set<Polyline>_lines(){
    return {
      Polyline(
        polylineId: const PolylineId('walk'),
        points: _point,
        color: Colors.blue,
        width: 5,
      ),
    };
  }


  void clear(){
    setState(() {
      _point=[];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polylines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text('Polylines Screen'),
            ),
            Text('Tap to add points, or use the buttons below.'),
            Expanded(
              child: GoogleMap(initialCameraPosition: Places.openingCamera,
              polylines: _lines(),
             onTap: _AddPoint,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: _loadCampusRoute, child: const Text('Load Shuttle Route')),
                  ElevatedButton(onPressed: clear, child: const Text('Clear')),
                ],
              ),
          ],
        ),
      ),
    );
  }
}