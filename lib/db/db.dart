// Try to use "primary key" for selecting data by unique key.
// ignore_for_file: invalid_use_of_visible_for_overriding_member

import 'package:drift/drift.dart';
import 'package:not_zero/db/provider.dart';
import 'package:not_zero/db/tasks_table.dart';
import 'package:not_zero/units/tasks/domain/models/task.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';
// Relative imports are usefull here because of conditional imports.
// ignore: always_use_package_imports
import 'drift/unsupported_database.dart'
    if (dart.library.ffi) 'drift/native_database.dart'
    if (dart.library.html) 'drift/web_database.dart';

part 'db.g.dart';

@DriftDatabase(tables: [TasksTable])
class NotZeroDatabase extends _$NotZeroDatabase {
  NotZeroDatabase() : super(openDriftDatabase());

  @override
  int get schemaVersion => 1;

  Future<void> drop() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }

  Future<void> deleteFromDisk() async {
    final dbFile = File(await _getDatabasePath());
    if (dbFile.existsSync()) {
      await close();
      dbFile.deleteSync();
    }
  }

  Future<void> upsertIn<T extends Table, D>(
    TableInfo<T, D> table,
    Insertable<D> insertable,
  ) {
    return into(table).insertOnConflictUpdate(insertable);
  }

  Future<D?> findByKey<T extends Table, D>(
    TableInfo<T, D> table,
    Object key,
  ) {
    return (select(table)..where((tbl) => tbl.primaryKey!.single.equals(key)))
        .getSingleOrNull();
  }

  Future<void> deleteByKey<T extends Table, D>(
    TableInfo<T, D> table,
    Object key,
  ) {
    return (delete(table)..where((tbl) => tbl.primaryKey!.single.equals(key)))
        .go();
  }
}

Future<String> _getDatabasePath() async {
  final storagePath = await StorageProvider.storageDirectory;
  return p.join(storagePath, 'db.sqlite');
}
