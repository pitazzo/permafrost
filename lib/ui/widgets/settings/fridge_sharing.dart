import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class FridgeSharing extends StatefulWidget {
  final String currentFridgeUUID;
  final List<String> accesibleFridges;
  final Function(String) onFridgeSelected;
  final Function(String) onFridgeAdded;

  FridgeSharing({
    @required this.currentFridgeUUID,
    @required this.accesibleFridges,
    @required this.onFridgeSelected,
    @required this.onFridgeAdded,
  });

  @override
  _FridgeSharingState createState() => _FridgeSharingState();
}

class _FridgeSharingState extends State<FridgeSharing> {
  bool _scanCompleted = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Compartir mi nevera',
                          style: Theme.of(context).textTheme.headline6),
                      Text(
                          "Código para compartir tu nevera para que otras personas puedan ver y modificar lo que hay en ella",
                          maxLines: 4,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: 17))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: IconButton(
                    icon: FaIcon(FontAwesomeIcons.qrcode,
                        color: Colors.indigo, size: 40),
                    onPressed: () => showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0)),
                      ),
                      context: context,
                      builder: (context) => Center(
                        child: PrettyQr(
                            typeNumber: 3,
                            size: 300,
                            elementColor: Theme.of(context).primaryColor,
                            data: widget.currentFridgeUUID,
                            roundEdges: true),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Neveras accesibles',
                          style: Theme.of(context).textTheme.headline6),
                      Text(
                          "Si quieres compartir tu nevera para que otras personas puedan ver y modificar lo que hay",
                          maxLines: 4,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: 17)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: IconButton(
                    icon:
                        Icon(Icons.add_a_photo, color: Colors.indigo, size: 40),
                    onPressed: () {
                      setState(() => _scanCompleted = false);
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0)),
                        ),
                        context: context,
                        builder: (context) => Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 20.0),
                                child: Text(
                                  'Escanea el QR',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(fontSize: 25),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: QrCamera(
                                    qrCodeCallback: (code) {
                                      if (!_scanCompleted) {
                                        setState(() => _scanCompleted = true);
                                        widget.onFridgeAdded(code);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: List.generate(
                widget.accesibleFridges.length,
                (index) => _buildFridgeTile(index, context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildFridgeTile(int index, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.currentFridgeUUID == widget.accesibleFridges[index]
            ? Colors.indigo[100]
            : Colors.transparent,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ListTile(
        onTap: () {
          if (widget.currentFridgeUUID != widget.accesibleFridges[index]) {
            widget.onFridgeSelected(widget.accesibleFridges[index]);
          }
        },
        leading: Icon(Icons.ac_unit,
            color: widget.currentFridgeUUID == widget.accesibleFridges[index]
                ? Colors.indigo
                : Colors.grey,
            size: 30),
        title: Text(
          widget.accesibleFridges[index],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: widget.currentFridgeUUID == widget.accesibleFridges[index]
              ? Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)
              : Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
