import 'package:flutter/material.dart';
import 'package:permafrost/core/services/validators.dart';
import 'package:permafrost/ui/widgets/misc/permafrost_progress.dart';
import 'package:permafrost/ui/widgets/misc/save_button.dart';

class UsernameSelector extends StatefulWidget {
  final Function(String) onSave;

  UsernameSelector({@required this.onSave});

  @override
  _UsernameSelectorState createState() => _UsernameSelectorState();
}

class _UsernameSelectorState extends State<UsernameSelector> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username = '';
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: PermafrostProgressIndicator(size: 30));
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  style: Theme.of(context).textTheme.headline6,
                  decoration: InputDecoration(
                    hintText: 'Nombre',
                  ),
                  validator: FormValidators.lengthValidator,
                  onChanged: (value) => setState(() => _username = value),
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState.validate()) {
                    widget.onSave(_username);
                    setState(() => _isLoading = true);
                  }
                })
          ],
        ),
      );
    }
  }
}
