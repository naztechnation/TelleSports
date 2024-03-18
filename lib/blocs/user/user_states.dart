import 'package:equatable/equatable.dart';

import '../../model/user_model/country_bank.dart';
import '../../model/user_model/transfer_tellacoin.dart'; 


abstract class UserStates extends Equatable {
  const UserStates();
}

class InitialState extends UserStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class TransferCoinLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class TransferCoinLoaded extends UserStates {
  final TransferTellacoin tellacoin;
  const TransferCoinLoaded(this.tellacoin);
  @override
  List<Object> get props => [tellacoin];
}

class CurrencyLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class CurrencyLoaded extends UserStates {
  final BankCountryCode bank;
  const CurrencyLoaded(this.bank);
  @override
  List<Object> get props => [bank];
}

class UserNetworkErr extends UserStates {
  final String? message;
  const UserNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class UserApiErr extends UserStates {
  final String? message;
  const UserApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
