import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onWaiting;
  final Function onSignedIn;
  final Function(FirebaseUser) onGoogleSignedIn;
  final VoidCallback signOut;

  LoginScreen({this.onSignedIn, this.onGoogleSignedIn, this.onWaiting, this.signOut});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

String _email, _password;

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: ListView(children: <Widget>[
          Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: ImageWidget(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Provide an email';
                        }
                      },
                      onSaved: (input) => _email = input,
                      decoration: InputDecoration(labelText: 'Email')),
                  SizedBox(height: 20.0),
                  PasswordField(),
                  SizedBox(height: 30.0),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: Row(children: <Widget>[
                          IconButton(
                              icon: Image.asset('assets/google.png'),
                              onPressed: () async {
                                GoogleSignInAccount gSAccount =
                                    await GoogleSignIn().signIn();
                                GoogleSignInAuthentication gSAuthentication =
                                    await gSAccount.authentication;
                                try {
                                  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                                  FirebaseUser user = await firebaseAuth.signInWithGoogle(idToken: gSAuthentication.idToken, accessToken: gSAuthentication.accessToken);
                                  widget.onGoogleSignedIn(user);
                                } on Exception catch (e) {
                                  print("Exception: $e");
                                }
                              }),
                          IconButton(
                              icon: Image.asset('assets/facebook.png'),
                              onPressed: () {})
                        ])),
                    Expanded(
                      flex: 5,
                      child: RaisedButton(
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            _formKey.currentState.save();
                            try {
                              FirebaseUser user = await _auth();
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              pref.setString("Login", _email);
                              pref.setString("Password", _password);
                              widget.onSignedIn();
                            } on Exception catch (e) {
                              print('firebase exaption: ${e}');
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _wrongPassAlertDialog();
                                  });
                            }
                          },
                          color: Colors.blue),
                    ),
                  ]),
            ),
            FlatButton(
                onPressed: null,
                child: Text('Forgot password',
                    style: TextStyle(color: Colors.blue))),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Still do not have an account '),
                    FlatButton(
                        onPressed: null,
                        child: Text('registration',
                            style: TextStyle(color: Colors.blue)))
                  ]),
            )
          ]),
        ])));
  }

  Future<FirebaseUser> _auth() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(
        email: _email, password: _password);
    return user;
  }

  Widget _wrongPassAlertDialog() {
    return AlertDialog(
        content: Text("Wrong login or passord"),
        actions: <Widget>[
          FlatButton(
              child: Text("Ok"),
              onPressed: () {
                widget.signOut();
                Navigator.pop(context);
              })
        ]);
  }
}

class PasswordField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PasswordFieldState();
}

class PasswordFieldState extends State {
  bool _obscurePassword = true; // Initially password is obscure

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (input) {
        if (input.length < 6) {
          return 'Longer password please';
        }
      },
      onSaved: (input) => _password = input,
      decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(
            onPressed: _toggle,
            icon: Icon(Icons.remove_red_eye),
            color: _obscurePassword ? Colors.grey : Colors.blue,
          )),
      obscureText: _obscurePassword,
    );
  }

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }
}

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = AssetImage('assets/butterfly.png');
    var image = Image(image: assetsImage, width: 200.0, height: 200.0);
    return Container(
      child: image,
    );
  }
}
