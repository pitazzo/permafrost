import 'package:async_redux/async_redux.dart';
import 'package:meta/meta.dart';
import 'package:permafrost/core/redux/app_state.dart';

class SetMainLoadingAction extends ReduxAction<AppState>{
  final bool loading;

  SetMainLoadingAction({@required this.loading});

  @override
  AppState reduce() {
    return state.copy(loading: this.loading);
  }
}