import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Color(0xff141921),
          padding: EdgeInsets.all(21),
          // backgroundColor: Colors.white,
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Colors.black87,
              width: 21,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text,
              style: TextStyle(
                fontFamily: "Bitter",
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(25, 25, 25, 0.8),
                fontSize: 16,
              ),
            )
            ),
            Icon(Icons.arrow_forward_ios),

          ],
        ),
      ),
    );
  }
}