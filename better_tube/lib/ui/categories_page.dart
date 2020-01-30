import 'package:better_tube/fragments/loading.dart';
import 'package:better_tube/services/auth/auth_provider.dart';
import 'package:better_tube/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:better_tube/services/youtube-api/api_service.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String> _categories;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initCategories();
  }

  _initCategories() async {
    await DatabaseService(uid: AuthProvider.of(context).auth.user.uid).categoriesTitle
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
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: _categories != null ?
          Center (
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('${_categories[index]}'),
                  );
                },
              ),
            )
          : Loading('Fetching Your Categories'),
    );
  }
}