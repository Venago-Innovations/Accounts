import 'package:accounts/Screens/summary.dart';
import 'package:accounts/Utils.dart';
import 'package:flutter/material.dart';
import '../Database/database.dart';
import 'Home_page.dart';


class History extends StatefulWidget {

  const History({Key? key}) : super(key: key);

  @override
  _TicketNumber createState() => _TicketNumber();
}

class _TicketNumber extends State<History> {
  //this is used to fetch data from server
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  bool _isLoading = true;

  // This function is used to fetch all data from the database

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    // animationController.dispose() instead of your controller.dispose
  }


  List<SummaryModel> list = [];

  SummaryModel? model;
  void fetch() async {
    final allRows = await SummaryDatabase.history();

    for (var row in allRows) {
      {
        model = SummaryModel(
          row["id"].toString(),
            row["sitename"].toString(),
            row["description"],
            row["amount"],
            row["weight"],
          row["sync"].toString(),
          row["datetime"].toString(),
           );
        print(model!.sitename);

        list.add(model!);

      }
    }
    setState(() {

    });
  }


  @override
  void initState() {

      _isLoading = true;
      fetch();
    gridHeader();
    setState(() {
      searchField();
    });
    super.initState();
    _isLoading = false;
    // Loading the diary when the app starts
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
          'HISTORY',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w500
          )),leading: BackButton (
          color: constants.kPrimaryColor,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>const HomePage()),
                  (Route<dynamic> route) => false,
            );
          }
      ) ,backgroundColor: constants.Grey,
        surfaceTintColor: constants.appbackgroundcolor,
        foregroundColor: constants.appbackgroundcolor,
        shadowColor: constants.appbackgroundcolor,iconTheme: const IconThemeData(
            color: Colors.black,
            opacity:2//change your color here
        ),),
      backgroundColor: constants.appbackgroundcolor,
      body:
      RefreshIndicator(
        displacement: 250,
        backgroundColor: constants.kPrimaryColor,
        color:Colors.black,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,

        onRefresh: () async {
          return Future.delayed(
            const Duration(seconds: 1),
                () {
              /// adding elements in list after [1 seconds] delay
              /// to mimic network call
              ///
              /// Remember: [setState] is necessary so that
              /// build method will run again otherwise
              /// list will not show all elements
              setState(() {
                list.toList();
              });
            },
          );
        },
        child: SafeArea(


          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),

            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Divider(
                    height: 2,
                    thickness: 1,
                    color: constants.kBlackColor,
                  ),
                  Container(
                    child: searchField(),
                  ),
                  const Divider(
                    height: 2,
                    thickness: 1,
                    color: constants.kBlackColor,
                  ),
                  const SizedBox(height: 10,),
                  Expanded(child: _isLoading ?
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                      : gridHeader(),

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// All Ticket Numbers

  List<String>listHeader = ['Record'];


  gridHeader() {
    int currentSortColumn = 0;
    bool isAscending = true;
    if (list.isEmpty) {
      return const Center(
        child:  Text("No History Found",
          style:  TextStyle(color: Colors.black,
            fontSize: 20,
          ),
        ),

      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: RefreshIndicator(
          onRefresh:(){
            return Future.delayed(
              const Duration(seconds: 1),
                  () {
                /// adding elements in list after [1 seconds] delay
                /// to mimic network call
                ///
                /// Remember: [setState] is necessary so that
                /// build method will run again otherwise
                /// list will not show all elements
                setState(() {
                });
              },
            );
          } ,
          child: SingleChildScrollView(
            physics:  const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,

            child: DataTable(
                onSelectAll: (b) {},

                sortColumnIndex: currentSortColumn,
                sortAscending: isAscending,
                columns: <DataColumn>[
                  // DataColumn(
                  //   label: Text("id"),
                  //   numeric: false,
                  // ),
                  const DataColumn(
                    label: Text("Sl_No"),
                    numeric: false,
                    tooltip: "To display description",
                  ),
                  DataColumn(
                    label: const Text("Site_Name"),
                    numeric: false,
                    // onSort: (i, b) {
                    //   print("$i $b");
                    //   setState(() {
                    //     list.sort((a, b) =>
                    //         a.ticketnumber.compareTo(b.ticketnumber));
                    //   });
                    // },
                    onSort: (columnIndex, _) {

                      setState(() {
                        currentSortColumn = columnIndex;

                        if (isAscending == true) {
                          isAscending = false;
                          // sort the product list in Ascending, order by Price
                          list.sort((productA, productB) =>
                              productB.id.compareTo(productA.id));
                        } else {
                          isAscending = true;
                          // sort the product list in Descending, order by Price
                          list.sort((productA, productB) =>
                              productA.id.compareTo(productB.id));
                        }
                      });
                    },
                    tooltip: "To display Site_name",
                  ),
                  const DataColumn(
                    label: Text("Description"),
                    numeric: false,
                    tooltip: "To display description",
                  ),
                  const DataColumn(
                    label: Text("Amount"),
                    numeric: false,
                  ),
                  const DataColumn(
                    label: Text("Weight"),
                    numeric: false,
                  ),
                  const DataColumn(
                    label: Text("Date_Time"),
                    numeric: false,
                    tooltip: "To display description",
                  ),
                ],
                rows: list
                    .map(
                      (name) =>
                      DataRow(
                        cells: [
                          // DataCell(
                          //   Text(name.id),
                          //   showEditIcon: false,
                          //   placeholder: false,
                          // ),
                          DataCell(
                              Text(name.id.toString()),
                              showEditIcon: false,
                              placeholder: false,
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  summary(
                                    slno: name.id,
                                    sitename:name.sitename,
                                    des:name.description,
                                    amount: name.amount,
                                    weight:name.weight,
                                    sync:name.sync,
                                    datetime:name.datetime,

                                ),));
                                print(name.sitename);
                                print(name.datetime);
                              }
                          ),
                          DataCell(
                            Text(name.sitename),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(name.description),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(name.amount),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(name.weight),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(name.datetime),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          ],
                      ),
                )
                    .toList()),

          ),
        ),
      );
    }

  }




  final TextEditingController clearfield = TextEditingController();

  void _clearTextField() {
    // Clear everything in the text field
    clearfield.clear();
    // Call setState to update the UI
    setState(() {});
  }


  searchField() {
    return
      Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 15, 5, 15),
          child: TextFormField(
            controller: clearfield,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              // We will start filtering when the user types in the textfield.
              // Run the debouncer and start searching
              // Filter the original List and update the Filter list
              if (value.isEmpty) {
                fetch();
                list.clear();
              } else {
                setState(() {
                  list = list.where((u) =>
                  (u.id
                      .toLowerCase()
                      .contains(value.toLowerCase()) ||
                      u.description.toLowerCase().contains(value.toLowerCase())||
                      u.sitename.toLowerCase().contains(value.toLowerCase())))
                      .toList();
                });
              }
            },
            autofocus: true,
            obscureText: false,
            decoration: InputDecoration(
                hintText: 'Search tickets',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: constants.Tertiary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: constants.kBlackColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                contentPadding:
                const EdgeInsetsDirectional.fromSTEB(20, 5, 20, 5),
                prefixIcon: const Icon(
                  Icons.search,
                  color: constants.Tertiary,
                  size: 25,
                ),
                suffixIcon: clearfield.text.isEmpty ? null : IconButton(
                  icon: const Icon(Icons.clear),
                  color: constants.Tertiary,
                  iconSize: 25,
                  onPressed: (){
                    _clearTextField();
                    fetch();
                  },
                )
            ),
            style: const TextStyle(
                color: constants.kBlackColor,

                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                wordSpacing: 5
            ),
            textAlign: TextAlign.start,
          )
      );
  }


}
