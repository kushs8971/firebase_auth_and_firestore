import 'package:adhicine/models/medicine_model.dart';
import 'package:adhicine/screens/login.dart';
import 'package:adhicine/services/authentication_service.dart';
import 'package:adhicine/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeInside extends StatefulWidget {
  const HomeInside({Key? key}) : super(key: key);

  @override
  State<HomeInside> createState() => _HomeInsideState();
}

class _HomeInsideState extends State<HomeInside> {

  List<MedicineModel> medicines = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMedicines();
  }

  getMedicines() async {
    try {
      FirestoreService firestoreService = FirestoreService();
      medicines = await firestoreService.getAllMedicines();
      print('Medicines fetched successfully');
      setState(() { });
    } catch (e) {
      print('Error fetching medicines: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Hi ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),
                    ),
                    Text("User!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),),
                  ],
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.plus_app_fill, color: Colors.purpleAccent,),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                        logoutUser();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff29a9f6),
                        ),
                        child: Center(
                            child: Icon(Icons.logout, color: Colors.white,)
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Text("Fri",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                  Icon(Icons.chevron_left, color: Colors.blueAccent,),
                  ElevatedButton(
                    onPressed: (){},
                    child: Text("Saturday, Sep 3",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // <-- Radius
                      ),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.black,
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.blueAccent,),
                  Text("Sun",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),

                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                  itemCount: medicines.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 110,
                      margin: EdgeInsets.only(top: 20, left: 1, right: 1),
                      padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          color: Color(0XFFf6f8ff),
                          boxShadow: [BoxShadow(
                            color: Color(0XE0E0E0FF),
                            blurRadius: 3.0,
                          ),]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(int.parse(medicines[index].color)),
                                ),
                                padding: EdgeInsets.all(14),
                                child: Image.asset('assets/types/${medicines[index].image}.png',color: Colors.white,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center, // Align contents of Column vertically centered
                                  children: [
                                    Text(medicines[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:[
                                            Text('Before Breakfast',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10
                                              ),
                                            ),
                                            Container(
                                                margin:EdgeInsets.only(left: 8),
                                                child: Text("Day 20",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )),
                                          ]),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center, // Align contents of Column vertically centered
                                  children: [
                                    Icon(Icons.notifications, color: Colors.greenAccent,),
                                    Text('Taken',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    ));
  }

  logoutUser() async {
    AuthenticationService authenticationService = AuthenticationService(context);
    await authenticationService.signOut();
    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new Login()));
  }
}
