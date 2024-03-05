import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/model/chats/user.dart';

import '../repository/auth_repository.dart';

 

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) async{
  final authController = ref.watch(authControllerProvider);
  String userId = await  StorageHandler.getUserId()  ?? '';
  return authController.getUserData(userId);
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<User?> getUserData(String userId) async {
    User? user = await authRepository.getCurrentUserData(userId);
    return user;
  }

  

  

  Future<void> saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic, String userId) async{
   await authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context, userId: userId,
    );

  }

  

  void setUserState(bool isOnline, String userId) {
    authRepository.setUserState(isOnline, userId);
  }
}
