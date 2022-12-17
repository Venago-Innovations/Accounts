import 'package:accounts/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'History.dart';
import 'New_entry.dart';


class HomePage extends StatefulWidget {

  const HomePage({ Key? key }) ;


  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  late SharedPreferences logindata;

  late String username="";
  String entered='';
  bool error = false;
  var data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  //load the username and password details from sharedpreferences
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
      entered= logindata.getString("entered")!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.appbackgroundcolor,
      body:  SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                final bool connected =
                    connectivity != ConnectivityResult.none;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      height: 20.0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        color:
                        connected ? const Color(0x9000EE44) : const Color(
                            0xCFEE0800),
                        child: connected
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              "ONLINE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              "OFFLINE",
                              style: TextStyle(color: Colors.white),

                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            SizedBox(
                              width: 5.0,
                              height: 5.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor:
                                AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(50,0,50,0),
                  width: double.infinity*MediaQuery.of(context).devicePixelRatio,
                  height: double.infinity*MediaQuery.of(context).devicePixelRatio,
                  decoration: const BoxDecoration(
                    color: constants.appbackgroundcolor,
                  ),
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(),
                              child: Align(
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(35, 300, 35, 0),
                                  child: SizedBox(
                                    height: 70,
                                    width: 300,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(borderRadius:
                                          BorderRadius.circular(15)),
                                          padding: const EdgeInsets.all(10),
                                          primary: constants.Tertiary,
                                          elevation:12  // Background color
                                      ),
                                      label:const Text('New entry',style: TextStyle(fontSize:20)) ,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => NewEntry()
                                            ));
                                      },

                                      icon: const Icon(
                                        Icons.open_in_new,
                                        size: 22,

                                      ),
                                    ),

                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Container(

                              width: double.infinity,

                              decoration: const BoxDecoration(),

                            ),
                          ),
                          const SizedBox(height: 25,),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => History()
                                    ));
                              }
                              catch(e){
                                print(e);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xb733332F)),
                            child: const Text('History'),
                          ),
                          const SizedBox(height: 20,),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }



}



