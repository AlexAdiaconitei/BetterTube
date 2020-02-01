import 'package:better_tube/dialogs/color_picker_dialog.dart';
import 'package:better_tube/dialogs/confirmation_dialog.dart';
import 'package:better_tube/dialogs/error_dialog.dart';
import 'package:better_tube/models/category_model.dart';
import 'package:better_tube/services/auth/auth_provider.dart';
import 'package:better_tube/services/database/database.dart';
import 'package:better_tube/utils/hex_color_converter.dart';
import 'package:flutter/material.dart';

class CategoryOptionsDialog extends StatefulWidget {

  final Category category;
  CategoryOptionsDialog(this.category);

  @override
  _CategoryOptionsDialogState createState() => _CategoryOptionsDialogState(category);
}

class _CategoryOptionsDialogState extends State<CategoryOptionsDialog> {

  Category category;
  Color color;
  _CategoryOptionsDialogState(this.category) {
    color = category.color;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: 
        Container(
          height: 215.0,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Options',
                    style: TextStyle(fontSize: 30.0,),
                  ),
                  SizedBox(height: 10.0,),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Pick a Color:',
                            style: TextStyle(fontSize: 20.0,),
                          ),
                          SizedBox(width: 10.0,),
                          GestureDetector(
                            onTap: () {
                              _launchColorPicker();                              
                            },
                            child: new Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(width: 2, color: Colors.red)),
                                child: Icon(
                                  Icons.color_lens,
                                  color: color,
                                  size: 30.0,
                                ),
                              )),
                          ),
                        ],
                      ),                        
                      SizedBox(height: 15.0,),
                      RaisedButton.icon(
                        onPressed: () async {
                          _onUpdateCategoryColor();
                        },
                        icon: Icon(Icons.save, color: Colors.white,),
                        label: Text('Save Color', style: TextStyle(color: Colors.white),),
                        color: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      ),
                      SizedBox(height: 15.0,),
                      RaisedButton.icon(
                        onPressed: () async {
                          _showAcceptCancelDialog();
                        },
                        icon: Icon(Icons.delete, color: Colors.white,),
                        label: Text('Delete Category', style: TextStyle(color: Colors.white),),
                        color: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      ),     
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }

  void _onDeleteButtonPressed() async {
    bool res = await DatabaseService(uid: AuthProvider.of(context).auth.user.uid).deleteCategory(category.name);
    _confirmationErrorDialog(res, 'Error removing category.');
  }

  void _onUpdateCategoryColor() async {
    bool res = await DatabaseService(uid: AuthProvider.of(context).auth.user.uid).updateCategoryColor(category.name, HexColorConverter.colorToHex(color));
    _confirmationErrorDialog(res, 'Error updating color.');
    setState(() {});
  }

  void _confirmationErrorDialog(bool res, String errorMessage) {
    if(res) {
      setState(() {
        Navigator.pop(context, true);
      });                            
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return ConfirmationDialog();      
        }
      );                                
    } else {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return ErrorDialog(errorMessage);      
        }
      );
    }
  }

//TODO cambiar el _onUpdateCategoryColor a un boton xd
  void _launchColorPicker() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ColorPickerDialog(color);
      }
    ).then((newColorPicked) {
      setState(() {
        color = newColorPicked;
      });
    });
  }

  void _showAcceptCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Are you sure?"),
          content: new Text("This will delete your category from the storage."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                 Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Accept"),
              onPressed: () {
                Navigator.of(context).pop();
                _onDeleteButtonPressed();
              },
            ),
          ],
        );
      },
    );
  }

}
