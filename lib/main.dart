import 'dart:io';

import 'package:flutter/material.dart';
import 'package:github_users_app/models/user.dart';
import 'package:github_users_app/models/userurllist.dart';
import 'package:github_users_app/ui/useritem.dart';
import 'package:github_users_app/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Github Users',
      theme: ThemeData(
        primarySwatch: createColor(Color(0xff2F3035)),
        fontFamily: GoogleFonts.nunito().fontFamily,
        textTheme: TextTheme(
          headline5: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.w800,
          ),
          headline6: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      home: MyHomePage(title: 'Github Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(title);
}

class _MyHomePageState extends State<MyHomePage> {
  final String title;
  _MyHomePageState(this.title);
  List<User> userList = List();

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left:5.0),
            child: Text(
              "$title",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          elevation: 0,
        ),
        body: Container(
          child: userList.length != 0
              ? ListView.separated(
                  itemBuilder: (context, pos) {
                    //if ((pos + 1) != userList.length) getNameAndLocation(pos);
                    return InkWell(
                      child: Container(
                        padding:
                            (pos + 1) == 1 ? EdgeInsets.only(top: 19.0) : null,
                        child: UserItem(userList[pos]),
                      ),
                      onTap: () {},
                    );
                  },
                  separatorBuilder: (context, pos) {
                    return Divider(
                      color: divider,
                      thickness: 1.5,
                      height: 1.0,
                    );
                  },
                  itemCount: userList.length,
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }

  getUsers() async {
    final response = await http.get(
      'https://api.github.com/users?language=flutter',
      headers: {
        HttpHeaders.authorizationHeader:
            'token [INSERT OAUTH TOKEN HERE]'
      },
    );

    if (response.statusCode == 200) {
      var urls = UserUrlList.fromJson(json.decode(response.body));

      for (var url in urls.userUrls) {
        final userRes = await http.get(url, headers: {
          HttpHeaders.authorizationHeader:
              'token [INSERT OAUTH TOKEN HERE]'
        });
        if (userRes.statusCode == 200) {
          userList.add(User.fromJson(json.decode(userRes.body)));
          userList.sort((a, b) {
            return int.parse(a.id).compareTo(int.parse(b.id));
          });
          setState(() {
            userList = userList;
          });
        } else {
          throw Exception('An error occurred, ${userRes.reasonPhrase}');
        }
      }
    } else {
      throw Exception('An error occurred, ${response.reasonPhrase}');
    }
  }

  /* getNameAndLocation(int pos) async {
    var response = await http.get(
      userList[pos].url,
      headers: {
        HttpHeaders.authorizationHeader:
            'token f52b085594b2893d7601e533e98a606f9a7bce14'
      },
    );

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      userList[pos].name = jsonObj['name'] == null
          ? jsonObj['login'].toString()
          : jsonObj['name'].toString();
      userList[pos].location = jsonObj['location'] == null
          ? 'Lagos'
          : jsonObj['location'].toString();
      debugPrint(
          'Location ==> ${userList[pos].location} \n Name ==> ${userList[pos].name}');
      setState(() {
        userList = userList;
      });
    } else {
      throw Exception(response.reasonPhrase);
    }
  } */
}
