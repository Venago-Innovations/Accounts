
import 'dart:async';

import 'package:accounts/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:input_history_text_field/input_history_text_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Database/database.dart';
import '../Database/synctoserver.dart';



class NewEntry extends StatefulWidget {

  NewEntry({ Key? key}) ;
  @override
  _NewEntry createState() => _NewEntry();
}


class _NewEntry extends State<NewEntry> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController   weight = TextEditingController();
  TextEditingController    description = TextEditingController();
  TextEditingController amount = TextEditingController();



  late bool  _connectionStatus;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;


  late FocusNode myFocusNode;


  @override

  void dispose() {
    _connectivitySubscription?.cancel();
    myFocusNode.dispose();

    super.dispose();
  }

  late int sitename;

  final List<String> _choicesList1 = ['PR SITE', 'ASHWANTH SITE', 'MAHIDHAR SITE','VEERSHAM SITE',"P 252",'POOL'];
  @override
  List<String> list1=[];
  void initState() {
    setState((){
    });
    myFocusNode = FocusNode();
    super.initState();
    sitename=0;
  }
  var iii;


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SynctoServer>(context,listen: false);
    return WillPopScope(
      onWillPop: ()async{
        bool leavepage = false;
        await showDialog(context: context,
            builder: (_)
            => AlertDialog(
              backgroundColor: constants.appbackgroundcolor,
              title: const Text("Do you want to leave this page?"),
              actions: [
                ElevatedButton(style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(10),
                    primary: constants.Tertiary,
                    elevation:12// Background color
                ),onPressed: (){
                  leavepage = true;
                  Navigator.of(context).pop();
                },
                    child: const Text("Yes")),
                TextButton(style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(10),
                  primary: constants.Tertiary,
                ),onPressed: ()=>Navigator.of(context).pop(),
                    child: const Text("No"))
              ],
            ));
        return leavepage;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(
            'NEW ENTRY',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: constants.kPrimaryColor,
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w500
            )),backgroundColor: constants.Grey,
          surfaceTintColor: constants.appbackgroundcolor,
          foregroundColor: constants.appbackgroundcolor,
          shadowColor: constants.appbackgroundcolor,iconTheme: const IconThemeData(
              color: Colors.white,
              opacity:2//change your color here
          ),),

      key: _scaffoldKey,
        backgroundColor: constants.appbackgroundcolor,
        body: SingleChildScrollView(
            child: Column(
              children: [
                OfflineBuilder(
                    connectivityBuilder: (
                        BuildContext context,
                        ConnectivityResult connectivity,
                        Widget child,
                        )
                    {
                      _connectionStatus = connectivity != ConnectivityResult.none;
                      final bool connect = _connectionStatus;
                      if (connect) {
                        _syncitnow(_connectionStatus);
                        print(_connectionStatus);
                      }

                      return Stack(
                          children: [
                            child]);
                    },
                    builder: (BuildContext context){
                      return const SizedBox();

                    }),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEEEEE),
                      ),
                      alignment:
                      const AlignmentDirectional(0.30000000000000004, 0.1499999999999999),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox.shrink(),
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: const BoxDecoration(),
                              child: Align(
                                alignment: const AlignmentDirectional(-0.2, -0.3),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0, -1),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                15, 15, 5, 5),
                                            child: Text(
                                              'SITE NAME',
                                              style: TextStyle(
                                                color: constants.kBlackColor,

                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: const AlignmentDirectional(-0.95, -1),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              5, 5, 0, 10),

                                          child: Wrap(
                                            spacing: 10,
                                            children: List.generate(_choicesList1.length, (index) {
                                              return ChoiceChip(
                                                label: Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: 30,
                                                  width: 130,
                                                  child: Center(
                                                    child: Text(
                                                      _choicesList1[index],textAlign: TextAlign.start,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(color: constants.kBlackColor, fontSize: 15,),

                                                    ),
                                                  ),
                                                ),
                                                selected: sitename == index,
                                                selectedColor: constants.Tertiary,
                                                onSelected: (value) {
                                                  setState(() {
                                                    sitename = value ? index : sitename;
                                                  });
                                                },
                                                // backgroundColor: color,
                                                elevation: 2,
                                              );
                                            }),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 100,
                              decoration: const BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Align(
                                    alignment: AlignmentDirectional(-1, -1),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 15, 5, 1),
                                      child: Text(
                                        'DESCRIPTION',
                                        style: TextStyle(
                                          color: constants.kBlackColor,

                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 1),
                                   child:   GestureDetector(

                                     child: InputHistoryTextField(
                                       textEditingController: description,
                                       historyKey: "01",
                                       listStyle: ListStyle.List,
                                       enableHistory: true,
                                       limit: 5,
                                       focusNode: myFocusNode,
                                       showHistoryList: true,
                                       decoration: InputDecoration(border:
                                       OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                         focusedBorder:
                                         OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                          color: Color(0xFF000101),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                      ),
                                       ),
                                     ),
                                   ),
                                  ),
                                ],
                              ),
                            ),





                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 5),
                              child: Container(
                                width: double.infinity,
                                height: 90,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment:
                                          const AlignmentDirectional(0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const Text(
                                                'AMOUNT',
                                                style: TextStyle(
                                                  color: constants.kBlackColor,

                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(5, 0, 5, 0),
                                                child: TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  controller: amount,
                                                  maxLength: 10,

                                                  // onChanged: (_) =>
                                                  //     EasyDebounce.debounce(
                                                  //       'textController3',
                                                  //       Duration(milliseconds: 2000),
                                                  //           () => setState(() {}),
                                                  //     ),
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    counterText:"" ,
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                        color: Color(0xFF000101),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                        color: Color(0xFF000101),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                    ),
                                                  ),
                                                  style: const TextStyle(
                                                    color: constants.kBlackColor,

                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment:
                                          const AlignmentDirectional(0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const Text(
                                                'QUANTITY',
                                                style: TextStyle(
                                                  color: constants.kBlackColor,

                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(5, 0, 5, 0),
                                                child: TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  controller: weight,
                                                  maxLength: 10,

                                                  // onChanged: (_) =>
                                                  //     EasyDebounce.debounce(
                                                  //       'textController3',
                                                  //       Duration(milliseconds: 2000),
                                                  //           () => setState(() {}),
                                                  //     ),
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    counterText:"" ,
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                        color: Color(0xFF000101),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                        color: Color(0xFF000101),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                    ),
                                                  ),
                                                  style: const TextStyle(
                                                    color: constants.kBlackColor,

                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),


                            Align(
                              alignment: const AlignmentDirectional(0, 0.1),
                              child: Padding(
                                padding:
                                const EdgeInsetsDirectional.all(20),
                                child: Container(
                                  width: 150,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius:
                                      BorderRadius.circular(15)),
                                      padding: const EdgeInsets.all(15),
                                      primary: constants.Tertiary,
                                    ),
                                    onPressed: () async{

                                      FocusManager.instance.primaryFocus?.unfocus();
                                     provider.userList(_choicesList1[sitename].toString(), description.text, amount.text, weight.text, sync,date,  _connectionStatus);
                                      Navigator.pop(context);

                                    },
                                    label: Text('SUBMIT',textAlign:TextAlign.start,softWrap: true,),
                                    icon: const Icon(Icons.navigate_next_rounded),

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
String date = DateFormat.yMd().add_jm().format(DateTime.now());

int sync=1;

  Future<dynamic> _getunsyncedrecords()async{
    final allRows = await SummaryDatabase.queryUnsynchedRecords();
    print('query all unsynched:');
    allRows.forEach((row) => print(row));
    return allRows;
  }
  void _syncitnow(_connectionStatus)async{
    final provider = Provider.of<SynctoServer>(context, listen: false);
    try {
      if (_connectionStatus == true) {
        var allRows = await _getunsyncedrecords();

        print(allRows);
        allRows.forEach((row) async
        {
          await provider.sync(
              row["id"].toString(),
              row["sitename"].toString(),
              row["description"],
              row["amount"],
              row["weight"],
              row["sync"].toString(),
              row["datetime"].toString(),
              _connectionStatus);

          await _updatetoserver(
            row["id"].toString(),
            row["sitename"].toString(),
            row["description"],
            row["amount"],
            row["weight"],
            row["sync"].toString(),
            row["datetime"].toString(),
          );
          setState(() {
            _getunsyncedrecords();
          });
        });
      }
    }catch(e)
    {
      print(e);
    }
  }

  Future<void> _updatetoserver( String id, String sitename, description, amount, weight, sync,datetime) async {
    int syncs=1;
    await SummaryDatabase.updateItemunsynched(
        id,
        syncs
    );

  }


}
