import 'package:dsa_proj/common/loading_page.dart';
import 'package:dsa_proj/common/rounded_small_button.dart';
import 'package:dsa_proj/constants/ui_constants.dart';
import 'package:dsa_proj/features/auth/view/signup_view.dart';
import 'package:dsa_proj/theme/pallete.dart';
import 'package:dsa_proj/widgets/auth_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    AuthField(
                      controller: emailController,
                      hintText: "Email",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AuthField(
                      controller: passwordController,
                      hintText: "Password",
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: RoundedSmallButton(
                        onTap: onLogin,
                        label: "Done",
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(fontSize: 16),
                          children: [
                            TextSpan(
                              text: " Sign up",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Pallete.blueColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, SignUpView.route());
                                },
                            )
                          ]),
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}
