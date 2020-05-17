import 'package:flutter/material.dart';
import 'package:github_users_app/models/user.dart';
import 'package:github_users_app/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strings/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class UserItem extends StatelessWidget {
  final User user;
  UserItem(this.user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(user.image),
              ),
            ),
          ),
          Container(
            width: 21.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  capitalizeNames(user.name),
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -.24,
                      height: 1,
                    ),
                  ),
                ),
                Text(
                  capitalizeNames(user.location),
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: 14.0,
                      color: textLight,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 35.0,
          ),
          OutlineButton(
            onPressed: launchUrl,
            child: Row(
              children: <Widget>[
                Text(
                  'View Profile',
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      color: textDark,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: 6.0,
                ),
                Image(
                  image: AssetImage('images/ic_github.png'),
                  width: 12.0,
                  height: 12.0,
                ),
              ],
            ),
            borderSide: BorderSide(color: textDark, width: 1.5),
            shape: StadiumBorder(),
          ),
        ],
      ),
    );
  }

  launchUrl() async {
    if (await canLaunch(user.htmlUrl)) {
      await launch(user.htmlUrl);
    } else {
      debugPrint('Failed to launch ==> ${user.htmlUrl}');
    }
  }

  String capitalizeNames(String name) {
    var names = name.split(" ");
    var mapped = names.map((n) => capitalize(n));
    return mapped.reduce((v, e) => v + ' ' + e);
  }
}
