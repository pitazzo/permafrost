import 'package:async_redux/async_redux.dart';
import 'package:meta/meta.dart';
import 'package:permafrost/core/models/fridge/compartment.dart';
import 'package:permafrost/core/redux/app_state.dart';

class SaveCompartmentAction extends ReduxAction<AppState> {
  int id;
  String name;
  String color;
  String icon;

  SaveCompartmentAction(
      {@required this.id,
      @required this.name,
      @required this.color,
      @required this.icon});

  @override
  AppState reduce() {
    id = id == -1
        ? state.fridge.compartments.fold(
                0,
                (max, compartment) =>
                    compartment.id > max ? compartment.id : max) +
            1
        : id;
    Compartment newCompartment =
        Compartment(id: id, name: name, color: color, icon: icon);

    int index = state.fridge.compartments
        .indexWhere((compartment) => compartment.id == newCompartment.id);
    List<Compartment> result;
    if (index != -1) {
      result = List.unmodifiable(state.fridge.compartments.toList()
        ..removeAt(index)
        ..insert(index, newCompartment));
    } else {
      result = List.unmodifiable(
          state.fridge.compartments.toList()..add(newCompartment));
    }
    return state.copy(fridge: state.fridge.copy(compartments: result));
  }
}

class RemoveCompartmentAction extends ReduxAction<AppState> {
  final int id;
  RemoveCompartmentAction({@required this.id});

  @override
  Future<AppState> reduce() async {
    return state.copy(
        fridge: state.fridge.copy(
            compartments: List.unmodifiable(state.fridge.compartments.toList()
              ..removeWhere((compartment) => compartment.id == this.id)),
            items: List.unmodifiable(state.fridge.items.toList()
              ..removeWhere((item) => item.compartmentId == this.id))));
  }
}
