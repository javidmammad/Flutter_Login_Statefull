import 'package:flutter/material.dart';
import 'package:login_stateful/screens/home.dart';
import 'blocks/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return Provider(
      key: UniqueKey(),
      child: const MaterialApp(
        title: 'Log me in!',
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
