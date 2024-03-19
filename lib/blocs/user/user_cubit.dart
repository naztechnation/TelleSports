 

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tellesports/blocs/user/user.dart';

import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository.dart';

import '../../utils/exceptions.dart';
import 'user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit({required this.userRepository, required this.viewModel})
      : super(const InitialState());
  final UserRepository userRepository;
  final UserViewModel viewModel;

  Future<void> transferTellaCoin({
    required String amount,
    required String userId,
    
  }) async {
    try {
      emit(TransferCoinLoading());

      final agents = await userRepository.transferTellaCoins(
        desUserId: userId,
        amount: amount,
        
      );

      emit(TransferCoinLoaded(agents));
    } on ApiException catch (e) {
      emit(UserApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> updateAccount({
    required String bank,
    required String accountName,
    required String accountNumber,
    
  }) async {
    try {
      emit(TransferCoinLoading());

      final agents = await userRepository.updateAccount(
        bank: bank,
        accountName: accountName,
        accountNumber: accountNumber,
        
      );

      emit(TransferCoinLoaded(agents));
    } on ApiException catch (e) {
      emit(UserApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

   Future<void> getCountryBank({
    required String countryCode,
     
    
  }) async {
    try {
      emit(CurrencyLoading());

      final banks = await userRepository.getCountryBank(countryCode: countryCode
        
        
      );

      emit(CurrencyLoaded(banks));
    } on ApiException catch (e) {
      emit(UserApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> requestPayout({required String currency,
   required String bankName, required String accountNumber, 
   required String accountName, required String bankCode , required String amount}) async {
    try {
      emit(RequestPayoutLoading());

      final payout = await userRepository.requestPayout(currency: currency, bankName: bankName, accountNumber: accountNumber, accountName: accountName, amount: amount, bankCode: bankCode
        
        
      );

      emit(RequestPayoutLoaded(payout));
    } on ApiException catch (e) {
      emit(UserApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

}
