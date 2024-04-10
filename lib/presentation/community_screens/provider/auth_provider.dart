import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/model/view_models/account_view_model.dart';
import 'package:tellesports/presentation/landing_page/landing_page.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart' as pro;

import '../../../common/enums/message_enum.dart';
import '../../../common/providers/message_reply_provider.dart';
import '../../../common/repositories/common_firebase_storage_repository.dart';
import '../../../model/chat_model/chat_contact.dart';
import '../../../model/chat_model/group.dart';
import '../../../model/chat_model/group.dart' as model;
import '../../../model/chat_model/message.dart';
import '../../../model/chat_model/user_model.dart';
import '../../../model/matches_data/match_fixtures.dart';
import '../../../widgets/modals.dart';

enum AuthState { loading, initial, error, success }

enum AuthScreenState { login, register }

final GoogleSignIn googleSignIn = GoogleSignIn();

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

class AuthProviders extends ChangeNotifier {
  String _message = '';
  AuthState _dataStatus = AuthState.initial;
  AuthScreenState _isLogin = AuthScreenState.login;
  File? _image;
  bool _isUserExisting = false;
  String _groupNumber = '1';
  String _groupDescription = '';
  String _messageId = '';
  MessageEnum _type = MessageEnum.none;
  List<UserModel> _users = [];
  List<UserModel> _blockedUsers = [];
  List<UserModel> _requestedUsers = [];
  bool _isGroupLocked = false;
  bool _isSelectedText = false;
  String _groupLink = '';
  String _groupId = '';
  String _groupName = '';
  String _groupPics = '';
  String _groupAdminId = '';
  String _groupPinnedMessage = '';
  String _selectedMessage = '';
  List<String> _groupImageList = [];
  int _textIndex = -1;
  ScrollController _scrollController = ScrollController();

  ImagePicker picker = ImagePicker();

  List<Group> _searchResult = [];

  List<Group> _dummyData = [];

  List<Response> _liveMatchResult = [];

  List<Response> _liveDummyData = [];

  List<Group> _searchResult1 = [];

  List<Group> _dummyData1 = [];

  clearGroupInfo() {
    _users = [];

    notifyListeners();
  }

