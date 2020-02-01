import 'package:better_tube/fragments/category_fragment.dart';
import 'package:better_tube/dialogs/create_category_dialog.dart';
import 'package:better_tube/fragments/loading.dart';
import 'package:better_tube/models/category_model.dart';
import 'package:better_tube/services/auth/auth_provider.dart';
import 'package:better_tube/services/database/database.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Category> _categories;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initCategories();
  }

  _initCategories() async {
    await DatabaseService(uid: AuthProvider.of(context).auth.user.uid).categories
          .then((categories) {
            setState(() {
              _categories = categories;
            });
          }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _categories != null ?
          Center (
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return CategoryFragment(
                    this,
                    _categories[index],
                  );
                },
              ),
            )
          : Loading('Fetching Your Categories'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAlertDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }

  _showAlertDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,      
      builder: (BuildContext context) {
        return CreateCategoryDialog();
      },      
    ).then((_) {
      _initCategories();
    });
  }

}