import 'package:gsheets/gsheets.dart';
import 'Sheetmodel.dart';

class Site1{

  static const String _sheetId = "10KLiOd_8BMzN1CXCyDqX8G96Z0xkU2tkWjLvvOT6CDE";
  static const _sheetCredentials = r'''
 {
  "type": "service_account",
  "project_id": "sites-365606",
  "private_key_id": "5432b8f0233b567373e2e89b0ea25f7d2ff683a3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCb2hui8QFyWcv/\nC7IL0rLes9qrx+Cz0JnW1hQ0AMu9f/LFkwJdHQpeAsvR4jv5bUafVGVXsCUYcv4i\nEKF/YO/qcp4UWi2z7M2FdmoCUJtENOVEBC0yvHcSC3/wj/a393qP5X18kEdjRbZs\nddqMG/f0TsqgWVqlFdXaQoiUeGqvt6l2udILo2ubZz4cmBL70lB9CS/nPk3Y9Yaj\nyW5V+aYzjHUerKvFKbIAQhg00ABmJYJZe9YD4q8Ur7oLw+cwPoeyA5+N4yK2GwQa\nHkc0GXHuQXOBH10shzwUNRbz8/sRFVYzEIpdTFTVriHiQoS6fClZgs+CcaUz1xrS\nSlijHEy5AgMBAAECggEAMMVRpa1OmxavqDnkNx/xupBEy0HKtup94cVvYBCpsTzj\nX2GQOUw3rNCqMJ1f0D+afIygBA9KpHqDvWw/5YkTuuWwQ0UvDSF69RtntB6+X9s/\nrYezDy/8AOkZWdHrTomC0JnrqXnK5S1xF0LQJ80uzESF0yTzITsSh3EPpYqDNEZD\nmwBKDASj9z7XQjo1sTWJ/36X4YSd+gc+dZf3iqBxLC5Lq2Sz53e38Axn7Y+4cJTt\nPKB9LmFLSXK+JtQgoKCoEOdKQKVF03svDi0GvxoluxSahAjAPe6MZxZKb1qgJIcO\nP2Y4B9PFinJeh4TqWBkkXzd8PXOo6srb8Kz0hFK1awKBgQDKQ1NcqgKaFm70YZQP\n0XnqVcca0kzyydKB+Txzb2fEJ+MdnhpXGW28ERT5WIRXpvuhE18iENruAM0X3lZA\naEaifUQhiI/3Kn/4K75UmMoirApLsE/pxOjRNeiu5wQViGvd9anH9ePpF/clTJC4\nI89RBXllGTSYD3pExfE+yann/wKBgQDFQjGGfCbFDPoN41D0z7fx2i7ZIfGH0FPj\nS8Ivg4bR1D7JJEhq2a//TJXxl7oDB6IXB5cNxqYLWj/fCreGNFuSrShBzJWz7wE0\nOHh9T+KE8yimRoSp9swUuvOUbKpmTX+DG0Y5a0LhiXN+Tj0IOWLsW8C5PvRvbkzP\n0A7qD/sLRwKBgDVjjhaQnb00nLcPJrkCLy8m0zaGOl9/3HwIYOeLiZViffWsbQF+\nqdORorqqncxRPGxpI5xnXJKkTX62Zof7vmFXtWswk+fHJR5J1aSY7Ao45ULTWFS5\ncEcA9tlsC0zvxKFDHjy08CLv+4Gx8yVX9npJeqCwBYz50OlkYmiTbLDbAoGAe37T\njsTPaPKU4nj8SCh7mvjj96CenE67FkRp0GFh2KAuprMGe47J9uW1wkkhdaAjxJNF\n6KQDdHwOHM+S0nyZEB1EZN12o+3wLQdlt955jI7HVkIz8EzIu/nHYZcen2nJeQVs\nU6ppdtYc7miBIVL8McnHwLI/Sjwd7sTtcXCL1SUCgYEAtfGvQ+UvhCnk9/tJh1Ol\ntvmNgg2d3Sxw8riKLTJOsoqC4HjnJdmRqlgzQgzzYePImEBJalMCK2pZ8piH5GCe\nrE5aPQC7ylEEuzq2dcrcDz/Ns6WgcFfDKqcwQDzOBu7QpVVIFnNOqS0oCQoQStwZ\npn15jGItgqKLXdXavQyaS9I=\n-----END PRIVATE KEY-----\n",
  "client_email": "sites-762@sites-365606.iam.gserviceaccount.com",
  "client_id": "117021335003435356045",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sites-762%40sites-365606.iam.gserviceaccount.com"
}
''';
  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);
