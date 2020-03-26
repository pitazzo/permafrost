import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/core/services/persistor.dart';
import 'package:permafrost/locator.dart';
import 'package:permafrost/ui/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/redux/actions/firebase_actions.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  var persistor = PermaPersistor();
  AppState initialState = await persistor.readState();
  if (initialState == null) {
    initialState = AppState.initialState();
    await persistor.saveInitialState(initialState);
  }
  
  NavigateAction.setNavigatorKey(navigatorKey);

  final Store store = Store<AppState>(
    initialState: initialState,
    persistor: persistor,
    actionObservers: [Log.printer(formatter: Log.verySimpleFormatter)],
    stateObservers: [StateLogger()],
      );
    
      await store.dispatchFuture(StartListenFirestoreAction());
    
      runApp(StoreProvider<AppState>(
        store: store,
        child: MyApp(),
      ));
    }
    
    class StateLogger implements StateObserver<AppState>{
  @override
  void observe(ReduxAction<AppState> action, AppState stateIni, AppState stateEnd, int dispatchCount) {
    print(stateEnd.toString());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Permafrost',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      initialRoute: '/',
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
