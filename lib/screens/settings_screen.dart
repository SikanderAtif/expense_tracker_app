import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:expense_tracker_app/services/auth_service.dart';
import 'package:expense_tracker_app/services/firestore_service.dart';
import 'package:expense_tracker_app/theme/theme_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum Language { english, arabic }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _auth = AuthService();
  final _firestore = FireStoreService();

  void _showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Theme.of(
              context,
            ).colorScheme.secondary.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  SizedBox(height: 20),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<List<String>?> _showWarningDialog(BuildContext context) async {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: appThemeMode.value == ThemeMode.dark
              ? color.secondary.withOpacity(0.1)
              : color.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  locale.warning,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  locale.deleteMsg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: locale.email,
                    hintStyle: TextStyle(color: color.secondary),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: locale.password,
                    hintStyle: TextStyle(color: color.secondary),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, [
                            emailController.text.trim(),
                            passController.text.trim(),
                          ]);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.resolveWith((_) {
                            return Colors.red[700];
                          }),
                        ),
                        child: Text(locale.delete),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteAccount() async {
    final List<String>? credentials = await _showWarningDialog(context);
    if (credentials == null ||
        credentials.length < 2 ||
        credentials[0].isEmpty ||
        credentials[1].isEmpty) {
      return;
    }

    _showLoadingDialog(context, AppLocalizations.of(context)!.deleting);
    final user = _auth.currentUser();

    try {
      if (user != null) {
        String uid = user.uid;

        AuthCredential credential = EmailAuthProvider.credential(
          email: credentials[0],
          password: credentials[1],
        );

        await user.reauthenticateWithCredential(credential);
        await _firestore.deleteUser(uid);
        await _auth.delete();
      }
    } on FirebaseException catch (e) {
      final message = _auth.exceptionHandler(e, context);
      print('Error: ${e}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.secondary,
          content: Text(
            message,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      );
    } finally {
      if (mounted) {
        Navigator.pop(context);

        if (context.canPop()) {
          print("Popping the Settings Screen");
          context.pop(null);
        } else {
          print("Not popping but going to profile screen");
          context.go('/profile');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;
    bool isLight = Theme.of(context).brightness == Brightness.light;
    final currentLang =
        appLocale.value?.languageCode ??
        Localizations.maybeLocaleOf(context)?.languageCode;
    Language? lang = currentLang == 'ar' ? Language.arabic : Language.english;

    return Scaffold(
      appBar: AppBar(title: Text(locale.settings)),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              locale.screenMode,
              style: TextStyle(color: color.primary, fontSize: 24),
            ),
            SizedBox(height: 12),
            SwitchListTile(
              title: isLight
                  ? Text(
                      locale.light,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : Text(
                      locale.dark,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              value: isLight,
              activeTrackColor: color.primary,
              inactiveTrackColor: color.onSurface,
              onChanged: (value) {
                setState(() {
                  appThemeMode.value = (appThemeMode.value == ThemeMode.dark)
                      ? ThemeMode.light
                      : ThemeMode.dark;

                  isLight = value;
                });
              },
            ),
            SizedBox(height: 24),
            Text(
              locale.language,
              style: TextStyle(color: color.primary, fontSize: 24),
            ),
            SizedBox(height: 12),
            RadioGroup<Language>(
              groupValue: lang,
              onChanged: (Language? value) {
                setState(() {
                  if (currentLang == 'ar') {
                    appLocale.value = const Locale('en');
                  } else {
                    appLocale.value = const Locale('ar');
                  }
                  lang = value;
                });
              },
              child: Column(
                children: [
                  ListTile(
                    title: Text('English'),
                    textColor: lang == Language.english
                        ? color.onSurface
                        : color.primary,
                    leading: Radio<Language>(
                      value: Language.english,
                      activeColor: color.onSurface,
                      side: BorderSide(
                        color: lang == Language.english
                            ? color.onSurface
                            : color.primary,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('عربي'),
                    textColor: lang == Language.arabic
                        ? color.onSurface
                        : color.primary,
                    leading: Radio<Language>(
                      value: Language.arabic,
                      activeColor: color.onSurface,
                      side: BorderSide(
                        color: lang == Language.arabic
                            ? color.onSurface
                            : color.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
      persistentFooterButtons: [
        _auth.currentUser() == null
            ? SizedBox(width: 0)
            : Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _deleteAccount,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith((_) {
                          return Colors.red[700];
                        }),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(locale.delete),
                          SizedBox(width: 12),
                          Icon(Icons.delete),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ],
      persistentFooterDecoration: BoxDecoration(
        border: Border.all(color: color.surface),
      ),
    );
  }
}