//load the googlesheets credentials while opening the app
  static Future init() async {

    try{
      final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: "PR SITE");
      final firstRow = sheetSummarydata.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch(e) {
      print(e);
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  //insert the list of rows one by one in googlesheets
  static  insert(array)async {
    final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId.toString());
    _userSheet = await _getWorkSheet(spreadsheet, title: "PR SITE");
    try {
      print(array);
      if (array.isEmpty) {
        print("empty list");
      }
      else {
        _userSheet!.values.appendRows(array);
      }
    }catch(e)
    {
      print(e);
    }
  }


}
class Site2{

  static const String _sheetId = "10KLiOd_8BMzN1CXCyDqX8G96Z0xkU2tkWjLvvOT6CDE";
  static const _sheetCredentials = r'''
 {
  "type": "service_account",
  "project_id": "sites-365606",
  "private_key_id": "5432b8f0233b567373e2e89b0ea25f7d2ff683a3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCb2hui8QFyWcv/\nC7IL0rLes9qrx+Cz0JnW1hQ0AMu9f/LFkwJdHQpeAsvR4jv5bUafVGVXsCUYcv4i\nEKF/YO/qcp4UWi2z7M2FdmoCUJtENOVEBC0yvHcSC3/wj/a393qP5X18kEdjRbZs\nddqMG/f0TsqgWVqlFdXaQoiUeGqvt6l2udILo2ubZz4cmBL70lB9CS/nPk3Y9Yaj\nyW5V+aYzjHUerKvFKbIAQhg00ABmJYJZe9YD4q8Ur7oLw+cwPoeyA5+N4yK2GwQa\nHkc0GXHuQXOBH10shzwUNRbz8/sRFVYzEIpdTFTVriHiQoS6fClZgs+CcaUz1xrS\nSlijHEy5AgMBAAECggEAMMVRpa1OmxavqDnkNx/xupBEy0HKtup94cVvYBCpsTzj\nX2GQOUw3rNCqMJ1f0D+afIygBA9KpHqDvWw/5YkTuuWwQ0UvDSF69RtntB6+X9s/\nrYezDy/8AOkZWdHrTomC0JnrqXnK5S1xF0LQJ80uzESF0yTzITsSh3EPpYqDNEZD\nmwBKDASj9z7XQjo1sTWJ/36X4YSd+gc+dZf3iqBxLC5Lq2Sz53e38Axn7Y+4cJTt\nPKB9LmFLSXK+JtQgoKCoEOdKQKVF03svDi0GvxoluxSahAjAPe6MZxZKb1qgJIcO\nP2Y4B9PFinJeh4TqWBkkXzd8PXOo6srb8Kz0hFK1awKBgQDKQ1NcqgKaFm70YZQP\n0XnqVcca0kzyydKB+Txzb2fEJ+MdnhpXGW28ERT5WIRXpvuhE18iENruAM0X3lZA\naEaifUQhiI/3Kn/4K75UmMoirApLsE/pxOjRNeiu5wQViGvd9anH9ePpF/clTJC4\nI89RBXllGTSYD3pExfE+yann/wKBgQDFQjGGfCbFDPoN41D0z7fx2i7ZIfGH0FPj\nS8Ivg4bR1D7JJEhq2a//TJXxl7oDB6IXB5cNxqYLWj/fCreGNFuSrShBzJWz7wE0\nOHh9T+KE8yimRoSp9swUuvOUbKpmTX+DG0Y5a0LhiXN+Tj0IOWLsW8C5PvRvbkzP\n0A7qD/sLRwKBgDVjjhaQnb00nLcPJrkCLy8m0zaGOl9/3HwIYOeLiZViffWsbQF+\nqdORorqqncxRPGxpI5xnXJKkTX62Zof7vmFXtWswk+fHJR5J1aSY7Ao45ULTWFS5\ncEcA9tlsC0zvxKFDHjy08CLv+4Gx8yVX9npJeqCwBYz50OlkYmiTbLDbAoGAe37T\njsTPaPKU4nj8SCh7mvjj96CenE67FkRp0GFh2KAuprMGe47J9uW1wkkhdaAjxJNF\n6KQDdHwOHM+S0nyZEB1EZN12o+3wLQdlt955jI7HVkIz8EzIu/nHYZcen2nJeQVs\nU6ppdtYc7miBIVL8McnHwLI/Sjwd7sTtcXCL1SUCgYEAtfGvQ+UvhCnk9/tJh1Ol\ntvmNgg2d3Sxw8riKLTJOsoqC4HjnJdmRqlgzQgzzYePImEBJalMCK2pZ8piH5GCe\nrE5aPQC7ylEEuzq2dcrcDz/Ns6WgcFfDKqcwQDzOBu7QpVVIFnNOqS0oCQoQStwZ\npn15jGItgqKLXdXavQyaS9I=\n-----END PRIVATE KEY-----\n",
  "client_email": "sites-762@sites-365606.iam.gserviceaccount.com",
  "client_id": "117021335003435356045",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sites-762%40sites-365606.iam.gserviceaccount.com"
}
''';
  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);
