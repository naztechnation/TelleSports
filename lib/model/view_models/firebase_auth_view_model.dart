import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tellesports/widgets/modals.dart';

import '../../core/constants/enums.dart';
import '../../handlers/secure_handler.dart';
import '../../presentation/auth/sign_in_screen/sign_in_screen.dart' as login;
import '../../utils/navigator/page_navigator.dart';
import 'base_viewmodel.dart';

class FirebaseAuthProvider extends BaseViewModel {
  FirebaseAuthProvider() {
    getToken();
  }

  String _token = "";

  String _successMessage = '';
  bool _status = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  setToken(String token) async {
    _token = token;

    StorageHandler.saveUserToken(_token);
    setViewState(ViewState.success);
  }

  getToken() async {
    _token = await StorageHandler.getUserToken() ?? '';
    setViewState(ViewState.success);
  }

  Future<User?> signInWithGoogle() async {
    try {
      _status = true;
      setViewState(ViewState.success);

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        _successMessage = 'Authentication canceled';
        _status = false;
        setViewState(ViewState.success);

        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;

      if (authResult != null) {
        Map<String, dynamic> userInfo = {
          "email": user!.email,
          "name": user.displayName,
          "imageUrl": user.photoURL,
          "id": user.uid,
        };
      }

      _successMessage = 'Authentication successful';
      _status = false;
      setViewState(ViewState.success);

      return user;
    } catch (error) {
      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'account-exists-with-different-credential':
            _successMessage = 'Account already exists';
            _status = false;
            break;
          case 'invalid-credential':
            _successMessage = 'Invalid credential';
            _status = false;
            break;
          case 'operation-not-allowed':
            _successMessage = 'Operation not allowed';
            _status = false;
            break;
          case 'user-disabled':
            _successMessage =
                'User account has been disabled by an administrator';
            _status = false;
            break;
          case 'user-not-found':
            _successMessage = 'User not found';
            _status = false;
            break;
          case 'wrong-password':
            _successMessage = 'Wrong password';
            _status = false;
            break;
          default:
            _successMessage = "Error during authentication: ${error.message}";
            _status = false;
        }

        setViewState(ViewState.success);
      } else if (error is PlatformException &&
          error.code == 'sign_in_failed' &&
          error.details == 'ID Token expired') {
        // Handle ID Token expiration error
        _successMessage = 'Session expired, please sign in again';
        _status = false;
        setViewState(ViewState.success);
      } else {
        _successMessage = "Unexpected error during authentication: $error";
        _status = false;
        setViewState(ViewState.success);
      }

      return null;
    }
  }

  signInWithGoogleApple(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails = result.user;

    if (result != null) {
      Map<String, dynamic> userInfoMap = {
        "email": userDetails!.email,
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL,
        "id": userDetails.uid,
      };
      Modals.showToast('Successful');
    }
  }

//   Future<UserCredential?> signInWithApple() async {
//   try {
//     _status = true;
//     setViewState(ViewState.loading);

//     final appleProvider = OAuthProvider("apple.com");

//     final auth = await FirebaseAuth.instance.signInWithPopup(appleProvider);

//     _status = false;

//     if (auth.user != null) {
//       _successMessage = 'Authentication successful';
//       setViewState(ViewState.success);
//       return auth;
//     } else {
//       _successMessage = 'Authentication canceled';
//       setViewState(ViewState.success);
//       return null;
//     }
//   } catch (e) {
//     if (e is FirebaseAuthException) {
//       _successMessage = 'Error during Apple sign-in: ${e.message}';
//     } else if (e is PlatformException &&
//         e.code == 'com.apple.AuthenticationServices.AuthorizationError' &&
//         e.details == '1000') {
//       _successMessage = 'Authorization error. Please try again.';
//     } else {
//       _successMessage = 'Unexpected error during Apple sign-in: $e';
//     }
//     _status = false;
//     setViewState(ViewState.failed);
//     return null;
//   }
// }

  Future<UserCredential?> signInWithApple() async {
    try {
      // Request Apple authentication
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      // Create Firebase credential
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: result.identityToken,
        accessToken: result.authorizationCode,
      );

      // Sign in with Firebase
      final userCredential = await auth.signInWithCredential(oauthCredential);

      return userCredential;
    } catch (error) {
      print("Error during Apple sign-in: $error");
      return null;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      _status = true;

      await FirebaseAuth.instance.signOut();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await StorageHandler.clearCache();
      StorageHandler.saveOnboardState('true');

      AppNavigator.pushAndReplacePage(context, page: login.SigninScreen());

      _successMessage = "User signed out successfully";
      _status = false;
    } catch (error) {
      _successMessage = "Error during sign-out: $error";
      _status = false;
    }
  }

  String get token => _token;
  String get successMessage => _successMessage;
  bool get status => _status;
}
