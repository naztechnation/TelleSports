import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tellesports/model/chats/user.dart' as app;
import '../../presentation/community_screens/chat/repositories/auth_repository.dart';

final authControllerProvider = Provider<AuthController>(
  (ref) {
    final authRepository = ref.watch<AuthRepository>(authRepositoryProvider);
    return AuthController(authRepository);
  },
);

class AuthController {
  AuthController(AuthRepository authRepository)
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// Invoke to signIn user with phone number.
  
  /// invoke to get user data form firestore.
  Stream<app.User> getReceiverUserData(String receiverUserId) {
    return _authRepository.getReceiverUserData(receiverUserId);
  }
}
