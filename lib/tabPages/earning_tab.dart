import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../infoHandler/app_info.dart';
import '../mainScreens/trips_history_screen.dart';

class EarningsTabPage extends StatefulWidget {
  const EarningsTabPage({Key? key}) : super(key: key);

  @override
  _EarningsTabPageState createState() => _EarningsTabPageState();
}

class _EarningsTabPageState extends State<EarningsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //earnings
        Container(
          color: Colors.black,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Column(
              children: [
                const Text(
                  "your Earnings:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "\$ " +
                      Provider.of<AppInfo>(context, listen: false)
                          .driverTotalEarnings,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        //total number of trips
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => TripsHistoryScreen()));
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(
                      25,
                    ))),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Image.asset(
                  "images/donation.png",
                  width: 50,
                ),
                const SizedBox(
                  width: 40,
                ),
                const Text(
                  "Trips Completed",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      Provider.of<AppInfo>(context, listen: false)
                          .allTripsHistoryInformationList
                          .length
                          .toString(),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),


      ],
    );
  }
}
