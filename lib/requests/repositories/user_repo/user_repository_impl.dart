 
import 'package:tellesports/model/user_model/country_bank.dart';
import 'package:tellesports/model/user_model/request_payout.dart';
import 'package:tellesports/model/user_model/transfer_tellacoin.dart';

import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<TransferTellacoin> transferTellaCoins({required String desUserId, required String amount}) async {

    final map = await Requests().post(
      
      AppStrings.transferTellacoinUrl,
       
       body: {
        'amount': amount,
        'to_': desUserId
      }
    );

    return TransferTellacoin.fromJson(map);
  }
  
  @override
  Future<TransferTellacoin> updateAccount({required String bank,
   required String accountName, required String accountNumber}) async {

    final map = await Requests().post(
      
      AppStrings.updateAccountUrl,
       
       body: {
        'bank': bank,
        'account_name': accountName,
        'account_number': accountNumber
      }
    );

    return TransferTellacoin.fromJson(map);
  }

  @override
  Future<BankCountryCode> getCountryBank({required String countryCode, 
  }) async {

    final map = await Requests().post(
      
      AppStrings.currencyUrl,
       
       body: {
        'country_code': countryCode,
         
      }
    );

    return BankCountryCode.fromJson(map);
  }

  @override
  Future<RequestPayout> requestPayout({required String currency,
   required String bankName, required String accountNumber, 
   required String accountName, required String bankCode , required String amount}) async {

    final map = await Requests().post(
      
      AppStrings.payoutUrl,
       
       body: {
        'account_bank_code': bankCode,
        'account_number': accountNumber,
        'amount': amount,
        'currency': currency,
        'bank': bankName,
         
      }
    );

    return RequestPayout.fromJson(map);
  }


  // @override
  // Future<BookiesDetails> getBookieDetails(
  //     {required String from,
  //     required String to,
  //     required String bookingCode,
  //     required String apiKey}) async {
  //   var payload = {
  //     "from": from,
  //     "to": to,
  //     "booking_code": bookingCode,
  //     "api_key": apiKey
  //   };
  //   final map = await Requests().get(
  //     // AppStrings.bookieUrl
  //     AppStrings.getBookieUrl(
  //         from: from, to: to, apiKey: apiKey, bookingCode: bookingCode),
  //   );

  //   return BookiesDetails.fromMap(map);
  // }

  // @override
  // Future<ConverterHistory> addConversionHistory(
  //     {required String sourceCode,
  //     required String destinationCode,
  //     required String bookieTo,
  //     required String bookieFrom,
  //     required String status}) async {
  //   var payload = {
  //     "bookie_from": bookieFrom,
  //     "bookie_to": bookieTo,
  //     "destination_code": destinationCode,
  //     "source_code": sourceCode,
  //     "status": status
  //   };
  //   final map = await Requests()
  //       .post(AppStrings.createConversionHistoryUrl, body: payload);

  //   return ConverterHistory.fromJson(map);
  // }

  // @override
  // Future<ConverterHistory> getConversionHistory() async {
  //   final map = await Requests().get(
  //     AppStrings.conversionHistoryUrl,
  //   );

  //   return ConverterHistory.fromJson(map);
  // }
}