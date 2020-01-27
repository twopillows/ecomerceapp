import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/Product/model/product.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/User/ui/widgets/button_bar.dart';
import 'package:ecomerceapp/Product/ui/screens/product_details.dart';
import 'package:ecomerceapp/widgets/gradient_back.dart';
import 'package:ecomerceapp/widgets/text_input.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder<DocumentSnapshot>(
        stream: userBloc.courseDocStream,
        //stream: userBloc.getcurrentUser(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // get course document datos del usuario
            var courseDocument = snapshot.data.data;
            //print("entro al snapshot");
            // get sections from the document aqui coge exactament l array de favoritos
            var sections = courseDocument['myFavoriteProducts'];

            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).padding.top, 0, 0),
                      child: GradientBack(
                        title: "🛒FAVORITES🛒",
                        height: 100,
                      ),
                    ),

                    ///Here is the method to delete the favorite with the slidable
                    Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                          itemExtent: 300,
                          itemCount: sections != null ? sections.length : 0,
                          itemBuilder: (_, int index) {
                            //return _buildProductCard(sections, index);
                            return Slidable(
                              actionPane: SlidableScrollActionPane(),
                              actionExtentRatio: 0.25,
                              child: _buildProductCard(sections, index),
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () {
                                    userBloc
                                        .eliminarDeFavoritos(sections[index]);
                                    print("delete from favorites");
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Widget _buildProductCard(var sections, int index) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        //aqui va product details cdo se da clicks ProductDetails()
        MaterialPageRoute(
            builder: (context) => ProductDetails(
                  //aqui estoy diciendo de q producto son los datos
                  //para generar la productdetails page corespondint
                  product_detail_name: sections[index]['name'],
                  //product_detail_price: document['price'].toString(),
                  product_detail_price: sections[index]['price'],
                  product_detail_old_price:
                      sections[index]['old_price'].toString(),
                  //product_detail_picture: product_list[index]["picture"],
                  product_detail_picture: sections[index]['picture'],
                  numero: sections[index]['numero'],
                  //"numero": "12",
                  //images: producto_Actual.images,
                )),
      ),
      child: Container(
        height: 300.0,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // este container es pa la foto
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 250.0,
                      width: 150.0,
                      //aqui se carga la imagen pero no desde la bd solamente estoy cargadn oel path desde firebase
                      child: Image.asset(
                        sections[index]['picture'],
                        //document['picture'],
                      ),
                    ),

                    //este padding es pa separar la foto del texto
                    Padding(padding: EdgeInsets.all(8)),
                    //aqui voy a hacer una columna con la descricion y el precio
                    Container(
                      height: 200.0,
                      width: 180.0,
                      child: Column(
                        children: <Widget>[
                          Text(
                            //producto_Actual.name,
                            sections[index]['name'],
                            //document['name'],
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "by SwapTrendy",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),

                          //REVIEWS
                          Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(18)),
                              //reviews stars
                              Text(
                                "★★★★★",
                                style: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 18.0),
                              ),
                              //reviews quantity
                              Text("(10)")
                            ],
                          ),

                          Spacer(),
                          Row(
                            children: <Widget>[
                              //precio
                              Padding(padding: EdgeInsets.all(13)),
                              Text(
                                "\$" + sections[index]['price'].toString(),
                                //"\$" + document['price'].toString(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text("   "),
                              //old price
                              Text(
                                sections[index]['old_price'].toString(),
                                //document['old_price'].toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),

                          Padding(padding: EdgeInsets.all(8)),
                          //BOTON ADD TO CART
                          /*RaisedButton(

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () => Navigator.of(context).push(
                                  //aqui va product details cdo se da clicks ProductDetails()
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetails())),
                              child: Text("ADD TO CART"),
                            ),*/
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
