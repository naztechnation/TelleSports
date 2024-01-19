import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository.dart';
import '../../utils/exceptions.dart';
import 'account_states.dart';

class AccountCubit extends Cubit<AccountStates> {
  AccountCubit({required this.accountRepository, required this.viewModel})
      : super(const InitialState());
  final AccountRepository accountRepository;
  final AccountViewModel viewModel;

  Future<void> registerUser({
    required String username,
    required String confirmPassword,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      emit(AccountProcessing());

      final user = await accountRepository.registerUser(
        email: email,
        password: password,
        phone: phoneNumber, username: username, confirmPassword: confirmPassword,
      );

      // await viewModel.setToken(user.token ?? '');
      emit(AccountLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> loginUser(
      {required String password, required String email}) async {
    try {
      emit(AccountLoading());

      final userData =
          await accountRepository.loginUser(email: email, password: password);

      // await viewModel.setToken(userData.token ?? '');
      emit(AccountUpdated(userData));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> verifyCode({required String code, required String email, required String url}) async {
    try {
      emit(AccountLoading());

      final userData =
          await accountRepository.verifyCode(code: code,  email: email, url: url);

      // await viewModel.setToken(userData.token ?? '');
      emit(AccountLoaded(userData));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> resendVerifyCode({
    required String email,
  }) async {
    try {
      emit(AccountProcessing());

      final user = await accountRepository.resendVerifyCode(
        email: email,
      );

      emit(OTPResent(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }


  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      emit(AccountProcessing());

      final user = await accountRepository.forgetPassword(
        email: email,
      );

      emit(AccountLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

   
  Future<void> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      emit(ResetPasswordLoading());

      final user = await accountRepository.resetPassword(
        password: password, email: email, confirmPassword: confirmPassword,
      );

      emit(ResetPasswordLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      emit(ResetPasswordLoading());

      final user = await accountRepository.changePassword(
        password: password,  confirmPassword: confirmPassword, oldPassword: oldPassword,
      );

      emit(ResetPasswordLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

   Future<void> getBookies() async {
    try {
      emit(AccountProcessing());

      final bookies = await accountRepository.getBookies();

      await viewModel.getBookie(bookies);

      emit(BookieListLoaded(bookies));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }


  Future<void> convertBetCode({
    required String from,
    required String to,
    required String bookingCode,
    required String apiKey,
  }) async {
    try {
      emit(BookingsProcessing());

      final bookings = await accountRepository.convertBetCode(
        from: from,
        to: to,
        bookingCode: bookingCode,
        apiKey: apiKey,
      );

      if (bookings.data?.data?.conversion?.destinationCode == null) {
        emit(const BookingsError(''));
      } else {
        emit(BookingsLoaded(bookings));
      }
       viewModel.getBookiesDetails(bookings);
    } on ApiException catch (e) {
      emit(BookingsApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(BookingsNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  

  Future<void> getConversionHistory() async {
    try {
      emit(ConverterHistoryLoading());

      final history = await accountRepository.getConversionHistory();

     await viewModel.getConverterHistory(history);

      emit(ConverterHistoryLoaded(history));

    } on ApiException catch (e) {
      emit(ConveterHistoryApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(ConveterHistoryNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}
