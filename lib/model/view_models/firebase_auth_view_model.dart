

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/constants/enums.dart';
import '../../handlers/secure_handler.dart';
import 'base_viewmodel.dart';

class FirebaseAuthProvider extends BaseViewModel {
  FirebaseAuthProvider() {
    getToken();
  }

  String _token = "";

  String _successMessage = '';
  bool _status = false;



  

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

      _successMessage = 'Authentication cancelled';
      _status = false;
    setViewState(ViewState.success);

      return null; 
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = authResult.user;

  //final name = user.

   

      _successMessage = 'Authentication successfull';
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
           
           _successMessage = 'User account has been disabled by an administrator';
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

    } else {
     
       _successMessage = "Unexpected error during authentication: $error";
     _status = false;

       setViewState(ViewState.success);

    }

    return null;
  }
}

Future<void> signOut() async {
  try {

     _status = true;

    await FirebaseAuth.instance.signOut();

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