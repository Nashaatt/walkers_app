import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import '../global/global.dart';
import '../infoHandler/app_info.dart';

class RatingsTabPage extends StatefulWidget {
  const RatingsTabPage({Key? key}) : super(key: key);

  @override
  State<RatingsTabPage> createState() => _RatingsTabPageState();
}

class _RatingsTabPageState extends State<RatingsTabPage> {
  double ratingsNumber = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getRatingsNumber();
  }

  getRatingsNumber() {
    setState(() {
      ratingsNumber = double.parse(
          Provider.of<AppInfo>(context, listen: false).driverAverageRatings);
    });

    setupRatingsTitle();
  }

  setupRatingsTitle() {
    if (ratingsNumber == 1) {
      setState(() {
        titleStarsRating = "Very Bad";
      });
    }
    if (ratingsNumber == 2) {
      setState(() {
        titleStarsRating = "Bad";
      });
    }
    if (ratingsNumber == 3) {
      setState(() {
        titleStarsRating = "Good";
      });
    }
    if (ratingsNumber == 4) {
      setState(() {
        titleStarsRating = "Very Good";
      });
    }
    if (ratingsNumber == 5) {
      setState(() {
        titleStarsRating = "Excellent";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 22.0,
              ),
              const Text(
                "Ratings :",
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 22.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: const Divider(
                  height: 1.0,
                  thickness: 1.0,
                ),
              ),
              const SizedBox(
                height: 22.0,
              ),
              RatingBar.builder(
                initialRating: ratingsNumber,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ignoreGestures: true,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(
                height: 12.0,
              ),

              Container(
                margin: EdgeInsets.only(top:20),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey)
                ),
                child: Text(
                  titleStarsRating,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