//load the googlesheets credentials while opening the app
  static Future init() async {

    try{
      final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: "ASHWANTH SITE");
      final firstRow = sheetSummarydata.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch(e) {
      print(e);
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  //insert the list of rows one by one in googlesheets
  static  insert(array)async {
    final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId.toString());
    _userSheet = await _getWorkSheet(spreadsheet, title: "ASHWANTH SITE");
    try {
      print(array);
      if (array.isEmpty) {
        print("empty list");
      }
      else {
        _userSheet!.values.appendRows(array);
      }
    }catch(e)
    {
      print(e);
    }
  }


}
class Site3{

  static const String _sheetId = "10KLiOd_8BMzN1CXCyDqX8G96Z0xkU2tkWjLvvOT6CDE";
  static const _sheetCredentials = r'''
 {
  "type": "service_account",
  "project_id": "sites-365606",
  "private_key_id": "5432b8f0233b567373e2e89b0ea25f7d2ff683a3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCb2hui8QFyWcv/\nC7IL0rLes9qrx+Cz0JnW1hQ0AMu9f/LFkwJdHQpeAsvR4jv5bUafVGVXsCUYcv4i\nEKF/YO/qcp4UWi2z7M2FdmoCUJtENOVEBC0yvHcSC3/wj/a393qP5X18kEdjRbZs\nddqMG/f0TsqgWVqlFdXaQoiUeGqvt6l2udILo2ubZz4cmBL70lB9CS/nPk3Y9Yaj\nyW5V+aYzjHUerKvFKbIAQhg00ABmJYJZe9YD4q8Ur7oLw+cwPoeyA5+N4yK2GwQa\nHkc0GXHuQXOBH10shzwUNRbz8/sRFVYzEIpdTFTVriHiQoS6fClZgs+CcaUz1xrS\nSlijHEy5AgMBAAECggEAMMVRpa1OmxavqDnkNx/xupBEy0HKtup94cVvYBCpsTzj\nX2GQOUw3rNCqMJ1f0D+afIygBA9KpHqDvWw/5YkTuuWwQ0UvDSF69RtntB6+X9s/\nrYezDy/8AOkZWdHrTomC0JnrqXnK5S1xF0LQJ80uzESF0yTzITsSh3EPpYqDNEZD\nmwBKDASj9z7XQjo1sTWJ/36X4YSd+gc+dZf3iqBxLC5Lq2Sz53e38Axn7Y+4cJTt\nPKB9LmFLSXK+JtQgoKCoEOdKQKVF03svDi0GvxoluxSahAjAPe6MZxZKb1qgJIcO\nP2Y4B9PFinJeh4TqWBkkXzd8PXOo6srb8Kz0hFK1awKBgQDKQ1NcqgKaFm70YZQP\n0XnqVcca0kzyydKB+Txzb2fEJ+MdnhpXGW28ERT5WIRXpvuhE18iENruAM0X3lZA\naEaifUQhiI/3Kn/4K75UmMoirApLsE/pxOjRNeiu5wQViGvd9anH9ePpF/clTJC4\nI89RBXllGTSYD3pExfE+yann/wKBgQDFQjGGfCbFDPoN41D0z7fx2i7ZIfGH0FPj\nS8Ivg4bR1D7JJEhq2a//TJXxl7oDB6IXB5cNxqYLWj/fCreGNFuSrShBzJWz7wE0\nOHh9T+KE8yimRoSp9swUuvOUbKpmTX+DG0Y5a0LhiXN+Tj0IOWLsW8C5PvRvbkzP\n0A7qD/sLRwKBgDVjjhaQnb00nLcPJrkCLy8m0zaGOl9/3HwIYOeLiZViffWsbQF+\nqdORorqqncxRPGxpI5xnXJKkTX62Zof7vmFXtWswk+fHJR5J1aSY7Ao45ULTWFS5\ncEcA9tlsC0zvxKFDHjy08CLv+4Gx8yVX9npJeqCwBYz50OlkYmiTbLDbAoGAe37T\njsTPaPKU4nj8SCh7mvjj96CenE67FkRp0GFh2KAuprMGe47J9uW1wkkhdaAjxJNF\n6KQDdHwOHM+S0nyZEB1EZN12o+3wLQdlt955jI7HVkIz8EzIu/nHYZcen2nJeQVs\nU6ppdtYc7miBIVL8McnHwLI/Sjwd7sTtcXCL1SUCgYEAtfGvQ+UvhCnk9/tJh1Ol\ntvmNgg2d3Sxw8riKLTJOsoqC4HjnJdmRqlgzQgzzYePImEBJalMCK2pZ8piH5GCe\nrE5aPQC7ylEEuzq2dcrcDz/Ns6WgcFfDKqcwQDzOBu7QpVVIFnNOqS0oCQoQStwZ\npn15jGItgqKLXdXavQyaS9I=\n-----END PRIVATE KEY-----\n",
  "client_email": "sites-762@sites-365606.iam.gserviceaccount.com",
  "client_id": "117021335003435356045",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sites-762%40sites-365606.iam.gserviceaccount.com"
}
''';
  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);
