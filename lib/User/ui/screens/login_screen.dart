import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomerceapp/User/repository/cloud_firestore_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/User/model/user.dart';
import 'package:ecomerceapp/tienda_principal_cupertino.dart';
import 'package:ecomerceapp/widgets/general_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email, _password;
  bool _obscureText = true;
  UserBloc userBloc;

  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _showTitle(),
                    _showEmail(),
                    _showPassword(),
                    _showFormSection(),
                    stream(),
                    //_signinGoogle(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showTitle() {
    return Text(
      "Login with Email & Password",
      style: Theme.of(context).textTheme.headline,
    );
  }

  Widget _showEmail() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (value) => _email = value,
        validator: (value) => !value.contains('@') ? 'Invalid Email' : null,
        decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            hintText: 'Enter a valid email',
            icon: Icon(
              Icons.mail,
              color: Colors.blue[900],
            )),
      ),
    );
  }

  Widget _showPassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (value) => _password = value,
        validator: (value) => value.length < 4 ? 'Password too short' : null,
        obscureText: _obscureText,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            ),
            labelText: 'Password',
            border: OutlineInputBorder(),
            hintText: 'Enter password',
            icon: Icon(
              Icons.lock_outline,
              color: Colors.blue[900],
            )),
      ),
    );
  }

  Widget _showFormSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text(
              'Submit',
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.black),
            ),
            onPressed: () {
              //print(_email);
              _validateForm();
              //userBloc.signInEmail(_email, _password, context);
              //print(_email);
              //print(_password);
            },
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          FlatButton(
            child: Text('New User? Register'),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/register'),
          ),
        ],
      ),
    );
  }

  void _validateForm() async {
    final _form = _formKey.currentState;

    if (_form.validate()) {
      _form.save();
      FirebaseUser user =
          await userBloc.signInEmail(_email, _password, context);
      userBloc.updateUserData(
          User(
            uid: user.uid,
            //name: user.displayName,
            email: user.email,
            photoURL: user.photoUrl,
            myOrders: null,
            //myFavoriteProducts: null,
            //myCart: null
          ),
          true);

      ///sign in
      _scaffoldKey.currentState.showSnackBar(_showSnackBar());
    }
  }

  void _changeObscureState() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _showSnackBar() {
    return SnackBar(content: Text("Logged in"));
  }

  Widget stream() {
    return StreamBuilder(
      stream: userBloc.authStatusFirebase,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return _signinGoogle();
        } else {
          //return signInGoogleUI();
          return TiendaPrincipalCupertino();
        }
      },
    );
  }

  Widget _signinGoogle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GeneralButton(
              "images/iconos/google.jpg", 50, 300, "Sign In With Google", () {
            userBloc.signOut();
            userBloc.signInGoogle().then((FirebaseUser user) {
              var userDocRef = userBloc.userDocRef(user.uid);
              userDocRef.get().then((userInfo) {
                if (userInfo.exists) {
                  print('true');
                  userBloc.updateUserData(
                      User(
                        uid: user.uid,
                        name: user.displayName,
                        email: user.email,
                        photoURL: user.photoUrl,
                        myOrders: null,
                        //myFavoriteProducts: null,
                        //myCart: null
                      ),
                      true);
                } else {
                  print('false');
                  userBloc.updateUserData(
                      User(
                        uid: user.uid,
                        name: user.displayName,
                        email: user.email,
                        photoURL: user.photoUrl,
                        myOrders: null,
                        //myFavoriteProducts: null,
                        //myCart: null
                      ),
                      false);
                }
              });

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TiendaPrincipalCupertino(
                            uid: user.uid,
                          )));
            });
          }),
        ],
      ),
    );
  }
}
