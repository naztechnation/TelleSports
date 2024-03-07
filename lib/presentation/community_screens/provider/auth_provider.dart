import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/presentation/landing_page/landing_page.dart';

import '../../../model/chat_model/group.dart';
import '../../../model/chat_model/user_model.dart';
 

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

  ImagePicker picker = ImagePicker();

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
                      imageQuality: 80,
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
                      imageQuality: 80,
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

  clearGroupImageList( ){
    _groupImageList.clear();
    notifyListeners();

  }

  updateGroupImageList(String groupImages){
    _groupImageList.add(groupImages);
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

    String userId  = await StorageHandler.getUserId() ?? '';
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('${userId}.jpg');

      await storageRef.putFile(image!);

      final imageUrl = await storageRef.getDownloadURL();

      await uploadUserDetails(
          userId: userId, username: username, email:email,imageUrl:  imageUrl);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserModel> retrieveUserData() async {
    Map<String, dynamic> data = <String, dynamic>{};

    String userId = await StorageHandler.getUserId() ??  '';
    try {
      _setStatus(AuthState.loading);
      final DocumentSnapshot documentSnapshot = await _firebaseStorage
          .collection('users')
          .doc(userId)
          .get();

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

  Future<void> uploadUserDetails({required String userId,required String username,required String email,
     required  String imageUrl}) async {
    try {
      _setStatus(AuthState.loading);

      var user = UserModel(
        name: username,
        uid: userId,
        profilePic: imageUrl,
        isOnline: true,
        email: email,
        groupId: [],
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
            groupId: [],
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

    String userId = await StorageHandler.getUserId() ??  '';

    try {
      if (image != null) {
        _setStatus(AuthState.loading);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${userId}.jpg');

        await storageRef.putFile(image!);

        final imageUrl = await storageRef.getDownloadURL();

        final userDocRef = _firebaseStorage
            .collection('users')
            .doc(userId);

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
    _groupDescription =  groupDesription;
    _groupLink = groupLink;
    _groupId = groupId;
    _groupName = groupName;
    _groupPics = groupPics;
    _groupAdminId = groupAdminId;
    _groupPinnedMessage = pinnedMessage;
    notifyListeners();
  }

  Stream<List<Group>> getAllChatGroups(String  userId) {
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
          await addCurrentUserFromMembers(groupId,currentUserId, context);

          if (context.mounted) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LandingPage()));
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
          await addCurrentUserFromMembers(groupId,currentUserId, context);

          if (context.mounted) {
            if (context.mounted) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LandingPage()));
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

      // Delete the document
      await groupDocRef.delete();
      if (context.mounted) {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => const MobileLayoutScreen()));
      }
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

  Future<void> updateGroupPinnedChat(
      String groupId, String groupPinnedMessage) async {
    try {
      final DocumentReference groupDocRef =
          FirebaseFirestore.instance.collection('groups').doc(groupId);

      await groupDocRef.update({'pinnedMessage': groupPinnedMessage});
      _groupPinnedMessage = groupPinnedMessage;
      isSelectedMessage(false);
      setSelectedMessage('');

      setTextIndex(-1);
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

  String get message => _message;
  int get textIndex => _textIndex;
  String get selectedMessage => _selectedMessage;
  String get groupPinnedMessage => _groupPinnedMessage;
  String get groupLink => _groupLink;
  String get groupId => _groupId;
  String get groupAdminId => _groupAdminId;
  String get groupNumber => _groupNumber;
  String get groupName => _groupName;
  String get groupPics => _groupPics;
  String get groupDescription => _groupDescription;
  bool get isSelected => _isSelectedText;
  AuthScreenState get isLogin => _isLogin;
  AuthState get dataStatus => _dataStatus;
  File? get image => _image;
  bool get isUserExisting => _isUserExisting;
  bool get isGroupLocked => _isGroupLocked;
  List<UserModel> get groupMembers => _users;
  List<String> get groupImageList => _groupImageList;
  List<UserModel> get blockedMembers => _blockedUsers;
  List<UserModel> get requestedMembers => _requestedUsers;
}
