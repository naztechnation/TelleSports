import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tellesports/res/app_strings.dart';
import 'package:tellesports/widgets/modals.dart';
import 'package:uuid/uuid.dart';
import '../../../../model/chats/group.dart';
import '../../../../model/chats/user.dart' as  app;
import '../../../../requests/repositories/firebase_storage_repository.dart';


final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  return GroupRepository(FirebaseFirestore.instance, ref);
});

class GroupRepository {
  GroupRepository(FirebaseFirestore firestore, ProviderRef ref)
      : _firestore = firestore,
        _ref = ref;
  final FirebaseFirestore _firestore;
  final ProviderRef _ref;

  Future<void> createGroup(
    bool mounted,
    BuildContext context, {
    required String currentUserId,
    required String groupName,
    required File? groupProfilePic,
  }) async {
    try {
      List<String> uIds = [];
      String groupId = const Uuid().v1();

      // getting list of users from firestore
      final querySnapshot =
          await _firestore.collection(AppStrings.usersCollection).get();
      // loop to got (doc) snapshots from querySnapshots
      for (var snapshot in querySnapshot.docs) {
        app.User user = app.User.fromMap(snapshot.data());

        // loop to compare selectedContacts number with firebase users
        // to check if the selected users exists in our app
       
      }

      // uploading our groupProfilePic to firebase storage and get url
      if (!mounted) return;
      String groupProfilePicUrl = await _ref
          .read(firebaseStorageRepositoryProvider)
          .storeFileToFirebaseStorage(
            context,
            file: groupProfilePic!,
            path: 'groups',
            fileName: groupId,
          );

      // creating group instance
      final Group group = Group(
        groupName: groupName,
        groupId: groupId,
        groupProfilePic: groupProfilePicUrl,
        lastMessage: '',
        lastMessageUserSenderId: currentUserId,
        time: DateTime.now(),
        selectedMembersUIds: [currentUserId, ...uIds],
      );

      await _firestore
          .collection(AppStrings.groupsCollection)
          .doc(groupId)
          .set(group.toMap());
    } catch (e) {
      Modals.showToast(e.toString());
    }
  }
}
