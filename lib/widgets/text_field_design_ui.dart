import 'package:flutter/material.dart';


class InfoTextFieldUIWidget extends StatefulWidget
{
  @required String textInfo;
  @required IconData iconData;

  InfoTextFieldUIWidget(this.textInfo, this.iconData);

  @override
  State<InfoTextFieldUIWidget> createState() => _InfoTextFieldUIWidgetState();
}


class _InfoTextFieldUIWidgetState extends State<InfoTextFieldUIWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,

      ),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
      child: ListTile(
        leading: Icon(
          widget.iconData,
          color: Colors.black,
        ),
        title: Text(
          "${widget.textInfo}",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
