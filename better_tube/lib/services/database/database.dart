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
        List<String> channels = List<String>.from(doc['channels']);
        categories.add(Category(name: doc.documentID, channels: channels, colorString: doc['color']));
      });
    });
    return categories;
  }

  /* Create a category */
  Future<bool> createCategory(String categoryName, String color) async {
    return await userDataCollection.document(uid).collection('categories').document(categoryName).get().then((snapshot) async {
      if(snapshot.exists) {
        return false;
      } else {
        await userDataCollection.document(uid).collection('categories').document(categoryName).setData({
          'channels': [],
          'color': color,
        });
        return true;
      }
    });
  }

  /* Add channel to category */
  Future<void> updateCategory(String categoryName, String channelID) async {
    return await userDataCollection.document(uid).collection('categories').document(categoryName).updateData({
      'channels': FieldValue.arrayUnion([channelID]),
    });
    // return await userDataCollection.document(uid).collection('categories').document(categoryName).updateData({
    //   'channels': FieldValue.arrayUnion(['1', '3', 'a', 'aa', 'aaa', 'aaaa', 'aaaaa', 'aaaaaa', 'adaaaaa', 'aaaaaad',
    //                                      '12', '23', '2a', '2aa', '2aaa', '2aaaa', '2aaaaa', '2aaaaaa', '2adaaaaa', '2aaaaaad',
    //                                      '31', '33', '3a', 'a3a', '3aaa', '3aaaa', '3aaaaa', '3aaaaaa', '3adaaaaa', '3aaaaaad'
    //                                      '41', '43', '4a', 'a4a', 'aaa4', 'aaaa4', 'aaaaa4', 'aaaaaa4', 'adaaaaa4', 'aaaaaad4'
    //                                      '15', '35', 'a5', 'aa5', 'aaa5', 'aaaa5', 'aaaaa5', 'aaaaaa5', 'adaaaaa5', 'aaaaaad5'
    //                                      '16', '36', 'a6', 'aa6', 'aaa6', 'aaaa6', 'aaaaa6', 'aaaaaa6', 'adaaaaa6', 'aaaaaad6'
    //                                      '11', '31', 'a1', 'aa1', 'aaa1', 'aaaa1', 'aaaaa1', 'aaaaaa1', 'adaaaaa1', 'aaaaaad1'
    //                                      '12', '32', 'a2', 'aa2', 'aaa2', 'aaaa2', 'aaaaa2', 'aaaaaa2', 'adaaaaa2', 'aaaaaad2'
    //                                      '1d', '3d', 'ad', 'aad', 'aaad', 'aaaad', 'aaaaad', 'aaaadaad', 'adaaaaaddd', 'aaaaaadddd'
    //                                      '1c', '3c', 'ac', 'aac', 'aaac', 'aaaac', 'aaaaac', 'aaaaaac', 'adaaaaac', 'aaaaaad'
    //                                      ]),
    // });
  }

}