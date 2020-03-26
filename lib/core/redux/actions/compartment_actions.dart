import 'package:async_redux/async_redux.dart';
import 'package:meta/meta.dart';
import 'package:permafrost/core/models/compartment.dart';
import 'package:permafrost/core/redux/app_state.dart';

class AddCompartmentsAction extends ReduxAction<AppState> {
  final List<Compartment> compartments;
  AddCompartmentsAction({@required this.compartments});

  @override
  AppState reduce() {
    return state.copy(compartments: compartments);
  }
}

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
        ? state.compartments.fold(
                0,
                (max, compartment) =>
                    compartment.id > max ? compartment.id : max) +
            1
        : id;
    Compartment newCompartment = Compartment(
        id: id, name: name, color: color, icon: icon);

    int index = state.compartments
        .indexWhere((compartment) => compartment.id == newCompartment.id);
    List<Compartment> result;
    if (index != -1) {
      result = List.unmodifiable(state.compartments.toList()
        ..removeAt(index)
        ..insert(index, newCompartment));
    } else {
      result =
          List.unmodifiable(state.compartments.toList()..add(newCompartment));
    }
    return state.copy(compartments: result);
  }
}

class RemoveCompartmentAction extends ReduxAction<AppState> {
  final int id;
  RemoveCompartmentAction({@required this.id});

  @override
  Future<AppState> reduce() async{
    return state.copy(
        compartments: List.unmodifiable(state.compartments.toList()
          ..removeWhere((compartment) => compartment.id == this.id)),
        items: List.unmodifiable(state.items.toList()..removeWhere((item) => item.compartmentId == this.id)));
  }
}