//load the googlesheets credentials while opening the app
  static Future init() async {

    try{
      final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: "MAHIDHAR SITE");
      final firstRow = sheetSummarydata.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch(e) {
      print(e);
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  //insert the list of rows one by one in googlesheets
  static  insert(array)async {
    final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId.toString());
    _userSheet = await _getWorkSheet(spreadsheet, title: "MAHIDHAR SITE");
    try {
      print(array);
      if (array.isEmpty) {
        print("empty list");
      }
      else {
        _userSheet!.values.appendRows(array);
      }
    }catch(e)
    {
      print(e);
    }
  }


}
class Site4{

  static const String _sheetId = "10KLiOd_8BMzN1CXCyDqX8G96Z0xkU2tkWjLvvOT6CDE";
  static const _sheetCredentials = r'''
 {
  "type": "service_account",
  "project_id": "sites-365606",
  "private_key_id": "5432b8f0233b567373e2e89b0ea25f7d2ff683a3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCb2hui8QFyWcv/\nC7IL0rLes9qrx+Cz0JnW1hQ0AMu9f/LFkwJdHQpeAsvR4jv5bUafVGVXsCUYcv4i\nEKF/YO/qcp4UWi2z7M2FdmoCUJtENOVEBC0yvHcSC3/wj/a393qP5X18kEdjRbZs\nddqMG/f0TsqgWVqlFdXaQoiUeGqvt6l2udILo2ubZz4cmBL70lB9CS/nPk3Y9Yaj\nyW5V+aYzjHUerKvFKbIAQhg00ABmJYJZe9YD4q8Ur7oLw+cwPoeyA5+N4yK2GwQa\nHkc0GXHuQXOBH10shzwUNRbz8/sRFVYzEIpdTFTVriHiQoS6fClZgs+CcaUz1xrS\nSlijHEy5AgMBAAECggEAMMVRpa1OmxavqDnkNx/xupBEy0HKtup94cVvYBCpsTzj\nX2GQOUw3rNCqMJ1f0D+afIygBA9KpHqDvWw/5YkTuuWwQ0UvDSF69RtntB6+X9s/\nrYezDy/8AOkZWdHrTomC0JnrqXnK5S1xF0LQJ80uzESF0yTzITsSh3EPpYqDNEZD\nmwBKDASj9z7XQjo1sTWJ/36X4YSd+gc+dZf3iqBxLC5Lq2Sz53e38Axn7Y+4cJTt\nPKB9LmFLSXK+JtQgoKCoEOdKQKVF03svDi0GvxoluxSahAjAPe6MZxZKb1qgJIcO\nP2Y4B9PFinJeh4TqWBkkXzd8PXOo6srb8Kz0hFK1awKBgQDKQ1NcqgKaFm70YZQP\n0XnqVcca0kzyydKB+Txzb2fEJ+MdnhpXGW28ERT5WIRXpvuhE18iENruAM0X3lZA\naEaifUQhiI/3Kn/4K75UmMoirApLsE/pxOjRNeiu5wQViGvd9anH9ePpF/clTJC4\nI89RBXllGTSYD3pExfE+yann/wKBgQDFQjGGfCbFDPoN41D0z7fx2i7ZIfGH0FPj\nS8Ivg4bR1D7JJEhq2a//TJXxl7oDB6IXB5cNxqYLWj/fCreGNFuSrShBzJWz7wE0\nOHh9T+KE8yimRoSp9swUuvOUbKpmTX+DG0Y5a0LhiXN+Tj0IOWLsW8C5PvRvbkzP\n0A7qD/sLRwKBgDVjjhaQnb00nLcPJrkCLy8m0zaGOl9/3HwIYOeLiZViffWsbQF+\nqdORorqqncxRPGxpI5xnXJKkTX62Zof7vmFXtWswk+fHJR5J1aSY7Ao45ULTWFS5\ncEcA9tlsC0zvxKFDHjy08CLv+4Gx8yVX9npJeqCwBYz50OlkYmiTbLDbAoGAe37T\njsTPaPKU4nj8SCh7mvjj96CenE67FkRp0GFh2KAuprMGe47J9uW1wkkhdaAjxJNF\n6KQDdHwOHM+S0nyZEB1EZN12o+3wLQdlt955jI7HVkIz8EzIu/nHYZcen2nJeQVs\nU6ppdtYc7miBIVL8McnHwLI/Sjwd7sTtcXCL1SUCgYEAtfGvQ+UvhCnk9/tJh1Ol\ntvmNgg2d3Sxw8riKLTJOsoqC4HjnJdmRqlgzQgzzYePImEBJalMCK2pZ8piH5GCe\nrE5aPQC7ylEEuzq2dcrcDz/Ns6WgcFfDKqcwQDzOBu7QpVVIFnNOqS0oCQoQStwZ\npn15jGItgqKLXdXavQyaS9I=\n-----END PRIVATE KEY-----\n",
  "client_email": "sites-762@sites-365606.iam.gserviceaccount.com",
  "client_id": "117021335003435356045",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sites-762%40sites-365606.iam.gserviceaccount.com"
}
''';
  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);
