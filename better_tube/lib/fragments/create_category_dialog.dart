import 'package:flutter/material.dart';

class CreateCategoryDialog extends StatefulWidget {
  @override
  _CreateCategoryDialogState createState() => _CreateCategoryDialogState();
}

class _CreateCategoryDialogState extends State<CreateCategoryDialog> {

  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // contentPadding: EdgeInsets.all(20.0),
      content: 
        Container(
          height: 180.0,
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
                                borderSide: new BorderSide(
                                ),
                              ),
                            ),
                            controller: myController,
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
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              //Action Here
                              print('ok: ' + myController.text);
                              Navigator.pop(context);
                            }
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
}

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       // contentPadding: EdgeInsets.all(20.0),
//       backgroundColor: Colors.transparent,
//       child: 
//         dialogContent(context)
//     );
//   }

//   Widget dialogContent(BuildContext context) {
//     return  
//       Container(
//           margin: EdgeInsets.only(left: 0.0,right: 0.0),
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.only(
//           top: 18.0,
//           ),
//           margin: EdgeInsets.only(top: 13.0,right: 8.0),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(16.0),
//               boxShadow: <BoxShadow>[
//               BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 0.0,
//                   offset: Offset(0.0, 0.0),
//               ),
//               ]),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'Create A Category',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'Quicksand',
//                         fontSize: 30.0,                        
//                       ),
//                     ),
//                     Form (
//                       key: _formKey,
//                       child: Column(
//                         children: <Widget>[
//                           SizedBox(height: 15.0,),
//                           Container(
//                             width: 250.0,
//                               child: TextFormField(
//                               decoration: new InputDecoration(
//                                 labelText: "Enter Category Name",
//                                 fillColor: Colors.white,
//                                 border: new OutlineInputBorder(
//                                   borderRadius: new BorderRadius.circular(25.0),
//                                   borderSide: new BorderSide(
//                                   ),
//                                 ),
//                               ),
//                               controller: myController,
//                               validator: (val) {
//                                 if(val.length==0) {
//                                   return "Category Name cannot be empty.";
//                                 } else if (val.length > 20) {
//                                   return "Category Name too long.";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               style: new TextStyle(
//                                 fontFamily: "Quicksand",
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 15.0,),
//                           RaisedButton(
//                             onPressed: () {
//                               if (_formKey.currentState.validate()) {
//                                 //Action Here
//                                 print('ok: ' + myController.text);
//                                 Navigator.pop(context);
//                               }
//                             },
//                             child: Text(
//                               "Create",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Quicksand',
//                                 fontSize: 20.0,
//                               ),
//                             ),
//                             color: Colors.red,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//                           ),     
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 0.0,
//                 right: 0.0,
//                 child: FloatingActionButton(
//                   child: Icon(Icons.close, color: Colors.white,),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
//                   backgroundColor: Colors.red,
//                   mini: true,
//                   elevation: 5.0,
//                 ),
//               ),
//             ],
//           ),
//     );
// }

//   Widget dialogContent2(BuildContext context) {
//   return 
//   Container(
//   margin: EdgeInsets.only(left: 0.0,right: 0.0),
//   child: Stack(
//       children: <Widget>[
//       Container(
//           padding: EdgeInsets.only(
//           top: 18.0,
//           ),
//           margin: EdgeInsets.only(top: 13.0,right: 8.0),
//           decoration: BoxDecoration(
//               color: Colors.red,
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(16.0),
//               boxShadow: <BoxShadow>[
//               BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 0.0,
//                   offset: Offset(0.0, 0.0),
//               ),
//               ]),
//           child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//               SizedBox(
//               height: 20.0,
//               ),
//               Center(
//                   child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: new Text("Sorry please try \n again tomorrow", style:TextStyle(fontSize: 30.0,color: Colors.white)),
//                   )//
//               ),
//               SizedBox(height: 24.0),
//               InkWell(
//               child: Container(
//                   padding: EdgeInsets.only(top: 15.0,bottom:15.0),
//                   decoration: BoxDecoration(
//                   color:Colors.white,
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(16.0),
//                       bottomRight: Radius.circular(16.0)),
//                   ),
//                   child:  Text(
//                   "OK",
//                   style: TextStyle(color: Colors.blue,fontSize: 25.0),
//                   textAlign: TextAlign.center,
//                   ),
//               ),
//               onTap:(){
//                   Navigator.pop(context);
//               },
//               )
//           ],
//           ),
//       ),
//       Positioned(
//           right: 0.0,
//           child: GestureDetector(
//           onTap: (){
//               Navigator.of(context).pop();
//           },
//           child: Align(
//               alignment: Alignment.topRight,
//               child: CircleAvatar(
//               radius: 14.0,
//               backgroundColor: Colors.white,
//               child: Icon(Icons.close, color: Colors.red),
//               ),
//           ),
//           ),
//       ),
//       ],
//   ),
//   );
// }
