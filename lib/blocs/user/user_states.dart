import 'package:equatable/equatable.dart';

import '../../model/auth_model/transfer_tellacoin.dart'; 


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
