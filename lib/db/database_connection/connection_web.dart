import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor connectImpl() {
  return WebDatabase('nba_app_web_db');
}
