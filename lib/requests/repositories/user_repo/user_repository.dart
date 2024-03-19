


import 'package:tellesports/model/user_model/request_payout.dart';

import '../../../model/user_model/country_bank.dart';
import '../../../model/user_model/transfer_tellacoin.dart';

abstract class UserRepository {



    Future<TransferTellacoin> transferTellaCoins({
    required String desUserId,
    required String amount,
    
  });

  Future<TransferTellacoin> updateAccount({
    required String bank,
    required String accountName,
    required String accountNumber,
    
  });

   Future<BankCountryCode> getCountryBank({
    required String countryCode,
     
    
  });

  Future<RequestPayout> requestPayout({
    required String currency,
    required String bankName,
    required String accountNumber,
    required String accountName,
    required String amount,
    required String bankCode,
     
    
  });

  // Future<ConverterHistory> addConversionHistory({
  //   required String sourceCode,
  //   required String destinationCode,
  //   required String bookieTo,
  //   required String bookieFrom,
  //   required String status,
  // });

  // Future<ConverterHistory> getConversionHistory();
  

 }