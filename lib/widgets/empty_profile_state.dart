// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class EmptyProfileState extends StatelessWidget {
  final void Function(String, String) login;
  final void Function(String, String, String) signup;

  const EmptyProfileState({
    super.key,
    required this.login,
    required this.signup,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return Column(
      children: [
        Text('Name'),
        SizedBox(height: 16),
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
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.border_color_outlined),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: color.primary),
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
        Text('Email'),
        SizedBox(height: 16),
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
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.border_color_outlined),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: color.primary),
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
        Text('Password'),
        SizedBox(height: 16),
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
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.border_color_outlined),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: passController,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(color: color.primary),
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
                onPressed: () {
                  login(
                    emailController.text.trim(),
                    passController.text.trim(),
                  );
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  signup(
                    nameController.text.trim(),
                    emailController.text.trim(),
                    passController.text.trim(),
                  );
                },
                child: Text('Sign Up'),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