//load the googlesheets credentials while opening the app
  static Future init() async {

    try{
      final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: "VEERSHAM SITE");
      final firstRow = sheetSummarydata.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch(e) {
      print(e);
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  //insert the list of rows one by one in googlesheets
  static  insert(array)async {
    final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId.toString());
    _userSheet = await _getWorkSheet(spreadsheet, title: "VEERSHAM SITE");
    try {
      print(array);
      if (array.isEmpty) {
        print("empty list");
      }
      else {
        _userSheet!.values.appendRows(array);
      }
    }catch(e)
    {
      print(e);
    }
  }


}
class Site5{

  static const String _sheetId = "10KLiOd_8BMzN1CXCyDqX8G96Z0xkU2tkWjLvvOT6CDE";
  static const _sheetCredentials = r'''
 {
  "type": "service_account",
  "project_id": "sites-365606",
  "private_key_id": "5432b8f0233b567373e2e89b0ea25f7d2ff683a3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCb2hui8QFyWcv/\nC7IL0rLes9qrx+Cz0JnW1hQ0AMu9f/LFkwJdHQpeAsvR4jv5bUafVGVXsCUYcv4i\nEKF/YO/qcp4UWi2z7M2FdmoCUJtENOVEBC0yvHcSC3/wj/a393qP5X18kEdjRbZs\nddqMG/f0TsqgWVqlFdXaQoiUeGqvt6l2udILo2ubZz4cmBL70lB9CS/nPk3Y9Yaj\nyW5V+aYzjHUerKvFKbIAQhg00ABmJYJZe9YD4q8Ur7oLw+cwPoeyA5+N4yK2GwQa\nHkc0GXHuQXOBH10shzwUNRbz8/sRFVYzEIpdTFTVriHiQoS6fClZgs+CcaUz1xrS\nSlijHEy5AgMBAAECggEAMMVRpa1OmxavqDnkNx/xupBEy0HKtup94cVvYBCpsTzj\nX2GQOUw3rNCqMJ1f0D+afIygBA9KpHqDvWw/5YkTuuWwQ0UvDSF69RtntB6+X9s/\nrYezDy/8AOkZWdHrTomC0JnrqXnK5S1xF0LQJ80uzESF0yTzITsSh3EPpYqDNEZD\nmwBKDASj9z7XQjo1sTWJ/36X4YSd+gc+dZf3iqBxLC5Lq2Sz53e38Axn7Y+4cJTt\nPKB9LmFLSXK+JtQgoKCoEOdKQKVF03svDi0GvxoluxSahAjAPe6MZxZKb1qgJIcO\nP2Y4B9PFinJeh4TqWBkkXzd8PXOo6srb8Kz0hFK1awKBgQDKQ1NcqgKaFm70YZQP\n0XnqVcca0kzyydKB+Txzb2fEJ+MdnhpXGW28ERT5WIRXpvuhE18iENruAM0X3lZA\naEaifUQhiI/3Kn/4K75UmMoirApLsE/pxOjRNeiu5wQViGvd9anH9ePpF/clTJC4\nI89RBXllGTSYD3pExfE+yann/wKBgQDFQjGGfCbFDPoN41D0z7fx2i7ZIfGH0FPj\nS8Ivg4bR1D7JJEhq2a//TJXxl7oDB6IXB5cNxqYLWj/fCreGNFuSrShBzJWz7wE0\nOHh9T+KE8yimRoSp9swUuvOUbKpmTX+DG0Y5a0LhiXN+Tj0IOWLsW8C5PvRvbkzP\n0A7qD/sLRwKBgDVjjhaQnb00nLcPJrkCLy8m0zaGOl9/3HwIYOeLiZViffWsbQF+\nqdORorqqncxRPGxpI5xnXJKkTX62Zof7vmFXtWswk+fHJR5J1aSY7Ao45ULTWFS5\ncEcA9tlsC0zvxKFDHjy08CLv+4Gx8yVX9npJeqCwBYz50OlkYmiTbLDbAoGAe37T\njsTPaPKU4nj8SCh7mvjj96CenE67FkRp0GFh2KAuprMGe47J9uW1wkkhdaAjxJNF\n6KQDdHwOHM+S0nyZEB1EZN12o+3wLQdlt955jI7HVkIz8EzIu/nHYZcen2nJeQVs\nU6ppdtYc7miBIVL8McnHwLI/Sjwd7sTtcXCL1SUCgYEAtfGvQ+UvhCnk9/tJh1Ol\ntvmNgg2d3Sxw8riKLTJOsoqC4HjnJdmRqlgzQgzzYePImEBJalMCK2pZ8piH5GCe\nrE5aPQC7ylEEuzq2dcrcDz/Ns6WgcFfDKqcwQDzOBu7QpVVIFnNOqS0oCQoQStwZ\npn15jGItgqKLXdXavQyaS9I=\n-----END PRIVATE KEY-----\n",
  "client_email": "sites-762@sites-365606.iam.gserviceaccount.com",
  "client_id": "117021335003435356045",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sites-762%40sites-365606.iam.gserviceaccount.com"
}
''';
  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);
