import 'package:meta/meta.dart';
import 'package:permafrost/core/enums/order_critera.dart';
import 'package:permafrost/core/models/compartment.dart';
import 'package:permafrost/core/models/item.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
@immutable
class AppState {
  final List<Compartment> compartments;
  final List<Item> items;
  final String currentlySelectedMenu;
  final OrderCriteria orderCritera;
  final String searchCriteria;

  AppState(
      {@required this.compartments,
      @required this.items,
      @required this.currentlySelectedMenu,
      @required this.orderCritera,
      @required this.searchCriteria});

  AppState copy(
      {List<Compartment> compartments,
      List<Item> items,
      String currentlySelectedMenu,
      bool loading,
      OrderCriteria orderCriteria,
      String searchCriteria}) {
    return AppState(
        compartments: compartments ?? this.compartments,
        items: items ?? this.items,
        currentlySelectedMenu:
            currentlySelectedMenu ?? this.currentlySelectedMenu,
        orderCritera: orderCriteria ?? this.orderCritera,
        searchCriteria: searchCriteria ?? this.searchCriteria);
  }

  static AppState initialState() => AppState(
      compartments: [],
      items: [],
      currentlySelectedMenu: "/",
      searchCriteria: "",
      orderCritera: OrderCriteria.ALPHABETIC);

  @override
  String toString() {
    String output = 'AppState: {Compartments: ';
    this
        .compartments
        .forEach((compartment) => output += compartment.toString() + ', ');
    output += '}, currentlySelectedMenu: ' +
        this.currentlySelectedMenu.toString() +
        '}, search: ' + this.searchCriteria + '}, ';
    output += '{Items: ';

    this.items.forEach((item) => output += item.toString() + ', ');
    output += '}';
    return output;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppState &&
            this.compartments == other.compartments &&
            this.items == other.items &&
            this.currentlySelectedMenu == other.currentlySelectedMenu &&
            this.orderCritera == other.orderCritera &&
            this.searchCriteria == searchCriteria);
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}
