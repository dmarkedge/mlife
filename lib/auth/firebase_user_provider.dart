import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MapLFirebaseUser {
  MapLFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

MapLFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MapLFirebaseUser> mapLFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MapLFirebaseUser>((user) => currentUser = MapLFirebaseUser(user));