//load the googlesheets credentials while opening the app
  static Future init() async {

    try{
      final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: "P 252");
      final firstRow = sheetSummarydata.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch(e) {
      print(e);
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  //insert the list of rows one by one in googlesheets
  static  insert(array)async {
    final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId.toString());
    _userSheet = await _getWorkSheet(spreadsheet, title: "P 252");
    try {
      print(array);
      if (array.isEmpty) {
        print("empty list");
      }
      else {
        _userSheet!.values.appendRows(array);
      }
    }catch(e)
    {
      print(e);
    }
  }


}
class Site6{

  static const String _sheetId = "10KLiOd_8BMzN1CXCyDqX8G96Z0xkU2tkWjLvvOT6CDE";
  static const _sheetCredentials = r'''
 {
  "type": "service_account",
  "project_id": "sites-365606",
  "private_key_id": "5432b8f0233b567373e2e89b0ea25f7d2ff683a3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCb2hui8QFyWcv/\nC7IL0rLes9qrx+Cz0JnW1hQ0AMu9f/LFkwJdHQpeAsvR4jv5bUafVGVXsCUYcv4i\nEKF/YO/qcp4UWi2z7M2FdmoCUJtENOVEBC0yvHcSC3/wj/a393qP5X18kEdjRbZs\nddqMG/f0TsqgWVqlFdXaQoiUeGqvt6l2udILo2ubZz4cmBL70lB9CS/nPk3Y9Yaj\nyW5V+aYzjHUerKvFKbIAQhg00ABmJYJZe9YD4q8Ur7oLw+cwPoeyA5+N4yK2GwQa\nHkc0GXHuQXOBH10shzwUNRbz8/sRFVYzEIpdTFTVriHiQoS6fClZgs+CcaUz1xrS\nSlijHEy5AgMBAAECggEAMMVRpa1OmxavqDnkNx/xupBEy0HKtup94cVvYBCpsTzj\nX2GQOUw3rNCqMJ1f0D+afIygBA9KpHqDvWw/5YkTuuWwQ0UvDSF69RtntB6+X9s/\nrYezDy/8AOkZWdHrTomC0JnrqXnK5S1xF0LQJ80uzESF0yTzITsSh3EPpYqDNEZD\nmwBKDASj9z7XQjo1sTWJ/36X4YSd+gc+dZf3iqBxLC5Lq2Sz53e38Axn7Y+4cJTt\nPKB9LmFLSXK+JtQgoKCoEOdKQKVF03svDi0GvxoluxSahAjAPe6MZxZKb1qgJIcO\nP2Y4B9PFinJeh4TqWBkkXzd8PXOo6srb8Kz0hFK1awKBgQDKQ1NcqgKaFm70YZQP\n0XnqVcca0kzyydKB+Txzb2fEJ+MdnhpXGW28ERT5WIRXpvuhE18iENruAM0X3lZA\naEaifUQhiI/3Kn/4K75UmMoirApLsE/pxOjRNeiu5wQViGvd9anH9ePpF/clTJC4\nI89RBXllGTSYD3pExfE+yann/wKBgQDFQjGGfCbFDPoN41D0z7fx2i7ZIfGH0FPj\nS8Ivg4bR1D7JJEhq2a//TJXxl7oDB6IXB5cNxqYLWj/fCreGNFuSrShBzJWz7wE0\nOHh9T+KE8yimRoSp9swUuvOUbKpmTX+DG0Y5a0LhiXN+Tj0IOWLsW8C5PvRvbkzP\n0A7qD/sLRwKBgDVjjhaQnb00nLcPJrkCLy8m0zaGOl9/3HwIYOeLiZViffWsbQF+\nqdORorqqncxRPGxpI5xnXJKkTX62Zof7vmFXtWswk+fHJR5J1aSY7Ao45ULTWFS5\ncEcA9tlsC0zvxKFDHjy08CLv+4Gx8yVX9npJeqCwBYz50OlkYmiTbLDbAoGAe37T\njsTPaPKU4nj8SCh7mvjj96CenE67FkRp0GFh2KAuprMGe47J9uW1wkkhdaAjxJNF\n6KQDdHwOHM+S0nyZEB1EZN12o+3wLQdlt955jI7HVkIz8EzIu/nHYZcen2nJeQVs\nU6ppdtYc7miBIVL8McnHwLI/Sjwd7sTtcXCL1SUCgYEAtfGvQ+UvhCnk9/tJh1Ol\ntvmNgg2d3Sxw8riKLTJOsoqC4HjnJdmRqlgzQgzzYePImEBJalMCK2pZ8piH5GCe\nrE5aPQC7ylEEuzq2dcrcDz/Ns6WgcFfDKqcwQDzOBu7QpVVIFnNOqS0oCQoQStwZ\npn15jGItgqKLXdXavQyaS9I=\n-----END PRIVATE KEY-----\n",
  "client_email": "sites-762@sites-365606.iam.gserviceaccount.com",
  "client_id": "117021335003435356045",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sites-762%40sites-365606.iam.gserviceaccount.com"
}
''';
  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);
//load the googlesheets credentials while opening the app
  static Future init() async {

    try{
      final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: "POOL");
      final firstRow = sheetSummarydata.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch(e) {
      print(e);
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  //insert the list of rows one by one in googlesheets
  static  insert(array)async {
    final spreadsheet = await GSheets(_sheetCredentials).spreadsheet(_sheetId.toString());
    _userSheet = await _getWorkSheet(spreadsheet, title: "POOL");
    try {
      print(array);
      if (array.isEmpty) {
        print("empty list");
      }
      else {
        _userSheet!.values.appendRows(array);
      }
    }catch(e)
    {
      print(e);
    }
  }


}
