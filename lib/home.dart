import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIng = false;
  late GoogleSignInAccount _userObjg;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoggedInf = false;
  bool _isLoggedIn = false;
  Map _userObjf = {};
  @override
  Widget build(BuildContext context) {
    // MaterialColor color;
    return Scaffold(
      appBar: AppBar(title: Text("SMINntegration")),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            children: [
              Container(
                  child: _isLoggedIn
                      ? Center()
                      : Column(
                          children: [
                            Image.asset("assets/images/logo_small.png"),
                            Text("The Sparks Foundation",
                                style: const TextStyle(fontSize: 30)),
                            Text("...inspiring, innovating, integrating",
                                style: const TextStyle(fontSize: 20))
                          ],
                        )),
              Container(
                child: _isLoggedIng
                    ? Center(
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(0, 40, 0, 5),
                                child: Image.network(
                                    _userObjg.photoUrl.toString())),
                            Text(_userObjg.displayName.toString(),
                                style: const TextStyle(fontSize: 25)),
                            Text(_userObjg.email,
                                style: const TextStyle(fontSize: 15)),
                            TextButton(
                                onPressed: () {
                                  _googleSignIn.signOut().then((value) {
                                    setState(() {
                                      _isLoggedIng = false;
                                      _isLoggedIn = false;
                                    });
                                  }).catchError((e) {});
                                },
                                child: Container(
                                  child: Text(" Logout ",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          backgroundColor: Colors.blueGrey)),
                                ))
                          ],
                        ),
                      )
                    : Center(
                        child: _isLoggedInf
                            ? Column()
                            : Column(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(100, 10, 100, 0),
                                    child: ElevatedButton(
                                      child: Text("Login with Google"),
                                      onPressed: () {
                                        _googleSignIn.signIn().then((userData) {
                                          setState(() {
                                            _isLoggedIng = true;
                                            _isLoggedIn = true;
                                            _userObjg = userData!;
                                          });
                                        }).catchError((e) {
                                          print(e);
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Or",
                                      style: TextStyle(fontFamily: "monospace"),
                                    ),
                                  )
                                ],
                              ),
                      ),
              ),
              Container(
                child: _isLoggedInf
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 40, 0, 5),
                            child: Image.network(
                              _userObjf["picture"]["data"]["url"],
                            ),
                          ),
                          Text(_userObjf["name"],
                              style: const TextStyle(fontSize: 25)),
                          Text(_userObjf["email"],
                              style: const TextStyle(fontSize: 15)),
                          TextButton(
                              onPressed: () {
                                FacebookAuth.instance.logOut().then((value) {
                                  setState(() {
                                    _isLoggedInf = false;
                                    _isLoggedIn = false;
                                    _userObjf = {};
                                  });
                                });
                              },
                              child: Text(" Logout ",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      backgroundColor: Colors.blueGrey)))
                        ],
                      )
                    : Center(
                        child: _isLoggedIng
                            ? Column()
                            : Column(
                                children: [
                                  Container(
                                    child: ElevatedButton(
                                      child: Text("Login with Facebook"),
                                      onPressed: () async {
                                        FacebookAuth.instance.login(
                                            permissions: [
                                              "public_profile",
                                              "email"
                                            ]).then((value) {
                                          FacebookAuth.instance
                                              .getUserData()
                                              .then((userData) {
                                            setState(() {
                                              _isLoggedInf = true;
                                              _isLoggedIn = true;
                                              _userObjf = userData;
                                            });
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
