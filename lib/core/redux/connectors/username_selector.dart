import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/redux/actions/firebase_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/ui/widgets/misc/username_selector.dart';

class UsernameSelectorConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Function(String)>(
      converter: (store) =>
          (username) => store.dispatch(CreateUserAction(username: username)),
      builder: (context, onSave) => UsernameSelector(onSave: onSave),
    );
  }
}
