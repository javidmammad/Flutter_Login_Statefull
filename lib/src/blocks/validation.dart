import 'dart:async';

mixin Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if (email.contains('@')) {
          sink.add(email);
        } else {
          sink.addError('Enter a valid email!');
        }
      }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length > 3) {
          sink.add(password);
        } else {
          sink.addError('Password must be > 4');
        }
      }
  );
}