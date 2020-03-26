import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/enums/order_critera.dart';
import 'package:permafrost/core/redux/app_state.dart';

class SetOrderCriteriaAction extends ReduxAction<AppState> {
  final OrderCriteria newCriteria;

  SetOrderCriteriaAction({@required this.newCriteria});

  @override
  AppState reduce() {
    return state.copy(orderCriteria: newCriteria);
  }
}

class SetSearchCriteria extends ReduxAction<AppState> {
  final String newSearchCriteria;

  SetSearchCriteria({@required this.newSearchCriteria});

  @override
  AppState reduce() {
    return state.copy(searchCriteria: newSearchCriteria);
  }
}
