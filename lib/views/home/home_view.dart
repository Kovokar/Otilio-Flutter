import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/auth_controller.dart';
import '../location/add_location_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final locationCtrl = LocationController();
  final auth = AuthController();
  GoogleMapController? mapCtrl;

  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      locationCtrl.loadLocations(email: auth.currentUser!["email"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredLocations = locationCtrl.locations
        .where((loc) =>
            !locationCtrl.showOnlyMine ||
            loc.userEmail == auth.currentUser!["email"])
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Locais de Assaltos"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- TOGGLE ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Mostrar apenas meus locais"),
              Switch(
                value: locationCtrl.showOnlyMine,
                onChanged: (val) {
                  setState(() {
                    locationCtrl.showOnlyMine = val;
                  });
                },
              ),
            ],
          ),

          // --- MAPA ---
          Expanded(
            child: GoogleMap(
              onMapCreated: (c) => mapCtrl = c,
              initialCameraPosition: CameraPosition(
                target: LatLng(-3.742, -38.523), // Ponto padrão
                zoom: 13,
              ),
              markers: filteredLocations.map((loc) {
                return Marker(
                  markerId: MarkerId(loc.id),
                  position: LatLng(loc.lat, loc.lng),
                  infoWindow: InfoWindow(
                    title: loc.description,
                    snippet:
                        "Adicionado por: ${loc.userEmail}\nHora: ${loc.date.hour.toString().padLeft(2, '0')}:${loc.date.minute.toString().padLeft(2, '0')}",
                  ),
                );
              }).toSet(),
            ),
          ),

          SizedBox(height: 10),

          // --- BOTÕES ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Abre a tela de adicionar local
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddLocationView(),
                        ),
                      );

                      // Se um local foi adicionado, recarrega os locais
                      if (result == true) {
                        setState(() {
                          locationCtrl.loadLocations(
                              email: auth.currentUser!["email"]);
                        });
                      }
                    },
                    child: Text("Adicionar Endereço"),
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/my-locations");
                    },
                    child: Text("Ver Endereços Adicionados"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
