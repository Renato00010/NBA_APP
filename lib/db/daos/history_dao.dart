import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/viewed_history_table.dart';

part 'history_dao.g.dart';

@DriftAccessor(tables: [ViewedHistory])
class HistoryDao extends DatabaseAccessor<AppDatabase> with _$HistoryDaoMixin {
  HistoryDao(super.db);

  // Buscar todo o histórico ordenado por data
  Stream<List<ViewedHistoryData>> watchHistory() => (select(
    viewedHistory,
  )..orderBy([(h) => OrderingTerm.desc(h.viewedAt)])).watch();

  // Adicionar item ao histórico
  Future<void> addToHistory(ViewedHistoryCompanion item) =>
      into(viewedHistory).insert(item);

  // Verificar se já foi visto
  Future<ViewedHistoryData?> getByContentId(String contentId) => (select(
    viewedHistory,
  )..where((h) => h.contentId.equals(contentId))).getSingleOrNull();

  // Apagar histórico antigo (mais de 30 dias)
  Future<void> deleteOldHistory(DateTime before) => (delete(
    viewedHistory,
  )..where((h) => h.viewedAt.isSmallerThanValue(before))).go();

  // Limpar todo o histórico
  Future<void> clearHistory() => delete(viewedHistory).go();
}
