import 'package:appwrite/models.dart' as model;
import 'package:dsa_proj/features/auth/view/login_view.dart';
import 'package:dsa_proj/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import '../../../apis/auth_api.dart';
import '../../../apis/user_api.dart';
import '../../../core/utils.dart';
import '../../home/view/home_view.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  // print(currentUserId);
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  // print(userDetails.value);
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);

  // final a = ((authController.getUserData(uid)));
  // print("lol" + a.toString());

  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
    );
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) async {
      UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          profilePic: "",
          bannerPic: "",
          uid: r.$id,
          bio: "",
          followers: const [],
          following: const [],
          isTwitterBlue: false);
      final res2 = await _userAPI.saveUserData(userModel);
      res2.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, "Account created! Please Login");
        Navigator.push(context, LoginView.route());
      });
    });
  }

  Future<model.User?> currentUser() => _authAPI.currentUserAccount();

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(
      email: email,
      password: password,
    );
    state = false;
    res.fold((l) => showSnackBar(context, l.message),
        (r) => Navigator.push(context, HomeView.route()));
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    // print("hi" + document.data.toString());
    // print("hello" + updatedUser.uid);
    return updatedUser;
  }
}
