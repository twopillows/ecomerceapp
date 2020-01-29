import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/Product/ui/screens/product_details.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/User/ui/screens/cart.dart';
import 'package:ecomerceapp/widgets/size_config.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            //Here the header appBar
            _headerProductList(context),

            Expanded(
              child: Column(
                //Here start the product list section
                children: <Widget>[
                  //Here comes the sream builder to the listview of product
                  StreamBuilder(
                      stream: Firestore.instance
                          .collection('product_list')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text('Loading...');

                        return Expanded(
                          child: SizedBox(
                            child: ListView.builder(
                                itemExtent: 300.0,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) =>
                                    _buildProductCard(context,
                                        snapshot.data.documents[index])),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildProductCard(BuildContext context, DocumentSnapshot document) {
    //final producto_Actual = product_list[index];
    return InkWell(
      onTap: () => Navigator.of(context).push(
          //aqui va product details cdo se da clicks ProductDetails()
          MaterialPageRoute(
              builder: (context) => ProductDetails(
                    //aqui estoy diciendo de q producto son los datos
                    //para generar la productdetails page corespondint
                    product_detail_name: document['name'],
                    //product_detail_price: document['price'].toString(),
                    product_detail_price: document['price'],
                    product_detail_old_price: document['old_price'].toString(),
                    //product_detail_picture: product_list[index]["picture"],
                    product_detail_picture: document['picture'],
                    numero: document['numero'],
                    //"numero": "12",
                    //images: producto_Actual.images,
                  ))),
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
                        document['picture'],
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
                            document['name'],
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
                                "\$" + document['price'].toString(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text("   "),
                              //old price
                              Text(
                                document['old_price'].toString(),
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

  Widget _headerProductList(BuildContext context) {
    return SafeArea(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            //height: 85,
            height: SizeConfig.safeBlockVertical * 11,

            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0060FF),
                  Color(0xFF00A1FF),
                ],
              ),
            ),
          ),
          Padding(
            //padding: EdgeInsets.fromLTRB(
            //  16, MediaQuery.of(context).padding.top + 16, 16, 16),
            padding: EdgeInsets.fromLTRB(
                16, MediaQuery.of(context).padding.top + 28, 16, 0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ///aqui va el bottom pa atras
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }, //alignment: Alignment.centerLeft,
                ),

                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    'Swap Trendy',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold),
                  ),
                ),

                StreamBuilder<DocumentSnapshot>(
                    stream: userBloc.currentUserStream,
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var courseDocument = snapshot.data.data;
                        var sections = courseDocument['myCart'];

                        return BadgeIconButton(
                          //itemCount: 3,
                          itemCount: sections != null ? sections.length : 0,
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Cart()));
                          },
                        );
                      } else {
                        return Container(
                          child: Text(""),
                        );
                      }
                    }),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
            child: Center(
              child: Text("🚚FREE SHIPPING🚚"),
            ),
          ),
        ],
      ),
    );
  }
}

/*var product_list = [
    {
      "name": "Paw Print Pad",
      "picture": "gs://swaptrendymac.appspot.com/images/1.jpeg",
      "picture": "images/images/products_LA/1.jpeg",
      "old_price": 19.99,
      "price": 14.99,
      "numero": 0,
    },
    {
      "name": "Cat BackPack",
      "picture": "images/images/products_LA/2.jpg",
      "old_price": 65.99,
      "price": 46.99,
      "numero": 1,
    },
    {
      "name": "Dog Paw Clean",
      "picture": "images/images/products_LA/3.jpg",
      "old_price": "",
      "price": 21.99,
      "numero": 2,
    },
    {
      "name": "Beds For Pets",
      "picture": "images/images/products_LA/4.jpg",
      "old_price": "",
      "price": 21.99,
      "numero": 3,
    },
    {
      "name": "Hair Remover",
      "picture": "images/images/products_LA/5.jpg",
      "old_price": 29.99,
      "price": 23.99,
      "numero": 4,
    },
    {
      "name": "Portable Water Bottle",
      "picture": "images/images/products_LA/6.jpg",
      "old_price": 19.99,
      "price": 14.99,
      "numero": 5,
    },
    {
      "name": "Dog Carrier BackPack",
      "picture": "images/images/products_LA/7.jpg",
      "old_price": "",
      "price": 24.99,
      "numero": 6,
    },
    {
      "name": "Bags Dispenser",
      "picture": "images/images/products_LA/8.jpg",
      "old_price": "",
      "price": 9.99,
      "numero": 7,
    },
    {
      "name": "Food Treat Ball",
      "picture": "images/images/products_LA/9.jpg",
      "old_price": 32.99,
      "price": 24.99,
      "numero": 8,
    },
    {
      "name": "Dog Poop Rolls",
      "picture": "images/images/products_LA/16.jpg",
      "old_price": "7",
      "price": 9.99,
      "numero": 9,
    },
    {
      "name": "WaterProof Cat Backpack",
      "picture": "images/images/products_LA/17.jpg",
      "old_price": 59.99,
      "price": 45.46,
      "numero": 10,
    },
    {
      "name": "Finger Toothbrush",
      "picture": "images/images/products_LA/15.jpg",
      "old_price": "",
      "price": 9.99,
      "numero": 11,
    },
  ];*/
