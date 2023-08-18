import 'package:flutter/material.dart';
import 'package:login_stateful/src/blocks/bloc.dart';
import 'package:login_stateful/src/blocks/provider.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(context) {
    final bloc = Provider.of(context);

    return (
        Container (
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              emailField(bloc),
              passwordField(bloc),
              Container(margin: const EdgeInsets.only(top: 25.0)),
              submitButton(bloc)
            ],
          ),
        )
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: 'you@example.com',
              labelText: 'Email Address',
              errorText: snapshot.error != null ? "${snapshot.error}" : null
          ),
        );
      },
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextField(
            obscureText: true,
            onChanged: bloc.changePassword,
            decoration: InputDecoration(
                hintText: '123456',
                labelText: 'Password',
                errorText: snapshot.error != null ? "${snapshot.error}" : null
            ),
          );
        }
    );

  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
            return ElevatedButton(
              onPressed:  snapshot.hasData ? bloc.submit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
              ),
              child: const Text('Login'),
            );
        }
    );
  }
}