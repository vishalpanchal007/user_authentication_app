import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static FireStoreHelper fireStoreHelper = FireStoreHelper._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<DocumentReference> registerData(
  {required Map<String, dynamic> data}) async {
    DocumentReference<Map<String,dynamic>> documentReference = await firebaseFirestore.collection('Register').add(data);
    return documentReference;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> loginData() {
    return firebaseFirestore.collection('Register').snapshots();
  }

  Future<void> updateUserData(
  {required Map<String, dynamic> data, required String id}) async {
    await firebaseFirestore.collection('Register').doc(id).update(data);
  }

  Future<void> deleteUserData({required String id}) async {
    await firebaseFirestore.collection('Register').doc(id).delete();
  }
}