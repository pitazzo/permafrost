import 'package:flutter/material.dart';
import 'package:permafrost/core/enums/order_critera.dart';

class OrderCriteriaSelector extends StatelessWidget {
  final OrderCriteria currentCriteria;
  final Function(OrderCriteria) setCriteria;

  static const Map<OrderCriteria, String> humanCriteria = {
    OrderCriteria.ALPHABETIC: 'Nombre',
    OrderCriteria.EXPIRY_DATE: 'Caducidad',
    OrderCriteria.ENTRY_DATE: 'Antigüedad'
  };

  OrderCriteriaSelector(
      {@required this.currentCriteria, @required this.setCriteria});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          _buildChip(context, OrderCriteria.ALPHABETIC, currentCriteria),
          _buildChip(context, OrderCriteria.ENTRY_DATE, currentCriteria),
          _buildChip(context, OrderCriteria.EXPIRY_DATE, currentCriteria)
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, OrderCriteria criteria,
      OrderCriteria currentCriteria) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: GestureDetector(
        onTap: () => setCriteria(criteria),
        child: Chip(
            label: Text(
              humanCriteria[criteria],
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color:
                      criteria == currentCriteria ? Colors.white : Colors.grey),
            ),
            backgroundColor:
                criteria == currentCriteria ? Theme.of(context).accentColor : Colors.white),
      ),
    );
  }
}
