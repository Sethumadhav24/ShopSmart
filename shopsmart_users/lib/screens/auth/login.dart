import 'package:flutter/material.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopsmart_users/consts/validator.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/screens/auth/forgot_password.dart';
import 'package:shopsmart_users/screens/auth/register.dart';

import 'package:shopsmart_users/widgets/app_name_text.dart';
import 'package:shopsmart_users/widgets/auth/google_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class LoginScreen extends StatefulWidget {
  static const routName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      // Focus Nodes
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loginFct() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const AppNameTextWidget(
              fontSize: 30,
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TitlesTextWidget(
                label: "Welcome back!",
                fontSize: 25,
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: SubtitleTextWidget(
                  label: "Let's get you logged in so you can start exploring",
                  fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email address",
                      prefixIcon: Icon(
                        IconlyLight.message,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      return MyValidators.emailValidator(value);
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              obscureText = !obscureText;
                            },
                          );
                        },
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      hintText: "***********",
                      prefixIcon: const Icon(
                        IconlyLight.password,
                      ),
                    ),
                    onFieldSubmitted: (value) async {
                      await _loginFct();
                    },
                    validator: (value) {
                      return MyValidators.passwordValidator(value);
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          ForgotPasswordScreen.routeName,
                        );
                      },
                      child: const SubtitleTextWidget(
                        label: "Forgot password?",
                        fontStyle: FontStyle.italic,
                        textDecoration: TextDecoration.underline,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12.0),
                        backgroundColor: Colors.lightBlue,
                      ),
                      icon: const Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Login",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        await _loginFct();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SubtitleTextWidget(
                    label: "Or connect using".toUpperCase(),
                    fontSize: 15,
                    color: Colors.white54,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: kBottomNavigationBarHeight + 10,
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: kBottomNavigationBarHeight,
                            child: FittedBox(
                              child: GoogleButton(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          // flex: 2,
                          child: SizedBox(
                            height: kBottomNavigationBarHeight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(12.0),
                                backgroundColor: Colors.lightBlue,
                              ),
                              child: const Text(
                                "Guest?",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () async {
                                Navigator.of(context)
                                    .pushNamed(RootScreen.routName);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SubtitleTextWidget(
                        label: "Dont have an account?",
                        fontSize: 15,
                      ),
                      TextButton(
                        child: const SubtitleTextWidget(
                          label: "Sign up",
                          fontStyle: FontStyle.italic,
                          textDecoration: TextDecoration.underline,
                          fontSize: 15,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RegisterScreen.routName);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
