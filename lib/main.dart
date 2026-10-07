import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rally/core/constant/app_constant.dart';
import 'package:rally/core/di/di.dart';
import 'package:rally/core/l10n/generated/app_localizations.dart';
import 'package:rally/core/routes/app_route.dart';
import 'package:rally/core/routes/routes.dart';
import 'package:rally/core/theme/app_theme.dart';
import 'package:rally/firebase_options.dart';
import 'package:rally/presentation/setup/cubit/setup_cubit.dart';
import 'package:rally/presentation/setup/cubit/setup_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies();
  SharedPreferences preferences = getIt();
  var onboardingStatus = preferences.get(KeysConstant.onboardingKey);
  var loginStatus = preferences.get(KeysConstant.loginKey);
  runApp(
    MyApp(
      onboardingStatus: onboardingStatus as bool?,
      loginStatus: loginStatus as bool?,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({required this.onboardingStatus,required this.loginStatus, super.key});
  final SetupCubit cubit = getIt();
  final bool? onboardingStatus;
  final bool? loginStatus;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<SetupCubit, SetupState>(
        builder: (_,state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(state.language),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.mode,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: initialRoute(onboardingStatus ?? false, loginStatus ?? false),
        ),
      ),
    );
  }
}

String initialRoute(bool onboardingStatus, bool loginStatus) {
  if (onboardingStatus == false) {
    return Routes.setup;
  } else {
    if (loginStatus) {
      return Routes.main;
    } else {
      return Routes.login;
    }
  }
}
