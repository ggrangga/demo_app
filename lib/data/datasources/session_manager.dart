import 'package:demo_app/data/models/session.dart';

abstract class SessionManager {
  Future<Session> getSession();
  Stream<Session> getSessionStream();
  Future<void> setSession(Session session);
}
