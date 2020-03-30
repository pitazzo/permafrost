import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/redux/actions/drawer_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/ui/widgets/misc/drawer.dart';

class DrawerConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel model) {
          return PermafrostDrawer(
            username: model.username,
            selectedMenu: model.currentlySelectedMenu,
            onMenuSelected: model.onMenuSelected,
          );
        });
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  String username;
  String currentlySelectedMenu;
  Function(String) onMenuSelected;

  ViewModel.build({
    @required this.username,
    @required this.currentlySelectedMenu,
    @required this.onMenuSelected,
  }) : super(equals: [currentlySelectedMenu]);

  @override
  ViewModel fromStore() => ViewModel.build(
      username: state.user.name,
      currentlySelectedMenu: state.currentlySelectedMenu,
      onMenuSelected: (menuId) {
        if (menuId != state.currentlySelectedMenu) {
          dispatch(SelectMenuAction(selectedMenu: menuId));
        } else {
          dispatch(NavigateAction.pop());
        }
      });
}
