import 'package:flutter/material.dart';
import 'package:permafrost/core/models/compartment.dart';
import 'package:permafrost/ui/views/compartment_view.dart';
import 'package:permafrost/ui/views/edit_compartment_view.dart';
import 'package:permafrost/ui/views/home_view.dart';
import 'package:permafrost/ui/views/item_list_view.dart';
import 'package:permafrost/ui/views/settings_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'items':
        return MaterialPageRoute(builder: (_) => ItemListView());
      case 'settings':
        return MaterialPageRoute(builder: (_) => SettingsView());        
      case 'compartment':
        int compartmentId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => CompartmentView(compartmentId: compartmentId));
      case 'newCompartment':
        return MaterialPageRoute(
            builder: (_) => EditCompartmentView(isEditing: false));
      case 'editCompartment':
        var compartment = settings.arguments as Compartment;
        return MaterialPageRoute(
            builder: (_) =>
                EditCompartmentView(compartment: compartment, isEditing: true));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No existe una ruta definida para ${settings.name}'),
            ),
          );
        });
    }
  }
}
