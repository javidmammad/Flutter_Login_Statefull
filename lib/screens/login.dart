// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:login_stateful/blocks/bloc.dart';
import 'package:login_stateful/blocks/provider.dart';

class Login extends StatefulWidget {
  final void Function() onSecure;

  const Login({super.key, required this.onSecure});

  @override
  State<Login> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  Color emailColorTheme = Colors.grey.shade700;
  Color passwordColorTheme = Colors.grey.shade700;
  bool passwordSecured = true;

  @override
  void initState() {
    super.initState();
    passwordFocusNode.addListener(onPasswordFocus);
    emailFocusNode.addListener(onEmailFocus);
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void onEmailFocus() {
    setState(() {
      emailColorTheme = emailFocusNode.hasFocus
          ? const Color(0xFF27B498)
          : Colors.grey.shade700;
    });
  }

  void onPasswordFocus() {
    setState(() {
      passwordColorTheme = passwordFocusNode.hasFocus
          ? const Color.fromRGBO(39, 180, 152, 1.0)
          : Colors.grey.shade700;
    });
  }

  @override
  Widget build(context) {
    final bloc = Provider.of(context);

    return (Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          emailField(bloc),
          Container(margin: const EdgeInsets.only(top: 10.0)),
          passwordField(bloc),
          Container(margin: const EdgeInsets.only(top: 20.0)),
          submitButton(bloc)
        ],
      ),
    ));
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          focusNode: emailFocusNode,
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(236, 245, 243, 1.0),
              border: InputBorder.none,
              icon: const Icon(Icons.email),
              iconColor: emailColorTheme,
              hintText: 'you@example.com',
              labelText: 'Email Address',
              labelStyle: TextStyle(color: emailColorTheme),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(39, 180, 152, 1.0),
                ),
              ),
              errorText: snapshot.error != null ? "${snapshot.error}" : null),
        );
      },
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          focusNode: passwordFocusNode,
          obscureText: passwordSecured,
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(236, 245, 243, 1.0),
            border: InputBorder.none,
            icon: const Icon(Icons.password),
            suffixIcon: GestureDetector(
              child: passwordSecured
                  ? const Icon(Icons.remove_red_eye_sharp)
                  : const Icon(Icons.remove_red_eye_outlined),
              onTap: () {
                setState(() {
                  passwordSecured = !passwordSecured;
                  widget.onSecure();
                });
              },
            ),
            iconColor: passwordColorTheme,
            suffixIconColor: passwordColorTheme,
            hintText: '123456',
            labelText: 'Password',
            labelStyle: TextStyle(color: passwordColorTheme),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(39, 180, 152, 1.0),
              ),
            ),
            errorText: snapshot.error != null ? "${snapshot.error}" : null,
          ),
        );
      },
    );
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return SizedBox(
            width: 150.0,
            height: 35.0,
            child: ElevatedButton(
              // onPressed: snapshot.hasData ? bloc.submit : null,
              onPressed: widget.onSecure,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(39, 180, 152, 1.0),
              ),
              child: const Text('Login'),
            ),
          );
        });
  }
}
