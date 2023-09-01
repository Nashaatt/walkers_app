import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:walkers_app/authentication/signup_screen.dart';
import 'package:walkers_app/widgets/info_design_ui.dart';
import 'package:walkers_app/widgets/text_field_design_ui.dart';
import '../global/global.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_dialog.dart';


class LoginScreen extends StatefulWidget
{

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen>
{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  validateForm()
  {
    if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not Valid." , backgroundColor: Colors.red);
    }
    else if(passwordTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password is required." , backgroundColor: Colors.red);
    }
    else
    {
      loginDriverNow();
    }
  }

  loginDriverNow() async
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
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).once().then((driverKey)
      {
        final snap = driverKey.snapshot;
        if(snap.value != null)
        {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful." , backgroundColor: Colors.green);
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
        else
        {
          Fluttertoast.showToast(msg: "No record exist with this email." , backgroundColor: Colors.red);
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
      });
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 10,),

                Image.asset(logoImage),

                const Text(
                  "Login as a Walker",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30,),

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

                SizedBox(height: 20,),

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
                
                SizedBox(height: 100,),

                GestureDetector(
                  onTap: () {
                    validateForm();
                  },
                  child: Container(
                    child: Center(child: Text("Login" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: ()
                //   {
                //     validateForm();
                //   },
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.white,
                //   ),
                //   child: const Text(
                //     "Login",
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 18,
                //     ),
                //   ),
                // ),
                SizedBox(height: 5,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Do not have Account?' , style: TextStyle(color: Colors.grey , fontSize: 15),),
                    TextButton(
                      child: Text(
                        "Signup Here",
                        style: TextStyle(color: Colors.blue , fontSize: 12),
                      ),
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
