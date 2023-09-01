import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:walkers_app/authentication/login_screen.dart';
import '../global/global.dart';
import '../widgets/info_design_ui.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //name
            Text(
              "${onlineDriverData.name}",
              style: const TextStyle(
                fontSize: 50.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                titleStarsRating + " Walker",
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
                height: 2,
                thickness: 2,
              ),
            ),

            const SizedBox(
              height: 10.0,
            ),

            //phone
            InfoDesignUIWidget(
              textInfo: "${onlineDriverData.phone}",
              iconData: Icons.phone_iphone,
            ),

            //email
            InfoDesignUIWidget(
              textInfo: onlineDriverData.email,
              iconData: Icons.email,
            ),

            Column(
              children: [
                InfoDesignUIWidget(
                  textInfo:
                      "Talktive :"+"${onlineDriverData.walker_talk}    ",
                  iconData: Icons.phone_in_talk,
                ),
                InfoDesignUIWidget(
                  textInfo:
                      "Pet Lover :${onlineDriverData.walker_pet}",
                  iconData: Icons.pets,
                ),
                InfoDesignUIWidget(
                  textInfo:
                      "Native :  ${onlineDriverData.walker_native}",
                  iconData: Icons.language,
                ),
              ],
            ),

            GestureDetector(
              onTap: ()
              {
                fAuth.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 25),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                ),
                child:  const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.black , fontSize: 18 , fontWeight: FontWeight.bold),
                ) ,
              ),
            ),

            // ElevatedButton(
            //
            //   onPressed: () {
            //     fAuth.signOut();
            //     SystemNavigator.pop();
            //   },
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.white,
            //
            //   ),
            //   child:
            // ),
          ],
        ),
      ),
    );
  }
}
