

import '../../core/constants/enums.dart';
import '../../handlers/secure_handler.dart';
import '../auth_model/bookies.dart';
import 'base_viewmodel.dart';

class AccountViewModel extends BaseViewModel {
  AccountViewModel() {
    getToken();
  }

  String _token = "";
  BookiesList? _bookiesList;




 Future<void> getBookie(BookiesList bookie) async {
    _bookiesList = bookie;

    setViewState(ViewState.success);
  }


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

   List<Data> get from =>
      _bookiesList?.data?.where((p) => p.from == '1').toList() ?? [];

  List<Data> get to =>
      _bookiesList?.data?.where((p) => p.to == '1').toList() ?? [];

  List<String?> get bookiesFrom => from.map((bookie) => bookie.name).toList() ;

  List<String?> get bookiesTo => to.map((bookie) => bookie.name).toList();

  List<String?> get bookiesBookieFrom =>
      from.map((bookie) => bookie.bookie).toList();

  List<String?> get bookiesBookieTo =>
      to.map((bookie) => bookie.bookie).toList();

  List<String?> get bookiesId =>
      _bookiesList?.data?.map((bookie) => bookie.bookie).toList() ?? [];
}