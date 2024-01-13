

import '../../core/constants/enums.dart';
import '../../handlers/secure_handler.dart';
import 'base_viewmodel.dart';

class AccountViewModel extends BaseViewModel {
  AccountViewModel() {
    getToken();
  }

  String _token = "";



 

//   bool _showPassword = false;

  setToken(String token) async {
    _token = token;

    StorageHandler.saveUserToken(_token);
    setViewState(ViewState.success);
  }

  getToken() async {
    _token = await StorageHandler.getUserToken() ?? '';
    setViewState(ViewState.success);
  }


   String get token => _token;
}