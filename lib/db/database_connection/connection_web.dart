import 'package:drift/drift.dart';
// ignore: deprecated_member_use
import 'package:drift/web.dart';

QueryExecutor connectImpl() {
  return WebDatabase('nba_app_web_db');
}
