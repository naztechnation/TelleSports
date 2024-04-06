import '../../core/constants/enums.dart';
import '../../handlers/secure_handler.dart';
import '../auth_model/bookies.dart';
import '../auth_model/bookies_details.dart';
import '../auth_model/confirm_subscriptions.dart';
import '../auth_model/converter_history.dart';
import '../auth_model/notifications.dart';
import 'base_viewmodel.dart';

class AccountViewModel extends BaseViewModel {
  BookiesDetails? _bookiesDetails;
  ConverterHistory? _converterHistory;

  int _unreadMessageLength = 0;

  int _currentIndex = 0;

  List<NotificationsListData> _notifications = [];

  AccountViewModel() {
    getToken();
  }

  String _token = "";
  BookiesList? _bookiesList;
  ConfirmSubscription? _confirmSubscription;

  filterUnreadNotifications(NotificationsList notificationsList) {
    _notifications = notificationsList.data
            ?.where((notification) => notification.read == 0)
            .toList() ??
        [];

    _unreadMessageLength = _notifications.length;

    setViewState(ViewState.success);
  }

  Future<void> getBookie(BookiesList bookie) async {
    _bookiesList = bookie;

    setViewState(ViewState.success);
  }

  setToken(String token) async {
    _token = token;

    StorageHandler.saveUserToken(_token);
    setViewState(ViewState.success);
  }

   updateIndex(int index) async {
    _currentIndex = index;

    setViewState(ViewState.success);
  }

  getToken() async {
    _token = await StorageHandler.getUserToken() ?? '';
    setViewState(ViewState.success);
  }

  getBookiesDetails(BookiesDetails bookiesDetails) {
    _bookiesDetails = bookiesDetails;
    setViewState(ViewState.success);
  }

  getConverterHistory(ConverterHistory converterHistory) {
    _converterHistory = converterHistory;
    setViewState(ViewState.success);
  }

  setConverterHistory(ConverterHistory converterHistory) {
    _converterHistory = converterHistory;
    setViewState(ViewState.success);
  }

  Future<void> getPaymentStatus(
      ConfirmSubscription? confirmSubscription) async {
    _confirmSubscription = confirmSubscription;

    setViewState(ViewState.success);
  }

  

  String get token => _token;

  List<BookiesData> get from =>
      _bookiesList?.data?.where((p) => p.from == '1').toList() ?? [];

  List<BookiesData> get to =>
      _bookiesList?.data?.where((p) => p.to == '1').toList() ?? [];

  List<String?> get bookiesFrom => from.map((bookie) => bookie.name).toList();

  List<String?> get bookiesTo => to.map((bookie) => bookie.name).toList();

  List<String?> get bookiesBookieFrom =>
      from.map((bookie) => bookie.bookie).toList();

  List<String?> get bookiesBookieTo =>
      to.map((bookie) => bookie.bookie).toList();

  List<String?> get bookiesId =>
      _bookiesList?.data?.map((bookie) => bookie.bookie).toList() ?? [];

  ConverterHistory? get converterHistory => _converterHistory;

  BookiesDetails? get bookiesDetails => _bookiesDetails;
  List<ListElement>? get getUniformLists =>
      _bookiesDetails?.data?.data?.conversion?.dump?.lists ?? [];
  List<ConverterHistoryData>? get convertionHistoties =>
      _converterHistory?.data ?? [];

  List<ListElement> get notConvertedBookies =>
      getUniformLists?.where((p) => !(p.isConverted ?? false)).toList() ?? [];

  bool get paymentStatus => _confirmSubscription?.success ?? false;

  int get unReadMessages => _unreadMessageLength;
  int get currentPage => _currentIndex;
}
