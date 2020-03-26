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
          _buildChip(OrderCriteria.ALPHABETIC, currentCriteria),
          _buildChip(OrderCriteria.ENTRY_DATE, currentCriteria),
          _buildChip(OrderCriteria.EXPIRY_DATE, currentCriteria)
        ],
      ),
    );
  }

  Widget _buildChip(OrderCriteria criteria, OrderCriteria currentCriteria) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: GestureDetector(
        onTap: () => setCriteria(criteria),
        child: Chip(
            label: Text(
              humanCriteria[criteria],
              style: TextStyle(
                  fontFamily: 'Baloo 2',
                  fontSize: 16,
                  color:
                      criteria == currentCriteria ? Colors.white : Colors.grey),
            ),
            backgroundColor:
                criteria == currentCriteria ? Colors.indigo : Colors.white),
      ),
    );
  }
}
