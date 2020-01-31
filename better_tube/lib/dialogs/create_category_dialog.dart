import 'package:better_tube/dialogs/confirmation_dialog.dart';
import 'package:better_tube/dialogs/error_dialog.dart';
import 'package:better_tube/services/auth/auth_provider.dart';
import 'package:better_tube/services/database/database.dart';
import 'package:flutter/material.dart';

class CreateCategoryDialog extends StatefulWidget {
  @override
  _CreateCategoryDialogState createState() => _CreateCategoryDialogState();
}

class _CreateCategoryDialogState extends State<CreateCategoryDialog> {

  final _formController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // contentPadding: EdgeInsets.all(20.0),
      content: 
        Container(
          height: 200.0,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Create A Category',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 30.0,                        
                    ),
                  ),
                  Form (
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15.0,),
                        Container(
                          width: 250.0,
                            child: TextFormField(
                            decoration: new InputDecoration(
                              labelText: "Enter Category Name",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                            controller: _formController,
                            validator: (val) {
                              if(val.length==0) {
                                return "Category Name cannot be empty.";
                              } else if (val.length > 20) {
                                return "Category Name too long.";
                              } else {
                                return null;
                              }
                            },
                            style: new TextStyle(
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        RaisedButton(
                          onPressed: () async {
                            _onButtonPressed();
                          },
                          child: Text(
                            "Create",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 20.0,
                            ),
                          ),
                          color: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        ),     
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }


  Future<void> _onButtonPressed() async {
    if (_formKey.currentState.validate()) {
      bool res = await DatabaseService(uid: AuthProvider.of(context).auth.user.uid).createCategory(_formController.text);
      if(res) {                                
        Navigator.pop(context);
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
            return ErrorDialog('Repeaded Category Name.');      
          }
        );
      }
    }
  }

}
