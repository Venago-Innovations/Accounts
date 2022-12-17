import 'package:accounts/Utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class summary extends StatelessWidget {




 String slno;
  String sitename;
  String des;
  String amount;
 String weight;
  String sync;
  String datetime;



  // This function is used to fetch all data from the database


  summary({Key? key,required this.slno,required this.des,required this.amount,required this.weight,required this.datetime,required this.sitename,required this.sync})
      : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
          'DETAILS',
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
      key: scaffoldKey,
      backgroundColor: constants.appbackgroundcolor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity*MediaQuery.of(context).devicePixelRatio,
            height: double.infinity*MediaQuery.of(context).devicePixelRatio,
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Divider(
                  height: 2,
                  thickness: 1,
                  color: constants.kBlackColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15,left:2,right:2),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0x92B7B5B5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:const [
                              Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      '',
                                      style: TextStyle(
                                        color: constants.kBlackColor,

                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'SL NO',
                                      style: TextStyle(
                                        color: constants.kBlackColor,

                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'DESCRIPTION',
                                      style: TextStyle(
                                        color: constants.kBlackColor,

                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'AMOUNT',
                                      style: TextStyle(
                                        color: constants.kBlackColor,

                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'QUANTITY',
                                      style: TextStyle(
                                        color: constants.kBlackColor,

                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'SITE_NAME',
                                      style: TextStyle(
                                        color: constants.kBlackColor,
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'DATE_TIME',
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
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment:  CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25,bottom: 5,left: 5,right: 5),
                                    child: Text(
                                      ':        $slno',
                                      style: const TextStyle(
                                          color: constants.kBlackColor,

                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold

                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      ':        $des  ',
                                      style: const TextStyle(
                                          color: constants.kBlackColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold

                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      ':        $amount  ',
                                      style: const TextStyle(
                                          color: constants.kBlackColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold

                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      ':        $weight  ',
                                      style: const TextStyle(
                                          color: constants.kBlackColor,

                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold

                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      ':        $sitename',
                                      style: const TextStyle(
                                          color: constants.kBlackColor,

                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold

                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      ':         $datetime',
                                      style: const TextStyle(
                                        color: constants.kBlackColor,

                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Container(
                      height: 50,
                      width: 100,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius:
                            BorderRadius.circular(15)),
                            primary: constants.Tertiary,
                            elevation:12// Background color
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: const Text('Back'),
                        icon: const Icon(
                          Icons.navigate_before,
                          color:
                          constants.kPrimaryColor,
                          size: 15,
                        ),

                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


// Insert a new transacton details to the database

}
