import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:permafrost/core/models/fridge/compartment.dart';
import 'package:permafrost/core/models/fridge/item.dart';

import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/ui/widgets/compartments/compartment_details.dart';

class CompartmentDetailsConnector extends StatelessWidget {
  final int compartmentId;

  CompartmentDetailsConnector({@required this.compartmentId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(compartmentId),
        builder: (BuildContext context, ViewModel model) {
          return CompartmentDetails(
              compartment: model.compartment, items: model.items);
        });
  }
}

class ViewModel extends BaseModel<AppState> {
  int compartmentId;

  ViewModel(this.compartmentId);

  Compartment compartment;
  List<Item> items;

  ViewModel.build({@required this.compartment, @required this.items})
      : super(equals: [compartment, items]);

  @override
  BaseModel fromStore() => ViewModel.build(
      compartment: state.fridge.compartments
          .firstWhere((compartment) => compartment.id == this.compartmentId),
      items: state.fridge.items
          .where((item) => item.compartmentId == this.compartmentId)
          .toList()
            ..sort((item1, item2) => item1.name.compareTo(item2.name)));
}
