import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/enums/order_critera.dart';
import 'package:permafrost/core/redux/actions/item_list_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/ui/widgets/misc/order_criteria_selector.dart';

class OrderCriteriaSelectorConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (context, model) => OrderCriteriaSelector(
            currentCriteria: model.currentCriteria,
            setCriteria: model.setCriteria));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  OrderCriteria currentCriteria;
  Function(OrderCriteria) setCriteria;

  ViewModel.build({@required this.currentCriteria, @required this.setCriteria})
      : super(equals: [currentCriteria]);

  @override
  BaseModel fromStore() => ViewModel.build(
      currentCriteria: state.orderCritera,
      setCriteria: (criteria) {
        if (criteria != state.orderCritera) {
          dispatch(SetOrderCriteriaAction(newCriteria: criteria));
        }
      });
}
