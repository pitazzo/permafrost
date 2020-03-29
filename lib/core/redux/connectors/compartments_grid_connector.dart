import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/models/fridge/compartment.dart';
import 'package:permafrost/core/redux/actions/compartment_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/ui/widgets/compartments/compartments_grid.dart';

class CompartmentsGridConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel model) {
          return CompartmentsGrid(
            compartments: model.compartments,
            itemsPerCompartment: model.itemsPerCompartment,
            onDelete: model.onDeleted,
          );
        });
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  List<Compartment> compartments;
  Map<int, int> itemsPerCompartment;
  Function(int) onDeleted;

  ViewModel.build(
      {@required this.compartments,
      @required this.itemsPerCompartment,
      @required this.onDeleted})
      : super(equals: [compartments, itemsPerCompartment]);

  Map<int, int> _countItems() {
    Map<int, int> itemsPerCompartment = {};
    state.fridge.compartments.forEach((compartment) =>
        itemsPerCompartment.putIfAbsent(compartment.id, () => 0));
    state.fridge.items
        .forEach((item) => itemsPerCompartment[item.compartmentId]++);
    return itemsPerCompartment;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
      compartments: state.fridge.compartments,
      itemsPerCompartment: _countItems(),
      onDeleted: (id) => dispatch(RemoveCompartmentAction(id: id)));
}
