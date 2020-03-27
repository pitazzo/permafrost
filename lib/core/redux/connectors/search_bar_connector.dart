import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/redux/actions/item_list_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/ui/widgets/misc/search_bar.dart';

class SearchBarConector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Function(String)>(
      converter: (store) => (text) => store.dispatch(SetSearchCriteria(newSearchCriteria: text)),
      builder: (context, onSearchTextChange) => SearchBar(setSearchText: onSearchTextChange),
    );
  }
}