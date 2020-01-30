import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference userDatacollection = Firestore.instance.collection('userData');

  Future<void> updateUserData(String accessToken, Map<String, List<String>> categories, List<String> subscriptions) async {
    return await userDatacollection.document(uid).setData({
      'accessToken': accessToken,
      'categories': categories,
      'subscriptions': subscriptions,
    });
  }

  Future<void> updateUserAccessToken(String accessToken) async {
    return await userDatacollection.document(uid).setData({
      'accessToken': accessToken,
    });
  }

}