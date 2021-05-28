import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Kgfs07FirebaseUser {
  Kgfs07FirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

Kgfs07FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Kgfs07FirebaseUser> kgfs07FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Kgfs07FirebaseUser>((user) => currentUser = Kgfs07FirebaseUser(user));
