import 'dart:async';
import 'package:login_stateful/src/blocks/validation.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Change
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  // Retrieve
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (e, p) {
    return true;
  });


  dispose() {
    _email.close();
    _password.close();
  }

  submit() {
    // feature of BehaviorSubject from  RxDart :)
    final validEmail = _email.value;
    final validPassword = _password.value;

  }
}