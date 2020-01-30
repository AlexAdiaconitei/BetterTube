import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference userDataCollection = Firestore.instance.collection('userData');

  Future<void> updateUserData(String accessToken, Map<String, List<String>> categories, List<String> subscriptions) async {
    return await userDataCollection.document(uid).setData({
      'accessToken': accessToken,
      'categories': categories,
      'subscriptions': subscriptions,
    });
  }

  Future<void> updateUserAccessToken(String accessToken) async {
    return await userDataCollection.document(uid).updateData({
      'accessToken': accessToken,
    });
  }

  // List<String> _categoriesListFromSnapshot(DocumentSnapshot snapshot) {
  //   return snapshot.data.keys.map((doc) {

  //   });
  // }

  Future<List<String>> get categoriesTitle async {
    Map<String, List<dynamic>> categories = await userDataCollection.document(uid).get().then((result) {
      return Map<String, List<dynamic>>.from(result.data['categories']);
    });
    return List<String>.from(categories.keys);
    // return userDataCollection.document(uid).snapshots()
    //   .map(_categoriesListFromSnapshot);
  }

}