import 'package:meta/meta.dart';
import 'package:permafrost/core/enums/order_critera.dart';
import 'package:permafrost/core/models/fridge/fridge.dart';

import 'package:permafrost/core/models/user.dart';

@immutable
class AppState {
  final User user;
  final Fridge fridge;
  final String currentlySelectedMenu;
  final OrderCriteria orderCritera;
  final String searchCriteria;

  AppState({
    @required this.user,
    @required this.fridge,
    @required this.currentlySelectedMenu,
    @required this.orderCritera,
    @required this.searchCriteria,
  });

  AppState copy({
    User user,
    Fridge fridge,
    String currentlySelectedMenu,
    bool loading,
    OrderCriteria orderCriteria,
    String searchCriteria,
  }) {
    return AppState(
      user: user ?? this.user,
      fridge: fridge ?? this.fridge,
      currentlySelectedMenu:
          currentlySelectedMenu ?? this.currentlySelectedMenu,
      orderCritera: orderCriteria ?? this.orderCritera,
      searchCriteria: searchCriteria ?? this.searchCriteria,
    );
  }

  static AppState initialState() => AppState(
      user: User(name: '', currentFridge: '', accesibleFridges: []),
      fridge: Fridge(owner: '', compartments: [], items: []),
      currentlySelectedMenu: "/",
      searchCriteria: "",
      orderCritera: OrderCriteria.ALPHABETIC);

  @override
  String toString() {
    return this.user.toString() + '\n' + this.fridge.toString();
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppState &&
            this.user == other.user &&
            this.fridge == other.fridge &&
            this.currentlySelectedMenu == other.currentlySelectedMenu &&
            this.orderCritera == other.orderCritera &&
            this.searchCriteria == searchCriteria);
  }

  @override
  int get hashCode => this.user.hashCode ^ this.fridge.hashCode;
}
