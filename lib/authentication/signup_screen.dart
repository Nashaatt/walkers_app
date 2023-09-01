import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global/global.dart';
import '../widgets/progress_dialog.dart';
import 'car_info_screen.dart';
import 'login_screen.dart';


class SignUpScreen extends StatefulWidget
{
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen>
{
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  validateForm()
  {
    if(nameTextEditingController.text.length < 3)
    {
      Fluttertoast.showToast(msg: "name must be atLeast 3 Characters." , backgroundColor: Colors.red);
    }
    else if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not Valid." , backgroundColor: Colors.red);
    }
    else if(phoneTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Phone Number is required." , backgroundColor: Colors.red);
    }
    else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "Password must be atLeast 6 Characters." , backgroundColor: Colors.red);
    }
    else
    {
      saveDriverInfoNow();
    }
  }

  saveDriverInfoNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait...",);
        }
    );

    final User? firebaseUser = (
      await fAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      ).catchError((msg){
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error: " + msg.toString());
      })
    ).user;

    if(firebaseUser != null)
    {
      Map driverMap =
      {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              Image.asset(logoImage , width: 300,),

              const Text(
                "Register as a Walker",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20,),

              TextField(
                controller: nameTextEditingController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration:  InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius:  BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius:  BorderRadius.circular(25),
                  ),
                  prefixIcon: Icon(Icons.person , color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 12,),

              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration:  InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius:  BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius:  BorderRadius.circular(25),
                  ),
                  prefixIcon: Icon(Icons.email , color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 12,),

              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration:  InputDecoration(
                  hintText: "Phone",
                  border: OutlineInputBorder(
                    borderRadius:  BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius:  BorderRadius.circular(25),
                  ),
                  prefixIcon: Icon(Icons.phone_in_talk , color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 12,),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration:  InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius:  BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius:  BorderRadius.circular(25),
                  ),
                  prefixIcon: Icon(Icons.password , color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 40,),

              GestureDetector(
                onTap: () {
                  validateForm();
                },
                child: Container(
                  child: Center(child: Text("Sign up" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('Already have an Account?' , style: TextStyle(color: Colors.grey , fontSize: 14),),
                TextButton(
                child: Text(
                "Login Here",
                style: TextStyle(color: Colors.blue , fontSize: 12),
              ),
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
              },
            ),
          ],
        ),
            ],
          ),
        ),
      ),
    );
  }
}
