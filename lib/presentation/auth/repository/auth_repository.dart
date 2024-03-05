import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/chats/user.dart' as app;
import '../../../widgets/modals.dart';
import 'common_firebase_storage_repository.dart';


final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.firestore,
  });

  Future<app.User?> getCurrentUserData(String userId) async {
    var userData =
        await firestore.collection('users').doc(userId).get();

    app.User? user;
    if (userData.data() != null) {
      user = app.User.fromMap(userData.data()!);
    }
    return user;
  }

  



  Future<void> saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required String  userId,
    required BuildContext context,
  }) async {
    try {
      String uid = userId;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'profilePic/$uid',
              profilePic,
            );
      }

      var user = app.User(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: '',
        groupId: [],
      );

      await firestore.collection('users').doc(uid).set(user.toMap());

       
    } catch (e) {

      Modals.showToast(e.toString());
    }
  }

  Stream<app.User> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => app.User.fromMap(
            event.data()!,
          ),
        );
  }

  void setUserState(bool isOnline, String userId) async {
    await firestore.collection('users').doc(userId).update({
      'isOnline': isOnline,
    });
  }
}
