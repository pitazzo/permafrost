import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:permafrost/core/redux/app_state.dart';

class SelectMenuAction extends ReduxAction<AppState> {
  final String selectedMenu;

  SelectMenuAction({@required this.selectedMenu});

  @override
  AppState reduce() {
    dispatch(NavigateAction.pushReplacementNamed(this.selectedMenu));
    return state.copy(currentlySelectedMenu: this.selectedMenu);
  }
}
