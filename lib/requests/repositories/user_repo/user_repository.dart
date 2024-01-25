


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

  // Future<ConverterHistory> addConversionHistory({
  //   required String sourceCode,
  //   required String destinationCode,
  //   required String bookieTo,
  //   required String bookieFrom,
  //   required String status,
  // });

  // Future<ConverterHistory> getConversionHistory();
  

 }