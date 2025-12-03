import 'package:flutter/material.dart';
import 'core/app_routes.dart';
import 'views/auth/login_view.dart';
import 'views/auth/register_view.dart';
import 'views/home/home_view.dart';
import 'views/location/add_location_view.dart';
import 'views/location/my_locations_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App MVC',
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => LoginView(),
        AppRoutes.register: (_) => RegisterView(),
        AppRoutes.home: (_) => HomeView(),
        AppRoutes.addLocation: (_) => AddLocationView(),
        AppRoutes.myLocations: (_) => MyLocationsView(),
      },
    );
  }
}
