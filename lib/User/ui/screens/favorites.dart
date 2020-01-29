import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerceapp/Product/model/product.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/Product/ui/screens/product_details.dart';
import 'package:ecomerceapp/widgets/gradient_back.dart';
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
        stream: userBloc.currentUserStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var courseDocument = snapshot.data.data;
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
                                    print("deleted from favorites");
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
    Product product = Product(
      name: sections[index]['name'],
      price: sections[index]['price'],
      old_price: sections[index]['old_price'],
      picture: sections[index]['picture'],
    );
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ProductDetails(
                  product_detail_name: sections[index]['name'],
                  product_detail_price: sections[index]['price'],
                  product_detail_old_price:
                      sections[index]['old_price'].toString(),
                  product_detail_picture: sections[index]['picture'],
                  numero: sections[index]['numero'],
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
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 250.0,
                      width: 150.0,
                      //aqui se carga la imagen pero no desde la bd solamente estoy cargadn el path desde firebase
                      child: Image.asset(
                        product.picture,
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
                            product.name.toString(),
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
                                "\$" + product.price.toString(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text("   "),
                              //old price
                              Text(
                                product.old_price.toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(8)),
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
