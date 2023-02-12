import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icook_recipe_app/screens/authentication/login_signup_screen.dart';
import 'package:icook_recipe_app/screens/onboarding/onboarding.dart';

import '../constants/app_colours.dart';
import '../constants/app_routes.dart';
import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          debugShowCheckedModeBanner: false,

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.mainBackground,
            textTheme: TextTheme(
              bodyMedium:
                  GoogleFonts.roboto().copyWith(color: AppColors.textColour),
              displayMedium:
                  GoogleFonts.firaSans().copyWith(color: AppColors.textColour),
            ),
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: AppColors.accentColour),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          home: const OnboardingScreen(),
          // home: const LoginSignupScreen(),

          getPages: [
            GetPage(
              name: AppRoutes.loginSignupRoute,
              page: () => const LoginSignupScreen(),
              title: 'Login/ Signup',
            ),
            GetPage(
              name: AppRoutes.onBoardingRoute,
              page: () => const OnboardingScreen(),
              title: 'onboarding',
            ),
          ],
          //   GetPage(
          //     name: AppRoutes.signupRoute,
          //     page: () => const SignupScreen(),
          //     title: 'Signup',
          //   ),
          //   GetPage(
          //     name: AppRoutes.verifyEmailRoute,
          //     page: () => const VerifyEmailScreen(),
          //     title: 'Verify Email',
          //   ),
          //   GetPage(
          //     name: AppRoutes.homeScreenRoute,
          //     page: () => const HomeScreen(),
          //     title: 'Home Page',
          //   ),],
        );
      },
    );
  }
}
