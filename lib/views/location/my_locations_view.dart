import 'package:flutter/material.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/location_point.dart';

class MyLocationsView extends StatefulWidget {
  @override
  _MyLocationsViewState createState() => _MyLocationsViewState();
}

class _MyLocationsViewState extends State<MyLocationsView> {
  final locationCtrl = LocationController();
  final auth = AuthController();

  @override
  void initState() {
    super.initState();
    locationCtrl.loadLocations(email: auth.currentUser!["email"]);
  }

  @override
  Widget build(BuildContext context) {
    final email = auth.currentUser!["email"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Endereços"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: locationCtrl.locations.length,
        itemBuilder: (context, index) {
          LocationPoint loc = locationCtrl.locations[index];

          return Card(
            child: ListTile(
              title: Text(loc.description,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                "Lat: ${loc.lat.toStringAsFixed(5)}\n"
                "Lng: ${loc.lng.toStringAsFixed(5)}\n"
                "Data: ${loc.date.day}/${loc.date.month}/${loc.date.year}",
              ),
              trailing: Icon(Icons.map, color: Colors.blue),
              onTap: () {
                // abre tela que mostra o ponto no mapa
                Navigator.pushNamed(
                  context,
                  '/view-location',
                  arguments: loc,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
