import 'package:accounts/Database/database.dart';
import 'package:accounts/Googlesheetcode/gsheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SynctoServer with ChangeNotifier {

  final database = SummaryDatabase.instance;
  final List<SummaryModel> _list = [];
  List<SummaryModel> get list {
    return [..._list];
  }



  Future<void> userList(sitename, description, amount, weight, sync,datetime,_connectionStatus,) async {
    String date = DateFormat.yMd().add_jm().format(DateTime.now());

    int syncs=0;
    try {
if(_connectionStatus==true)
  {
    final  secondRow = [
      datetime, sitename, description, amount, weight
    ];
    await SummaryDatabase.CreateSummary(
        sitename.toString(),
        description.toString(),
        amount.toString(),
        weight.toString(),
        sync.toString()
    );
    if(sitename=="PR SITE")
    {
      Site1.insert([secondRow]);
    }
    else if(sitename=="ASHWANTH SITE")
    {
      Site2.insert([secondRow]);

    }
    else if(sitename=="MAHIDHAR SITE")
    {
      Site3.insert([secondRow]);

    }
    else if(sitename=="VEERSHAM SITE")
    {
      Site4.insert([secondRow]);
    }
    else if(sitename=="P 252")
    {
      Site5.insert([secondRow]);
    }
    else if(sitename=="POOL")
    {
      Site6.insert([secondRow]);
    }
  }

else{
  await SummaryDatabase.CreateSummary(
      sitename.toString(),
      description.toString(),
      amount.toString(),
      weight.toString(),
      syncs.toString());

}
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
  List<List<dynamic>> list1 = [];

  Future<void> sync( String id, sitename, description, amount, weight, sync,datetime,_connectionStatus) async {
   int sync =1;
    final  secondRow = [
      datetime, sitename, description, amount, weight
    ];
    list1.add(secondRow);

    try {
      if(sitename=="PR SITE")
      {
        Site1.insert([secondRow]);
      }
      else if(sitename=="ASHWANTH SITE")
      {
        Site2.insert([secondRow]);

      }
      else if(sitename=="MAHIDHAR SITE")
      {
        Site3.insert([secondRow]);

      }
      else if(sitename=="VEERSHAM SITE")
      {
        Site4.insert([secondRow]);
      } else if(sitename=="P 252")
      {
        Site5.insert([secondRow]);
      }
      else if(sitename=="POOL")
      {
        Site6.insert([secondRow]);
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }


}



