import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/redux/actions/sharing_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/ui/widgets/settings/fridge_sharing.dart';

class FridgeSharingConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (context, model) => FridgeSharing(
        currentFridgeUUID: model.currentFridge,
        accesibleFridges: model.accesibleFridges,
        onFridgeAdded: model.onFridgeAdded,
        onFridgeSelected: model.onFridgeSelected,
      ),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  String currentFridge;
  List<String> accesibleFridges;
  Function(String) onFridgeSelected;
  Function(String) onFridgeAdded;

  ViewModel.build(
      {@required this.currentFridge,
      @required this.accesibleFridges,
      @required this.onFridgeSelected,
      @required this.onFridgeAdded})
      : super(equals: [currentFridge, accesibleFridges]);

  @override
  BaseModel fromStore() => ViewModel.build(
        currentFridge: state.user.currentFridge,
        accesibleFridges: state.user.accesibleFridges,
        onFridgeSelected: (fridge) =>
            dispatch(SelectFridgeAction(newFridge: fridge)),
        onFridgeAdded: (fridge) =>
            dispatch(AddNewFridgeAction(newFridge: fridge)),
      );
}
