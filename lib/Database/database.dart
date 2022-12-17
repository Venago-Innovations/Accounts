import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SummaryDatabase {
  static var id = "id";
  static var sitename = 'sitename';
  static var description = "description";
  static var amount = "amount";
  static var weight = "weight";
  static var sync = "sync";
  static var datetime = "datetime";
  static const _databasename = 'Demo.sum';
  static const _databaseversion = 1;
  static const table = "summary";

  SummaryDatabase._privateContructor();

  static final SummaryDatabase instance = SummaryDatabase._privateContructor();

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE $table(
         $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $sitename TEXT NOT NULL,
        $description TEXT DEFAULT "N/A" NOT NULL,
        $amount TEXT DEFAULT "N/A" NOT NULL,
        $weight TEXT DEFAULT "N/A" NOT NULL,
        $sync INTEGER DEFAULT 1 NOT NULL,
        $datetime DATETIME NOT NULL
      )
      """);
  }

// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> dbs() async {
    return sql.openDatabase(
      _databasename,
      version: _databaseversion,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (table)
  static Future<int> CreateSummary(String sitename, description, amount, weight,
      sync) async {
    final db = await SummaryDatabase.dbs();
    String date = DateFormat.yMd().add_jm().format(DateTime.now());


    final data = {
      'description': description,
      'sitename': sitename,
      'amount': amount,
      'weight': weight,
      'sync': sync,
      "datetime":date,
    };
    final id = await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.rollback);
    print("ok");
    print(id);
    return id;
  }

  static Future<List<Map<String, dynamic>>> queryUnsynchedRecords() async {
    final db = await SummaryDatabase.dbs();
    return db.rawQuery('SELECT * FROM $table WHERE (sync ="0")');

  }
  static Future<List<Map<String, dynamic>>> history() async {
    final db = await SummaryDatabase.dbs();
    return db.rawQuery('SELECT * FROM $table');

  }

  static Future<String> updateItemunsynched(var id,sync) async {
    final db = await SummaryDatabase.dbs();

    final data = {
      'sync':sync
    };

    final result =
    await db.update(table, data, where: "id = ?", whereArgs: [id]);
    return result.toString();
  }
}





//model class for crateing the datatable
class SummaryModel {
  String id, sitename, description, amount, weight, sync,datetime;


  SummaryModel(this.id,this.sitename, this.description, this.amount, this.weight,
      this.sync,this.datetime);

  Map<String, dynamic> toJson() =>
      {
        'id': id.toString(),
        'sitename': sitename.toString(),
        'description': description.toString(),
        'amount': amount.toString(),
        'weight': weight.toString(),
        'datetime': datetime.toString(),
      };
}
