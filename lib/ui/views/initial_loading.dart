import 'package:flutter/material.dart';
import 'package:permafrost/ui/widgets/misc/permafrost_progress.dart';

class InitialLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PermafrostProgressIndicator(),
      ),
    );
  }
}
