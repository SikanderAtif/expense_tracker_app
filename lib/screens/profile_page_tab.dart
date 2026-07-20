// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/providers/expense_provider.dart';
import 'package:expense_tracker_app/services/auth_service.dart';
import 'package:expense_tracker_app/services/expense_helper.dart';
import 'package:expense_tracker_app/services/firestore_service.dart';
import 'package:expense_tracker_app/widgets/empty_profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  final _auth = AuthService();
  final _firestore = FireStoreService();
  late User? currentUser;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser();
  }

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

  void _login(AppLocalizations locale, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.secondary.withOpacity(0.1),
          content: Text(
            locale.emptyLogin,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      );
      return;
    }

    _showLoadingDialog(context, locale.loginLoad);

    User? user;
    try {
      user = await _auth.logInUser(email, password);

      setState(() {
        currentUser = user;
      });
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = locale.userNotFound;
      } else if (e.code == 'wrong-password') {
        message = locale.wrongPassword;
      } else if (e.code == 'invalid-email') {
        message = locale.invalidEmail;
      } else if (e.code == 'user-disabled') {
        message = locale.userDisabled;
      } else if (e.code == 'invalid-credential') {
        message = locale.invalidCredential;
      } else {
        message = locale.networkError;
      }

      if (mounted) Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.secondary.withOpacity(0.1),
          content: Text(
            message,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      );

      return;
    } finally {
      if (user != null && mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _signup(AppLocalizations locale, String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.secondary.withOpacity(0.1),
          content: Text(
            locale.allEmpty,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      );
      return;
    }

    _showLoadingDialog(context, locale.creatingAccount);

    User? user;
    try {
      user = await _auth.signUpUser(email, password);

      if (user != null) {
        await _firestore.addUserProfile(user.uid, [], [], name);
      }
      setState(() {
        currentUser = user;
      });
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = locale.weakPass;
      } else if (e.code == 'email-already-in-use') {
        message = locale.emailUsed;
      } else if (e.code == 'invalid-email') {
        message = locale.invalidEmail;
      } else {
        message = locale.networkError;
      }

      if (mounted) Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.secondary.withOpacity(0.1),
          content: Text(
            message,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      );

      return;
    } finally {
      if (user != null && mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _signOut() async {
    await _auth.signOut();
    setState(() {
      currentUser = null;
    });
  }

  void _upload(AppLocalizations locale) async {
    if (currentUser == null) return;

    _showLoadingDialog(context, locale.uploading);

    try {
      final List<Expense> expenses = await ExpensesHelper.retrieve(null);
      final List<dynamic> budget = await ExpensesHelper.retrieveBudget();
      final List<Map<String, dynamic>> budgetMap = [];
      for (dynamic element in budget) {
        budgetMap.add({
          "Category": element[0].label,
          'Amount': element[1],
          'TimeStamp': element[2],
        });
      }

      await _firestore.updateData(currentUser!.uid, expenses, budgetMap);
    } catch (e) {
      debugPrint("Upload failed: $e");
    } finally {
      if (mounted) Navigator.pop(context);
    }
  }

  void _download(AppLocalizations locale) async {
    if (currentUser == null) return;

    _showLoadingDialog(context, locale.downloading);

    try {
      final DocumentSnapshot docSnapshot = await _firestore.getUserData(
        currentUser!.uid,
      );
      if (!docSnapshot.exists || docSnapshot.data() == null) return;

      final Map<String, dynamic> docs =
          docSnapshot.data() as Map<String, dynamic>;
      final List<dynamic> rawExpenses = docs['expenses'] ?? [];
      final List<dynamic> budgetMap = docs['budget'] ?? [];
      final List<dynamic> budget = [];

      for (Map<String, dynamic> element in budgetMap) {
        Category category = Category.values.firstWhere(
          (e) => e.label == element['Category'],
        );
        double amount = element['Amount'];
        DateTime timestamp;
        if (element['TimeStamp'] is Timestamp) {
          timestamp = (element['TimeStamp'] as Timestamp).toDate();
        } else if (element['TimeStamp'] is String) {
          timestamp = DateTime.parse(element['TimeStamp']);
        } else {
          timestamp = element['TimeStamp'] as DateTime;
        }

        budget.add([category, amount, timestamp]);
      }

      List<Expense> expenses = rawExpenses
          .map((e) => Expense.fromMap(e))
          .toList();

      await Future.wait([
        ExpensesHelper.insertAll(expenses),
        ExpensesHelper.insertBudgetAll(budget),
      ]);

      ref.read(expenseProvider.notifier).refresh();
      ref.read(budgetProvider.notifier).refresh();
    } catch (e) {
      debugPrint('Download failed: $e');
    } finally {
      if (mounted) {
        Navigator.pop(context);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;
    final String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.profile),
        actions: [
          uid == null
              ? SizedBox(width: 0)
              : TextButton(
                  onPressed: _signOut,
                  child: Text(
                    locale.signOut,
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: uid == null
              ? EmptyProfileState(login: _login, signup: _signup)
              : StreamBuilder<DocumentSnapshot>(
                  stream: _firestore.users.doc(uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          key: ValueKey('loading'),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        !snapshot.data!.exists) {
                      TextEditingController nameController =
                          TextEditingController();

                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: Column(
                            children: [
                              Text(
                                locale.welcomeMessage,
                                style: TextStyle(
                                  color: color.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: color.secondary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: color.secondary.withOpacity(0.1),
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    bottom: 8,
                                    top: 3,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.border_color_outlined),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: TextField(
                                          controller: nameController,
                                          keyboardType: TextInputType.name,
                                          style: TextStyle(
                                            color: color.primary,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await _firestore.addUserProfile(
                                          currentUser!.uid,
                                          [],
                                          [],
                                          nameController.text.trim(),
                                        );

                                        setState(() {});
                                      },
                                      child: Text(locale.continueBtn),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    final String userName = userData['name'] ?? locale.user;

                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 24),
                            Text(
                              '${locale.welcome}, $userName',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: color.primary,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              locale.uploadMsg,
                              style: TextStyle(
                                color: color.primary,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {_upload(locale);},
                                    child: Text(locale.upload),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32),
                            Text(
                              locale.downloadMsg,
                              style: TextStyle(
                                color: color.primary,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {_download(locale);},
                                    child: Text(locale.download),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
