import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/User/ui/screens/orders.dart';
import 'package:ecomerceapp/User/ui/screens/payment_screen.dart';
import 'package:ecomerceapp/User/ui/screens/login_screen.dart';
import 'package:ecomerceapp/widgets/general_button.dart';
import 'package:ecomerceapp/widgets/gradient_back.dart';

class Account extends StatefulWidget {
  final String uid;

  Account({this.uid});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
      stream: userBloc.authStatusFirebase,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              color: Colors.white,
            );
          case ConnectionState.none:
            return Container(
              color: Colors.white,
            );
          case ConnectionState.done:
            return accountUI(snapshot, context);
          case ConnectionState.active:
            return accountUI(snapshot, context);
        }
      },
    );
  }

  Widget accountUI(AsyncSnapshot snapshot, BuildContext context) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("no hay datos por lo q no esta logeado");
      return SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).padding.top, 0, 0),
              child: profileSessionNotLoggedIn(),
            ),
            Expanded(child: listaElementos(context))
          ],
        ),
      );
    } else {
      print("entroooooo con datos de inicio");
      return SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).padding.top, 0, 0),
              child: profileSessionLoggedIn(snapshot, context),
            ),
            Expanded(
              child: listaElementos(context),
            ),
          ],
        ),
      );
    }
  }

  Widget profileSessionNotLoggedIn() {
    return Container(
        child: Center(
      child: Text("Not Logged In. Please Log In"),
    ));
  }

  Widget profileSessionLoggedIn(AsyncSnapshot snapshot, BuildContext context) {
    return Stack(
      children: <Widget>[
        GradientBack(
          height: 185,
          title: "",
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).padding.top + 25, 0, 0),
          child: StreamBuilder<DocumentSnapshot>(
            stream: userBloc.currentUserStream(widget.uid),
            builder: (context, AsyncSnapshot snapshot) {
              var userInfo = snapshot.data.data;
              var name = userInfo['name'];
              var email = userInfo['email'];
              var url = userInfo['photoURL'];
              //print('ACCOUNT STREAM este' + url.toString());

              return UserAccountsDrawerHeader(
                accountName: Text(
                  name.toString(),
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: Text(
                  email.toString(),
                  style: TextStyle(color: Colors.black),
                ),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,

                    ///Here comes the user photo
                    backgroundImage: (url == null)
                        ? AssetImage('images/images/products_LA/1.jpeg')
                        : CachedNetworkImageProvider(url.toString()),
                    //NetworkImage(snapshot.data.photoUrl),
                  ),
                ),
                decoration: BoxDecoration(color: Colors.transparent),
              );
            },
          ),
        )
      ],
    );
  }

  Widget listaElementos(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 0, 0),
          child: Text("My info"),
        ),
        Divider(color: Colors.black),
        InkWell(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Orders())),
          child: ListTile(
            title: Text('My Orders'),
            leading: Icon(Icons.local_shipping, color: Color(0xFF108CED)),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PaymentScreen()));
          },
          child: ListTile(
            title: Text('Payment Methods'),
            leading: Icon(Icons.credit_card, color: Color(0xFF108CED)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 0, 0),
          child: Text("My Settings"),
        ),
        Divider(color: Colors.black),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Email & Password'),
            leading: Icon(Icons.email, color: Color(0xFF108CED)),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Notifications'),
            leading: Icon(Icons.notifications, color: Color(0xFF108CED)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 0, 0),
          child: Text("Help Center"),
        ),
        Divider(color: Colors.black),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Share the App'),
            leading: Icon(Icons.share, color: Color(0xFF108CED)),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Rate Us'),
            leading: Icon(Icons.rate_review, color: Color(0xFF108CED)),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Terms & Policies'),
            leading: Icon(Icons.insert_drive_file, color: Color(0xFF108CED)),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Privacy Policy'),
            leading: Icon(Icons.security, color: Color(0xFF108CED)),
          ),
        ),
        Divider(color: Colors.black),
        Container(
          height: 100,
          width: 150,
          child: GeneralButton("images/iconos/google.jpg", 50, 300, "Sign Out",
              () {
            userBloc.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
            /*showCupertinoDialog(
              context: context,
              builder: (_) => CupertinoAlertDialog(
                title: Text("Sign Out"),
                actions: [
                  CupertinoDialogAction(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pop('/account');
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text("Yes"),
                    onPressed: () => {
                      userBloc.signOut(),
                      //Navigator.of(context, rootNavigator: true).pop('/login'),
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen())),
                    },
                    //isDestructiveAction: true,
                  ),
                ],
              ),
            );*/
          }),
        )
      ],
    );
  }
}
