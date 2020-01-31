import 'package:better_tube/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryFragment extends StatelessWidget {
  final Category category;

  CategoryFragment(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
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
      child: Row(
        children: <Widget>[
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  category.name,
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
                backgroundColor: category.color,
                radius: 25.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18.0,
                  child: Text(
                    category.numberOfVideos.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
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
        ],
      ),
    );
  }
}