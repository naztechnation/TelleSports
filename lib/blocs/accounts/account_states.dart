import 'package:equatable/equatable.dart';
import 'package:tellesports/model/auth_model/login.dart';
import 'package:tellesports/model/auth_model/register.dart';

import '../../model/auth_model/bookies.dart';
import '../../model/auth_model/bookies_details.dart';
import '../../model/auth_model/converter_history.dart';
import '../../model/auth_model/plans_list.dart';

abstract class AccountStates extends Equatable {
  const AccountStates();
}

class InitialState extends AccountStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class AccountProcessing extends AccountStates {
  @override
  List<Object> get props => [];
}

class ResetPasswordLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class ResetPasswordLoaded extends AccountStates {
  final RegisterUser userData;
  const ResetPasswordLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class AccountLoaded extends AccountStates {
  final RegisterUser userData;
  const AccountLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class AccountUpdated extends AccountStates {
  final LoginUser user;
  const AccountUpdated(this.user);
  @override
  List<Object> get props => [user];
}

class AccountPasswordChanged extends AccountStates {
  final String message;
  const AccountPasswordChanged(this.message);
  @override
  List<Object> get props => [message];
}

class OTPResent extends AccountStates {
    final RegisterUser userData;

  const OTPResent(this.userData);
  @override
  List<Object> get props => [userData];
}

class BookieListLoaded extends AccountStates {
  final BookiesList bookiesList;
  const BookieListLoaded(this.bookiesList);
  @override
  List<Object> get props => [bookiesList];
}

class AccountLoggedOut extends AccountStates {
  final String message;
  const AccountLoggedOut(this.message);
  @override
  List<Object> get props => [message];
}

class AccountNetworkErr extends AccountStates {
  final String? message;
  const AccountNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class AccountApiErr extends AccountStates {
  final String? message;
  const AccountApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class BookingsLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class BookingsProcessing extends AccountStates {
  @override
  List<Object> get props => [];
}

class BookingsLoaded extends AccountStates {
  final BookiesDetails bookingsData;
  const BookingsLoaded(this.bookingsData);
  @override
  List<Object> get props => [bookingsData];
}

class ConverterHistoryLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class ConverterHistoryLoaded extends AccountStates {
  final ConverterHistory converterHistory;
  const ConverterHistoryLoaded(this.converterHistory);
  @override
  List<Object> get props => [converterHistory];
}

class PlansLoaded extends AccountStates {
  final PlansList plansList;
  const PlansLoaded(this.plansList);
  @override
  List<Object> get props => [plansList];
}

class BookingsError extends AccountStates {
  final String convertedCode;
  const BookingsError(this.convertedCode);
  @override
  List<Object> get props => [convertedCode];
}

class BookingsNetworkErr extends AccountStates {
  final String? message;
  const BookingsNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class BookingsApiErr extends AccountStates {
  final String? message;
  const BookingsApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class ConveterHistoryNetworkErr extends AccountStates {
  final String? message;
  const ConveterHistoryNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class ConveterHistoryApiErr extends AccountStates {
  final String? message;
  const ConveterHistoryApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
