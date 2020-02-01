import 'package:better_tube/dialogs/category_options_dialog.dart';
import 'package:better_tube/models/category_model.dart';
import 'package:better_tube/ui/categories_page.dart';
import 'package:flutter/material.dart';

class CategoryFragment extends StatefulWidget {
  final Category category;
  final State<CategoriesPage> parent;

  CategoryFragment(this.parent, this.category);

  @override
  _CategoryFragmentState createState() => _CategoryFragmentState();
}

class _CategoryFragmentState extends State<CategoryFragment> {

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          _showCategoryOptionsDialog();
        },
        child: Container(
        margin: EdgeInsets.all(10.0),
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Material(
              child: InkWell(
              onTap: () {},
              child: Row(
              children: <Widget>[
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.category.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontFamily: 'Roboto',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: widget.category.color,
                      radius: 25.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18.0,
                        child: Text(
                          widget.category.numberOfChannels.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                        'Channels',
                        style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Quicksand',
                                fontSize: 15.0,
                              ),
                        ),
                  ],
                ),
                SizedBox(width: 12.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCategoryOptionsDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {        
        return CategoryOptionsDialog(widget.category);      
      }
    ).then((_) {
      widget.parent.didChangeDependencies();
    });
  }
}