import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/User/model/user.dart';

class RegistrerScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegistrerScreen> {
  UserBloc userBloc;
  final _formKey = GlobalKey<FormState>();
  String _username, _email, _password;
  bool _obscureText = true;

  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
                    _showUsername(),
                    _showEmail(),
                    _showPassword(),
                    _showFormSection(),
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
      "Register",
      style: Theme.of(context).textTheme.headline,
    );
  }

  Widget _showUsername() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (value) => _username = value,
        validator: (value) => value.length < 6 ? 'Ivalid Username' : null,
        decoration: InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
            hintText: 'Enter username, min length 6',
            icon: Icon(
              Icons.account_circle,
              color: Colors.blue[900],
            )),
      ),
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
        //validator: (value) => value.length < 4 ? 'Password too short' : null,
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
            onPressed: () => userBloc
                .signUpWithEmailPassword(_email, _password)
                .then((FirebaseUser user) {
              userBloc.updateData(User(
                uid: user.uid,
                //name: user.displayName,
                email: user.email,
                //photoURL: user.photoUrl,
                //myOrders: null,
                //myFavoriteProducts: null,
                //myCart: null
              ));
            }),
            //onPressed: () => _validateForm(),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          FlatButton(
            child: Text('Already have an account? Log In'),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
    );
  }

  void _validateForm() {
    final _form = _formKey.currentState;

    if (_form.validate()) {
      _form.save();
      print('user is:$_username, AND password: $_password');
    }
  }
}
