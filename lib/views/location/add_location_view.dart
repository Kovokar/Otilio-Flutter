import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/auth_controller.dart';

class AddLocationView extends StatefulWidget {
  @override
  _AddLocationViewState createState() => _AddLocationViewState();
}

class _AddLocationViewState extends State<AddLocationView> {
  LatLng? selectedPoint;
  GoogleMapController? mapCtrl;

  final descCtrl = TextEditingController();
  TimeOfDay? selectedTime;

  final locationCtrl = LocationController();
  final auth = AuthController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final email = auth.currentUser!["email"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Local"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // MAPA
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(-3.742, -38.523), // posição inicial
                zoom: 14,
              ),
              onMapCreated: (c) => mapCtrl = c,
              onTap: (pos) {
                setState(() {
                  selectedPoint = pos;
                });
              },
              markers: selectedPoint == null
                  ? {}
                  : {
                      Marker(
                        markerId: MarkerId("selected"),
                        position: selectedPoint!,
                      )
                    },
            ),
          ),

          // DESCRIÇÃO
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: descCtrl,
              decoration: InputDecoration(
                labelText: "Descrição",
                hintText: "Ex: Assalto às 20h",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 2,
            ),
          ),

          // HORA
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedTime == null
                        ? "Escolha a hora do assalto"
                        : selectedTime!.format(context),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() => selectedTime = time);
                    }
                  },
                  child: Text("Selecionar hora"),
                ),
              ],
            ),
          ),

          // BOTÃO SALVAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedPoint == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Selecione um ponto no mapa!")),
                    );
                    return;
                  }

                  if (descCtrl.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Digite uma descrição!")),
                    );
                    return;
                  }

                  // monta a data + hora
                  final now = DateTime.now();
                  final dateWithTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    selectedTime?.hour ?? now.hour,
                    selectedTime?.minute ?? now.minute,
                  );

                  await locationCtrl.addLocation(
                    email: email,
                    lat: selectedPoint!.latitude,
                    lng: selectedPoint!.longitude,
                    description: descCtrl.text.trim(),
                    date: dateWithTime,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Local adicionado!")),
                  );

                  Navigator.pop(context, true); // volta para Home
                },
                child: Text(
                  "Salvar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
