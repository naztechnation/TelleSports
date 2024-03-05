import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/chats/user.dart' as app;
import '../../../../res/app_strings.dart';

/// provider to get AuthRepository.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository( FirebaseFirestore.instance),
);

class AuthRepository {
  AuthRepository( FirebaseFirestore firestore)
      
       : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// Invoke to signIn user with phone number.
 

  /// Invoke to verify otp.
 

  /// invoke to get user data form firestore.
  Stream<app.User> getReceiverUserData(String receiverUserId) {
    return _firestore
        .collection(AppStrings.usersCollection)
        .doc(receiverUserId)
        .snapshots()
        .map(
          (snapshot) => app.User.fromMap(snapshot.data()!),
        );
  }
}
