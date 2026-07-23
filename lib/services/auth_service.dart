import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  User? currentUser() {
    return _auth.currentUser;
  }

  Future<User?> signUpUser(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('An account already exists for that email.');
      }
      rethrow;
    }
  }

  Future<User?> logInUser(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Error Occured: ${e.code}');
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      await dotenv.load();
      await _googleSignIn.initialize(
        serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
      );

      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();
      if (googleUser == null) return null;

      final List<String> scopes = ['email', 'profile'];
      final clientAuth = await googleUser.authorizationClient.authorizeScopes(
        scopes,
      );

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: clientAuth.accessToken,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print("Firebase Google Auth Error: ${e.message}");
      rethrow;
    } catch (e) {
      print('Google Sign In Error: $e');
      return null;
    }
  }

  Future<void> delete() async {
    User? user = currentUser();

    try {
      await user?.delete();
    } catch (e) {
      print('Error: ${e}');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
  }

  String exceptionHandler(FirebaseException e, BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    String message;

    if (e.code == 'user-not-found') {
      message = locale.userNotFound;
    } else if (e.code == 'user-mismatch') {
      message = locale.userMismatch;
    } else if (e.code == 'wrong-password') {
      message = locale.wrongPassword;
    } else if (e.code == 'invalid-email') {
      message = locale.invalidEmail;
    } else if (e.code == 'user-disabled') {
      message = locale.userDisabled;
    } else if (e.code == 'invalid-credential') {
      message = locale.invalidCredential;
    } else if (e.code == 'weak-password') {
      message = locale.weakPass;
    } else if (e.code == 'email-already-in-use') {
      message = locale.emailUsed;
    } else if (e.code == 'invalid-email') {
      message = locale.invalidEmail;
    } else {
      message = locale.networkError;
    }

    return message;
  }
}
