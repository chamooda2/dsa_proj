import 'package:dsa_proj/common/common.dart';
import 'package:dsa_proj/common/loading_page.dart';
import 'package:dsa_proj/features/auth/controller/auth_controller.dart';
import 'package:dsa_proj/features/auth/view/signup_view.dart';
import 'package:dsa_proj/features/home/view/home_view.dart';
import 'package:dsa_proj/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Twitter Clone',
        theme: AppTheme.theme,
        home: ref.watch(currentUserAccountProvider).when(
              data: (user) {
                if (user != null) {
                  return HomeView();
                }
                return SignUpView();
              },
              error: (error, st) => ErrorPage(
                error: error.toString(),
              ),
              loading: () => const LoadingPage(),
            ));
  }
}
