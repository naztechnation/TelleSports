import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/widgets/modals.dart';
 

 
import '../../../../common/repositories/common_firebase_storage_repository.dart';
import '../../../../model/chat_model/user_model.dart';


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

  Future<UserModel?> getCurrentUserData() async {
    String userId = await StorageHandler.getUserId() ?? '';
    var userData =
        await firestore.collection('users').doc(userId).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
          String userId = await StorageHandler.getUserId() ?? '';

      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'profilePic/$userId',
              profilePic,
            );
      }

      var user = UserModel(
        name: name,
        uid: userId,
        profilePic: photoUrl,
        isOnline: true,
        email: '08032884565',
        groupId: [], numberOfGroups: 0,
      );

      await firestore.collection('users').doc(userId).set(user.toMap());

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const MobileLayoutScreen(),
      //   ),
      //   (route) => false,
      // );
    } catch (e) {
      Modals.showToast(e.toString());

    }
  }

  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  void setUserState(bool isOnline) async {
          String userId = await StorageHandler.getUserId() ?? '';

    await firestore.collection('users').doc(userId).update({
      'isOnline': isOnline,
    });
  }
}
