import 'package:better_tube/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference userDataCollection = Firestore.instance.collection('userData');

  Future<void> updateUserData(String accessToken, Map<String, List<String>> categories, List<String> subscriptions) async {
    // return await userDataCollection.document(uid).setData({
    //   'accessToken': accessToken,
    //   'categories': categories,
    //   'subscriptions': subscriptions,
    // });
    return await userDataCollection.document(uid).setData({
      'accessToken': accessToken,
      // 'subscriptions': subscriptions,
    });
  }

  Future<void> updateUserAccessToken(String accessToken) async {
    return await userDataCollection.document(uid).updateData({
      'accessToken': accessToken,
    });
  }

  Future<List<Category>> get categories async {
    // Map<String, List<dynamic>> categoriesRaw = await userDataCollection.document(uid).get().then((result) {
    //   return Map<String, List<dynamic>>.from(result.data['categories']);
    // });
    // List<Category> categories = List<Category>();
    // categoriesRaw.forEach((k, v) {
    //   categories.add(Category(name:k, channels: List<String>.from(v)));
    // });
    // return categories;
    List<Category> categories = List<Category>();
    await userDataCollection.document(uid).collection('categories').getDocuments().then((QuerySnapshot snapshot){
      snapshot.documents.forEach((doc) {
        List<String> channels = List<String> .from(doc['channels']);
        categories.add(Category(name: doc.documentID, channels: channels, color: doc['color']));
      });
    });
    return categories;
  }

  /* Create a category */
  Future<bool> createCategory(String categoryName) async {
    return await userDataCollection.document(uid).collection('categories').document(categoryName).get().then((snapshot) async {
      if(snapshot.exists) {
        return false;
      } else {
        await userDataCollection.document(uid).collection('categories').document(categoryName).setData({
          'channels': [],
          'color': '#FFFFFF',
        });
        return true;
      }
    });
  }

  /* Add channel to category */
  Future<void> updateCategory(String categoryName) async {
    return await userDataCollection.document(uid).collection('categories').document(categoryName).updateData({
      'channels': FieldValue.arrayUnion(['1', '3']),
    });
  }

}