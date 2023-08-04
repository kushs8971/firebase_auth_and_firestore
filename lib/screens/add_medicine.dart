import 'package:adhicine/constants/app_styles.dart';
import 'package:adhicine/constants/utils.dart';
import 'package:adhicine/models/type_model.dart';
import 'package:adhicine/services/firestore_service.dart';
import 'package:adhicine/widgets/custom_search_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {

  TextEditingController _searchController = TextEditingController();
  double _quantity = 1;
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<Color> colors = [
    Color(0xffff90b6),
    Color(0xffb978ff),
    Color(0xffff7878),
    Color(0xff93ffa9),
    Color(0xffffd478),
    Color(0xff78cdff),
    Color(0xffffd478)
  ];

  int selectedCompartment = 1;
  late int selectedColor;
  late TypeModel selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = types[0];
    selectedColor = colors[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Add Medicines',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchTextField(controller: _searchController),
                  SizedBox(
                    height: 16,
                  ),
                  buildCompartmentInputWidget(),
                  SizedBox(
                    height: 16,
                  ),
                  buildColourInputWidget(),
                  SizedBox(
                    height: 16,
                  ),
                  buildTypeInputWidget(),
                  SizedBox(
                    height: 16,
                  ),
                  buildQuantityWidget(),
                  SizedBox(
                    height: 16,
                  ),
                  buildTotalCountWidget(),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                          onPressed: () async {
                            if(!inputsValid()){
                              return;
                            }
                            await saveMedicineToFirestore();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Medicine Added Successfully'
                                ),
                              behavior: SnackBarBehavior.floating, // Use floating behavior
                              margin: EdgeInsets.fromLTRB(20,0,20,50),
                            ));
                            clearValues();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: AppStyles.purpleShade
                          ),
                          child: Text('Add',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                          )
                      )
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  bool inputsValid() {
    if(_searchController.text.trim() == ''){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please write a name!'
        ),
        behavior: SnackBarBehavior.floating, // Use floating behavior
        margin: EdgeInsets.fromLTRB(20,0,20,50),
      ));
      return false;
    }
    return true;
  }

  Column buildCompartmentInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Compartment',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 64,
          padding: EdgeInsets.symmetric(vertical: 2),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedCompartment = numbers[index];
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedCompartment == numbers[index] ? AppStyles.purpleShadeLight : Colors.white,
                          border: Border.all(
                            color: selectedCompartment == numbers[index] ? AppStyles.purpleShade : AppStyles.greyShade,
                            width: 1,
                          )),
                      child: Center(
                        child: Text(
                          numbers[index].toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Column buildColourInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Colour',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 2),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedColor = colors[index].value;
                      });
                    },
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                          color: colors[index],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedColor == colors[index].value ? AppStyles.purpleShade : Colors.white,
                            width: 1,
                          )),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Column buildTypeInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Container(
          height: 120,
          padding: EdgeInsets.symmetric(vertical: 4),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: types.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedType = types[index];
                      });
                    },
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: selectedType == types[index] ?
                            Border.all(
                              width: 2,
                              color: AppStyles.purpleShade
                            ) : null,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.05),
                                  blurRadius: 5,
                                  spreadRadius: 5
                              )
                            ]),
                        child: Center(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/types/${types[index].image}.png',
                              height: 40,
                              color: Color(0xffff90b6),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              types[index].name,
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        )),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Column buildQuantityWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 54,
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: AppStyles.greyShade
                      ),
                    ),
                    child: Center(child: Text('Take 1/2 Pill')),
                  ),
              ),
              SizedBox(width: 14,),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppStyles.purpleShade,
                    width: 1
                  ),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(Icons.remove, size: 32, color: AppStyles.purpleShade,),
              ), SizedBox(width: 14,),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: AppStyles.purpleShade,
                    border: Border.all(
                        width: 1,
                      color: AppStyles.purpleShade,
                    ),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(Icons.add, color: Colors.white,size: 32,),
              )
            ],
          ),
        )
      ],
    );
  }

  Column buildTotalCountWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Count',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppStyles.greyShade,
                  width: 1
                ),
                borderRadius: BorderRadius.circular(6)
              ),
              child:  Text(
                _quantity.toInt().toString(),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Slider(
            activeColor: AppStyles.purpleShade,
            value: _quantity,
            onChanged: (value) {
              setState(() {
                _quantity = value.roundToDouble();
              });
            },
            min: 1,
            max: 100,
            divisions: 100,
          ),
        ),
      ],
    );
  }

  saveMedicineToFirestore() async {
    try {
      FirestoreService firestoreService = FirestoreService();
      await firestoreService.addMedicine(_searchController.text, selectedColor.toString(), selectedType.name, selectedType.image);
      print('Medicine added successfully');
    } catch (e) {
      print('Error adding medicine: $e');
    }
  }

  clearValues() {
    _searchController.clear();
    _quantity = 1;
    selectedCompartment = 1;
    selectedType = types[0];
    selectedColor = colors[0].value;
    setState(() {});
  }
}
