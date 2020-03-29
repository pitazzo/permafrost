import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/redux/actions/firebase_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/core/services/persistor.dart';
import 'package:permafrost/locator.dart';
import 'package:permafrost/ui/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permafrost/ui/shared/theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  // var persistor = PermaPersistor();
  // persistor.readState().then((initialState) {
  //   if (initialState == null) {
  //     initialState = AppState.initialState();
  //     persistor.saveInitialState(initialState);
  //   }
  // });

  NavigateAction.setNavigatorKey(navigatorKey);

  final Store store = Store<AppState>(
    initialState: AppState.initialState(),
    persistor: PermaPersistor(),
    actionObservers: [Log.printer(formatter: Log.verySimpleFormatter)],
    stateObservers: [StateLogger()],
  );

  store.dispatch(InitialSetup());
  //await store.dispatchFuture(StartListenFirestoreAction());

  runApp(StoreProvider<AppState>(
    store: store,
    child: MyApp(),
  ));
}

class StateLogger implements StateObserver<AppState> {
  @override
  void observe(ReduxAction<AppState> action, AppState stateIni,
      AppState stateEnd, int dispatchCount) {
    print(stateEnd.toString());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Permafrost',
      navigatorKey: navigatorKey,
      theme: theme,
      initialRoute: 'loading',
      onGenerateRoute: Router.generateRoute,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es'), // Spanish
      ],
    );
  }
}