  loadImage(BuildContext context) async {
    await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Text('Select the images source',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  size: 35.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);

                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 5,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  _image = File(image!.path);
                  notifyListeners();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo,
                  size: 35.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 5,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  _image = File(image!.path);
                  notifyListeners();
                },
              ),
            ],
          );
        });
  }

  changeState(AuthScreenState authScreenState) {
    _isLogin = authScreenState;
    notifyListeners();
  }

  _setStatus(AuthState status) {
    _dataStatus = status;
    notifyListeners();
  }

  setTextIndex(int textIndex) {
    _textIndex = textIndex;
    notifyListeners();
  }

  setMessageId(String messageId) {
    _messageId = messageId;
    notifyListeners();
  }

  setMessageType(MessageEnum type) {
    _type = type;
    notifyListeners();
  }

  setSelectedMessage(String selectedMessage) {
    _selectedMessage = selectedMessage;
    notifyListeners();
  }

  isSelectedMessage(bool selectedMessage) {
    _isSelectedText = selectedMessage;
    notifyListeners();
  }

  _updateMessage(String message) {
    _message = message;
    notifyListeners();
  }

  clearGroupImageList() {
    _groupImageList.clear();
    notifyListeners();
  }

  updateGroupImageList(String groupImages) {
    _groupImageList.add(groupImages);
    notifyListeners();
  }

  void filterSearchResults(String query) {
    List<Group> dummySearchList = [];
    dummySearchList.addAll(_dummyData);
    if (query.isNotEmpty) {
      List<Group> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });

      _searchResult.clear();
      _searchResult.addAll(dummyListData);

      notifyListeners();

      return;
    } else {
      _searchResult.clear();
      _searchResult.addAll(_dummyData);
      notifyListeners();
    }
  }

  

  void filterSearchResults1(String query) {
    List<Group> dummySearchList = [];
    dummySearchList.addAll(_dummyData1);
    if (query.isNotEmpty) {
      List<Group> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });

      _searchResult1.clear();
      _searchResult1.addAll(dummyListData);

      notifyListeners();

      return;
    } else {
      _searchResult1.clear();
      _searchResult1.addAll(_dummyData);
      notifyListeners();
    }
  }

  updateSearchList(
    List<Group> searchList,
  ) {
    _searchResult.addAll(searchList);
    _dummyData.addAll(searchList);

    notifyListeners();
  }

  updateLiveScoreSearchList(
    List<Response> searchList,
  ) {
    _liveMatchResult.addAll(searchList);
    _liveDummyData.addAll(searchList);

    notifyListeners();
  }

  clearliveScoreSearchList() {
    _liveMatchResult.clear();
    _liveDummyData.clear();

    notifyListeners();
  }

  clearSearchList() {
    _searchResult.clear();
    _dummyData.clear();

    notifyListeners();
  }

  clearSearchList1() {
    _searchResult1.clear();
    _dummyData1.clear();

    notifyListeners();
  }

  updateSearchList1(
    List<Group> searchList,
  ) {
    _searchResult1.addAll(searchList);
    _dummyData1.addAll(searchList);

    notifyListeners();
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> registerUserWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      _setStatus(AuthState.loading);
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await uploadImage(email, username, password);
    } on FirebaseAuthException catch (e) {
      _setStatus(AuthState.error);
      _updateMessage(e.code);
    }
  }

  uploadImage(email, username, password) async {
    String userId = await StorageHandler.getUserId() ?? '';
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('${userId}.jpg');

      await storageRef.putFile(image!);

      final imageUrl = await storageRef.getDownloadURL();

      

      await uploadUserDetails(
          userId: userId, username: username, email: email, imageUrl: imageUrl);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserModel> retrieveUserData() async {
    Map<String, dynamic> data = <String, dynamic>{};

    String userId = await StorageHandler.getUserId() ?? '';
    try {
      _setStatus(AuthState.loading);
      final DocumentSnapshot documentSnapshot =
          await _firebaseStorage.collection('users').doc(userId).get();

      if (documentSnapshot.exists) {
        _setStatus(AuthState.success);
        _updateMessage('successful');

        data = documentSnapshot.data() as Map<String, dynamic>;
      } else {}
    } catch (error) {
      _setStatus(AuthState.error);
      _updateMessage(error.toString());
    }
    return UserModel.fromMap(data);
  }

  Future<void> uploadUserDetails(
      {required String userId,
      required String username,
      required String email,
      required String imageUrl}) async {
    try {
      _setStatus(AuthState.loading);

      var user = UserModel(
        name: username,
        uid: userId,
        profilePic: imageUrl,
        isOnline: true,
        email: email,
        numberOfGroups: 0,
        groupId: [],
        bio: '',
      );

      await _firebaseStorage.collection('users').doc(userId).set(user.toMap());

      _setStatus(AuthState.success);

      _updateMessage('Registration Successful');
    } catch (e) {
      _setStatus(AuthState.error);
      _updateMessage(e.toString());
    }

    return;
  }

  Future<bool> checkUserGroupLimit(
      {required String userId,
      required BuildContext context,
      required String name,
      required String groupDesc,
      required File profilePic,
      var ref}) async {
    var userDoc = await _firebaseStorage.collection('users').doc(userId).get();

    var currentNumberOfGroups = userDoc['numberOfGroups'];

    if (currentNumberOfGroups < 3) {
      await createGroup(context, name, groupDesc, profilePic, ref);

      return true;
    } else {
      Modals.showToast('Opps you cant create more than 3 groups');
      return false;
    }
  }

  UpdateGroupCount({
    required String userId,
    required int groupNumber,
  }) async {
    await _firebaseStorage.collection('users').doc(userId).update({
      'numberOfGroups': groupNumber,
    });
  }

  Future<void> updateUserBio(String userId, String currentBio) async {
    try {
      await _firebaseStorage.collection('users').doc(userId).update({
        'bio': currentBio,
      });
      Modals.showToast('Bio updated successfully');
      notifyListeners();
    } catch (error) {
      Modals.showToast('Error updating bio');
    }
  }

  Future<void> createGroup(BuildContext context, String name, String groupDesc,
      File profilePic, var ref) async {
    String userId = await StorageHandler.getUserId() ?? '';
    try {
      List<String> uids = [];

      var groupId = const Uuid().v1();
      var groupLink = const Uuid().v4();

      String profileUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            'group/$groupId',
            profilePic,
          );
      model.Group group = model.Group(
        pinnedMessage: '',
        isGroupLocked: false,
        groupLink: 'telesportcommunity.com/${groupLink}',
        senderId: userId,
        name: name,
        groupId: groupId,
        lastMessage: '',
        groupPic: profileUrl,
        membersUid: [userId, ...uids],
        timeSent: DateTime.now(),
        groupDescription: groupDesc,
        blockedMembers: [],
        requestsMembers: [],
      );

      await _firebaseStorage
          .collection('groups')
          .doc(groupId)
          .set(group.toMap());
    } catch (e) {
      Modals.showToast(e.toString());
    }
  }

  Future<List<UserModel>> fetchUsers(List<String> membersUid) async {
    try {
      final List<UserModel> users = [];

      for (String userId in membersUid) {
        final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userSnapshot.exists) {
          final Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          final UserModel user = UserModel(
            uid: userId,
            name: userData['name'],
            email: userData['email'],
            profilePic: userData['profilePic'],
            isOnline: userData['isOnline'],
            numberOfGroups: userData['numberOfGroups'],
            bio: userData['bio'],
            groupId: [],
          );

          users.add(user);
        }
      }
      _users = users;
      return users;
    } catch (error) {
      print('Error fetching users: $error');
      return [];
    }
  }

  Future<List<UserModel>> requestedUsers(List<String> membersUid) async {
    try {
      final List<UserModel> users = [];

      for (String userId in membersUid) {
        final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userSnapshot.exists) {
          final Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          final UserModel user = UserModel(
            uid: userId,
            name: userData['name'],
            email: userData['email'],
            profilePic: userData['profilePic'],
            isOnline: userData['isOnline'],
            numberOfGroups: userData['numberOfGroups'],
            bio: userData['bio'],
            groupId: [],
          );

          users.add(user);
        }
      }
      _requestedUsers = users;
      notifyListeners();
      return _requestedUsers;
    } catch (error) {
      print('Error fetching users: $error');
      return [];
    }
  }

  Future<List<UserModel>> blockedUsers(List<String> membersUid) async {
    try {
      final List<UserModel> users = [];

      for (String userId in membersUid) {
        final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userSnapshot.exists) {
          final Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          final UserModel user = UserModel(
            uid: userId,
            name: userData['name'],
            email: userData['email'],
            profilePic: userData['profilePic'],
            isOnline: userData['isOnline'],
            numberOfGroups: userData['numberOfGroups'],
            groupId: [],
            bio: userData['bio'],
          );

          users.add(user);
        }
      }
      notifyListeners();

      _blockedUsers = users;
      return users;
    } catch (error) {
      print('Error fetching users: $error');
      return [];
    }
  }

  Future<void> updateUserProfile() async {
    String userId = await StorageHandler.getUserId() ?? '';

    try {
      if (image != null) {
        _setStatus(AuthState.loading);

        final storageRef = FirebaseStorage.instance.ref().child('status');

        await storageRef.putFile(image!);

        final imageUrl = await storageRef.getDownloadURL();

        final userDocRef = _firebaseStorage.collection('users').doc(userId);

        await userDocRef.update({
          'profilePic': imageUrl,
        });
        _setStatus(AuthState.success);
        _updateMessage('Update Successful');
      }
    } catch (e) {
      _setStatus(AuthState.error);
      _updateMessage(e.toString());
    }
  }

  Future<void> updateGroupProfile(
      String groupId, File? images, String? bio) async {
    final userDocRef =
        FirebaseFirestore.instance.collection('groups').doc(groupId);

    try {
      if (images != null && bio != null) {
        _setStatus(AuthState.loading);

        final storageRef = FirebaseStorage.instance.ref().child('group');

        await storageRef.putFile(images);

        final imageUrl = await storageRef.getDownloadURL();

        await userDocRef.update({
          'groupPic': imageUrl,
        });
        await userDocRef.update({
          'groupDesc': bio,
        });
        _setStatus(AuthState.success);
        _updateMessage('Update Successful');
      } else if (images != null && bio == null) {
        _setStatus(AuthState.loading);

        final storageRef = FirebaseStorage.instance.ref().child('group');

        await storageRef.putFile(images);

        final imageUrl = await storageRef.getDownloadURL();

        await userDocRef.update({
          'groupPic': imageUrl,
        });
      } else if (bio != null && images == null) {
        await userDocRef.update({
          'groupDesc': bio,
        });
      }
    } catch (e) {
      _setStatus(AuthState.error);
      _updateMessage(e.toString());
    }
  }

  Stream<List<Group>> getChatGroups() {
    return _firebaseStorage.collection('groups').snapshots().map((event) {
      List<Group> groups = [];
      for (var document in event.docs) {
        var group = Group.fromMap(document.data());
        groups.add(group);
      }
      return groups;
    });
  }

  Stream<List<Group>> getUserGroups(String userId) {
    return _firebaseStorage.collection('groups').snapshots().map((event) {
      List<Group> groups = [];

      for (var document in event.docs) {
        var group = Group.fromMap(document.data());

        if (group.senderId == userId) {
          groups.add(group);
        }
      }

      return groups;
    });
  }

  Future<List<Group>> getUserGroups1(String userId) async {
    var querySnapshot = await _firebaseStorage.collection('groups').get();
    List<Group> groups = [];

    querySnapshot.docs.forEach((document) {
      var group = Group.fromMap(document.data());

      if (group.senderId == userId) {
        groups.add(group);
      }
    });

    return groups;
  }

  addGroupInfo(
      {required String groupNumber,
      required String groupLink,
      required String groupDesription,
      required String pinnedMessage,
      required bool isGroupLocked,
      required String groupId,
      required String groupName,
      required String groupPics,
      required String groupAdminId}) {
    _groupNumber = groupNumber;
    _groupDescription = groupDesription;
    _groupLink = groupLink;
    _groupId = groupId;
    _groupName = groupName;
    _groupPics = groupPics;
    _groupAdminId = groupAdminId;
    _groupPinnedMessage = pinnedMessage;
    notifyListeners();
  }

  Stream<List<Group>> getAllChatGroups(String userId) {
    return _firebaseStorage.collection('groups').snapshots().map((event) {
      List<Group> groups = [];
      for (var document in event.docs) {
        var group = Group.fromMap(document.data());
        groups.add(group);

        if (group.membersUid.contains(userId)) {
          _isUserExisting = true;

          fetchUsers(group.membersUid);
        } else {
          _isUserExisting = false;
        }


      }

       _setStatus(AuthState.success);
      return groups;
    });
  }

  Future<void> removeCurrentUserFromMembers(
      String groupId, String currentUserId, BuildContext context) async {
    try {
      final DocumentReference groupDocRef =
          FirebaseFirestore.instance.collection('groups').doc(groupId);

      final DocumentSnapshot groupSnapshot = await groupDocRef.get();

      if (groupSnapshot.exists) {
        final Map<String, dynamic> groupData =
            groupSnapshot.data() as Map<String, dynamic>;

        if (groupData.containsKey('membersUid') &&
            groupData['membersUid'] is List) {
          final List<dynamic> membersUid = groupData['membersUid'];
          membersUid.remove(currentUserId);

          await groupDocRef.update({'membersUid': membersUid});

          if (context.mounted) {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => const MobileLayoutScreen()));
          }
        }
      }
    } catch (error) {
      print('Error removing user from members: $error');
    }
  }

  Future<void> removeCurrentUserFromRequestsMembers(
      String groupId, String currentUserId, BuildContext context) async {
    try {
      final DocumentReference groupDocRef =
          FirebaseFirestore.instance.collection('groups').doc(groupId);

      final DocumentSnapshot groupSnapshot = await groupDocRef.get();

      if (groupSnapshot.exists) {
        final Map<String, dynamic> groupData =
            groupSnapshot.data() as Map<String, dynamic>;

        if (groupData.containsKey('requestsMembers') &&
            groupData['requestsMembers'] is List) {
          final List<dynamic> membersUid = groupData['requestsMembers'];
          membersUid.remove(currentUserId);

          await groupDocRef.update({'requestsMembers': membersUid});
          await addCurrentUserFromMembers(groupId, currentUserId, context);

          if (context.mounted) {
    final user = pro.Provider.of<AccountViewModel>(context, listen: false);
          user.updateIndex(0);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LandingPage()));
          }
        }
      }
    } catch (error) {
      print('Error removing user from members: $error');
    }
  }

  Future<void> removeCurrentUserFromBlockedMembers(
      String groupId, String currentUserId, BuildContext context) async {
    try {
      final DocumentReference groupDocRef =
          FirebaseFirestore.instance.collection('groups').doc(groupId);

      final DocumentSnapshot groupSnapshot = await groupDocRef.get();

      if (groupSnapshot.exists) {
        final Map<String, dynamic> groupData =
            groupSnapshot.data() as Map<String, dynamic>;

        if (groupData.containsKey('blockedMembers') &&
            groupData['blockedMembers'] is List) {
          final List<dynamic> membersUid = groupData['blockedMembers'];
          membersUid.remove(currentUserId);

          await groupDocRef.update({'blockedMembers': membersUid});
          await addCurrentUserFromMembers(groupId, currentUserId, context);

          if (context.mounted) {
            if (context.mounted) {
              final user = pro.Provider.of<AccountViewModel>(context, listen: false);
          user.updateIndex(0);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LandingPage()));
            }
          }
        }
      }
    } catch (error) {
      print('Error removing user from members: $error');
    }
  }

  Future<void> addCurrentUserFromMembers(
      String groupId, String currentUserId, BuildContext context) async {
    try {
      final DocumentReference groupDocRef =
          FirebaseFirestore.instance.collection('groups').doc(groupId);

      final DocumentSnapshot groupSnapshot = await groupDocRef.get();

      if (groupSnapshot.exists) {
        final Map<String, dynamic> groupData =
            groupSnapshot.data() as Map<String, dynamic>;

        if (groupData.containsKey('membersUid') &&
            groupData['membersUid'] is List) {
          final List<dynamic> membersUid = groupData['membersUid'];
          membersUid.add(currentUserId);

          await groupDocRef.update({'membersUid': membersUid});

          if (context.mounted) {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => const MobileLayoutScreen()));
          }
        }
      }
    } catch (error) {
      print('Error removing user from members: $error');
    }
  }

  Future<void> addUserToRequestsMembers(
      String groupId, String currentUserId, BuildContext context) async {
    try {
      final DocumentReference groupDocRef =
          FirebaseFirestore.instance.collection('groups').doc(groupId);

      final DocumentSnapshot groupSnapshot = await groupDocRef.get();

      if (groupSnapshot.exists) {
        final Map<String, dynamic> groupData =
            groupSnapshot.data() as Map<String, dynamic>;

        if (groupData.containsKey('requestsMembers') &&
            groupData['requestsMembers'] is List) {
          final List<dynamic> requestsUid = groupData['requestsMembers'];
          requestsUid.add(currentUserId);

          await groupDocRef.update({'requestsMembers': requestsUid});
        }
      }
    } catch (error) {
      print('Error removing user from members: $error');
    }
  }

  Future<void> addUserToBlockedMembers(
      String groupId, String currentUserId, BuildContext context) async {
    try {
      final DocumentReference groupDocRef =
          FirebaseFirestore.instance.collection('groups').doc(groupId);

      final DocumentSnapshot groupSnapshot = await groupDocRef.get();

      if (groupSnapshot.exists) {
        final Map<String, dynamic> groupData =
            groupSnapshot.data() as Map<String, dynamic>;

        if (groupData.containsKey('blockedMembers') &&
            groupData['blockedMembers'] is List) {
          final List<dynamic> blockedUid = groupData['blockedMembers'];
          blockedUid.add(currentUserId);

          await groupDocRef.update({'blockedMembers': blockedUid});
        }
      }
    } catch (error) {
      print('Error removing user from members: $error');
    }
  }

  Future<void> deleteGroup(String groupId, BuildContext context) async {
    try {
      final DocumentReference groupDocRef =
          FirebaseFirestore.instance.collection('groups').doc(groupId);

      await groupDocRef.delete();
      if (context.mounted) {}
    } catch (error) {
      print('Error deleting group: $error');
    }
  }

  Future<void> updateGroupLockStatus(String groupId, bool isGroupLocked) async {
    try {
      final DocumentReference groupDocRef =
          FirebaseFirestore.instance.collection('groups').doc(groupId);

      await groupDocRef.update({'isGroupLocked': isGroupLocked});

      _isGroupLocked = isGroupLocked;
      notifyListeners();
    } catch (error) {
      print('Error updating group lock status: $error');
    }
  }

  Future<void> updateGroupLink(String groupId, String groupLink) async {
    try {
      final DocumentReference groupDocRef =
          FirebaseFirestore.instance.collection('groups').doc(groupId);

      await groupDocRef.update({'groupLink': groupLink});
    } catch (error) {
      print('Error updating group lock status: $error');
    }
  }

  Future<void> updateGroupPinnedMessage(
      String groupId, String groupPinnedMessage) async {
    try {
      final DocumentReference groupDocRef =
          FirebaseFirestore.instance.collection('groups').doc(groupId);

      await groupDocRef.update({'pinnedMessage': groupPinnedMessage});
      _groupPinnedMessage = groupPinnedMessage;
      isSelectedMessage(false);
      setSelectedMessage('');

      setTextIndex(-1);
      setMessageId('');
      notifyListeners();
    } catch (error) {
      print('Error updating group lock status: $error');
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      _setStatus(AuthState.loading);
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _setStatus(AuthState.success);

      _updateMessage('Login in  Successful');
    } on FirebaseAuthException catch (e) {
      _setStatus(AuthState.error);
      _updateMessage(e.code);
    }
  }

  Future<void> resetPassword(String email) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      _setStatus(AuthState.loading);
      await auth.sendPasswordResetEmail(email: email);
      _setStatus(AuthState.success);

      _updateMessage('A password reset link has been sent to your mail');
    } catch (error) {
      _setStatus(AuthState.error);
      _updateMessage(error.toString());
    }
  }

  Future<void> deleteChatMessage({
    required String recieverUserId,
    required String userId,
    required String messageId,
  }) async {
    try {
      await _firebaseStorage
          .collection('groups')
          .doc(recieverUserId)
          .collection('chats')
          .doc(messageId)
          .delete();

      isSelectedMessage(false);
      setSelectedMessage('');

      setTextIndex(-1);
      setMessageId('');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;

      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print(user.toString());
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
    return null;
  }

  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel? recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
    String userId,
    bool isGroupChat,
  ) async {
    if (isGroupChat) {
      await _firebaseStorage.collection('groups').doc(recieverUserId).update({
        'lastMessage': text,
        'timeSent': DateTime.now().millisecondsSinceEpoch,
      });
    } else {
// users -> reciever user id => chats -> current user id -> set data
      var recieverChatContact = ChatContact(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: text,
      );
      await _firebaseStorage
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(userId)
          .set(
            recieverChatContact.toMap(),
          );
      // users -> current user id  => chats -> reciever user id -> set data
      var senderChatContact = ChatContact(
        name: recieverUserData!.name,
        profilePic: recieverUserData.profilePic,
        contactId: recieverUserData.uid,
        timeSent: timeSent,
        lastMessage: text,
      );
      await _firebaseStorage
          .collection('users')
          .doc(userId)
          .collection('chats')
          .doc(recieverUserId)
          .set(
            senderChatContact.toMap(),
          );
    }
  }

  void _saveMessageToMessageSubcollection({
    required String recieverUserId,
    required String userId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required MessageEnum messageType,
    required MessageReply? messageReply,
    required String senderUsername,
    required String? recieverUserName,
    required bool isGroupChat,
  }) async {
    final message = Message(
      senderId: userId,
      recieverid: recieverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      repliedMessage: messageReply == null ? '' : messageReply.message,
      repliedTo: messageReply == null
          ? ''
          : messageReply.isMe
              ? senderUsername
              : recieverUserName ?? '',
      repliedMessageType:
          messageReply == null ? MessageEnum.text : messageReply.messageEnum,
      username: senderUsername,
    );
    if (isGroupChat) {
      // groups -> group id -> chat -> message

      print('listening');

      await _firebaseStorage
          .collection('groups')
          .doc(recieverUserId)
          .collection('chats')
          .doc(messageId)
          .set(
            message.toMap(),
          );
      print('listening');
    } else {
      // users -> sender id -> reciever id -> messages -> message id -> store message
      await _firebaseStorage
          .collection('users')
          .doc(userId)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .set(
            message.toMap(),
          );
      // users -> eciever id  -> sender id -> messages -> message id -> store message
      await _firebaseStorage
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(userId)
          .collection('messages')
          .doc(messageId)
          .set(
            message.toMap(),
          );
    }
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required String userId,
    required UserModel senderUser,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel? recieverUserData;

      if (!isGroupChat) {
        var userDataMap = await _firebaseStorage
            .collection('users')
            .doc(recieverUserId)
            .get();
        recieverUserData = UserModel.fromMap(userDataMap.data()!);
      }

      var messageId = const Uuid().v1();

      _saveDataToContactsSubcollection(
        senderUser,
        recieverUserData,
        text,
        timeSent,
        recieverUserId,
        userId,
        isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        username: senderUser.name,
        messageReply: messageReply,
        recieverUserName: recieverUserData?.name,
        senderUsername: senderUser.name,
        isGroupChat: isGroupChat,
        userId: userId,
      );
    } catch (e) {
      Modals.showToast(e.toString());
    }
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String recieverUserId,
    required String userId,
    required UserModel senderUserData,
    required ProviderRef ref,
    required MessageEnum messageEnum,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();

      String imageUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            'chat/${messageEnum.type}/${senderUserData.uid}/$recieverUserId/$messageId',
            file,
          );

      UserModel? recieverUserData;
      if (!isGroupChat) {
        var userDataMap = await _firebaseStorage
            .collection('users')
            .doc(recieverUserId)
            .get();
        recieverUserData = UserModel.fromMap(userDataMap.data()!);
      }

      String contactMsg;

      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.gif:
          contactMsg = 'GIF';
          break;
        default:
          contactMsg = 'GIF';
      }
      _saveDataToContactsSubcollection(
        senderUserData,
        recieverUserData,
        contactMsg,
        timeSent,
        recieverUserId,
        userId,
        isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        userId: userId,
        text: imageUrl,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUserData.name,
        messageType: messageEnum,
        messageReply: messageReply,
        recieverUserName: recieverUserData?.name,
        senderUsername: senderUserData.name,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      Modals.showToast(e.toString());
    }
  }

  String get message => _message;
  int get textIndex => _textIndex;
  String get selectedMessage => _selectedMessage;
  String get groupPinnedMessage => _groupPinnedMessage;
  String get groupLink => _groupLink;
  String get messageId => _messageId;
  String get groupId => _groupId;
  String get groupAdminId => _groupAdminId;
  String get groupNumber => _groupNumber;
  String get groupName => _groupName;
  String get groupPics => _groupPics;
  MessageEnum get messageType => _type;
  String get groupDescription => _groupDescription;
  bool get isSelected => _isSelectedText;
  AuthScreenState get isLogin => _isLogin;
  AuthState get dataStatus => _dataStatus;
  File? get image => _image;
  bool get isUserExisting => _isUserExisting;
  bool get isGroupLocked => _isGroupLocked;
  ScrollController get scrollController => _scrollController;
  List<UserModel> get groupMembers => _users;
  List<String> get groupImageList => _groupImageList;
  List<UserModel> get blockedMembers => _blockedUsers;
  List<UserModel> get requestedMembers => _requestedUsers;
  List<Group> get searchResult => _searchResult;
  List<Response> get liveScoreResult => _liveMatchResult;
  List<Group> get dummyData => _dummyData;
  List<Group> get searchResult1 => _searchResult1;
  List<Group> get dummyData1 => _dummyData1;
}
