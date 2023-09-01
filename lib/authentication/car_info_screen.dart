import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global/global.dart';
import '../splashScreen/splash_screen.dart';

class CarInfoScreen extends StatefulWidget
{

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}



class _CarInfoScreenState extends State<CarInfoScreen>
{
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> genderTypesList = ["male", "female"];
  String? selectedGenderType;


  saveCarInfo()
  {
    Map driverCarInfoMap =
    {
      "walker_talk": carColorTextEditingController.text.trim(),
      "walker_pet": carNumberTextEditingController.text.trim(),
      "walker_native": carModelTextEditingController.text.trim(),
      "type": selectedGenderType,
    };

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("walker_details").set(driverCarInfoMap);
    Fluttertoast.showToast(msg: "Walker Details has been saved, Congratulations." , backgroundColor: Colors.green);
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() =>  FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(logoImage),

                const SizedBox(height: 10,),

                // Talktive
                TextField(
                  controller: carColorTextEditingController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration:  InputDecoration(
                    labelText: "Are You Talktive ?",
                    hintText: "Yes or NO",
                    border: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue , width: 2),
                      borderRadius:  BorderRadius.circular(25),
                    ),
                    prefixIcon: Icon(Icons.access_time_sharp , color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                TextField(
                  controller: carNumberTextEditingController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration:  InputDecoration(
                    labelText: "Are You Pet Lover ?",
                    hintText: "Yes or NO",
                    border: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue , width: 2),
                      borderRadius:  BorderRadius.circular(25),
                    ),
                    prefixIcon: Icon(Icons.pets , color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                TextField(
                  controller: carModelTextEditingController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration:  InputDecoration(
                    labelText: "Are You Native ?",
                    hintText: "Yes or NO",
                    border: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue , width: 2),
                      borderRadius:  BorderRadius.circular(25),
                    ),
                    prefixIcon: Icon(Icons.language , color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),


                const SizedBox(height: 17,),

                DropdownButton(
                  iconSize: 60,
                  dropdownColor: Colors.black,
                  hint: const Text(
                    "Choose Your Gender",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  value: selectedGenderType,
                  onChanged: (newValue)
                  {
                    setState(() {
                      selectedGenderType = newValue.toString();
                    });
                  },
                  items: genderTypesList.map((car){
                    return DropdownMenuItem(
                      child: Text( car,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      value: car,
                    );
                  }).toList(),
                ),

                const SizedBox(height: 40,),

                GestureDetector(
                  onTap: () {
                    if(
                    carColorTextEditingController.text.isNotEmpty
                        && carNumberTextEditingController.text.isNotEmpty
                        && carModelTextEditingController.text.isNotEmpty && selectedGenderType != null)
                    {
                      saveCarInfo();
                    }
                  },
                  child: Container(
                    child: Center(child: Text("Save" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
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
}
