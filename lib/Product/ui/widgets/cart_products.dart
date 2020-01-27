import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/Product/model/product.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/Product/ui/screens/product_details.dart';

class Cart_Products extends StatefulWidget {
  @override
  _Cart_ProductsState createState() => _Cart_ProductsState();
}

class _Cart_ProductsState extends State<Cart_Products> {
  UserBloc userBloc;
  var Products_info = [
    {
      "name": "Paw Print Pad",
      "picture": "images/images/products_LA/1.jpeg",
      "price": 14.99,
      "numero": 0,
      "size": "M",
      "color": "Blue",
      "qty": 10,
    },
    {
      "name": "Cat BackPack",
      "picture": "images/images/products_LA/2.jpg",
      "price": 46.99,
      "numero": 1,
      "size": "S",
      "color": "Red",
      "qty": 20,
    },
    {
      "name": "Portable Water Bottle",
      "picture": "images/images/products_LA/6.jpg",
      "price": 14.99,
      "numero": 5,
      "size": "S",
      "color": "Red",
      "qty": 20,
    },
    {
      "name": "Dog Carrier BackPack",
      "picture": "images/images/products_LA/7.jpg",
      "price": 24.99,
      "numero": 6,
      "size": "S",
      "color": "Red",
      "qty": 20,
    },
  ];

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    // TODO: implement build
    return StreamBuilder<DocumentSnapshot>(
      //este stream da el usuario actual la info completa
      stream: userBloc.courseDocStream,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var courseDocument = snapshot.data.data;
          var sections = courseDocument['myCart'];
          //List<Product> temp = sections as List<Product>;
          return Expanded(
            child: SizedBox(
              child: ListView.builder(
                  itemExtent: 150,
                  itemCount: sections != null ? sections.length : 0,
                  itemBuilder: (_, int index) {
                    return Slidable(
                      actionPane: SlidableScrollActionPane(),
                      actionExtentRatio: 0.25,
                      child: Single_Cart_Product(
                        cart_product_name: sections[index]['name'],
                        cart_product_picture: sections[index]["picture"],
                        cart_product_price: sections[index]["price"],
                        cart_product_numero: sections[index]["numero"],
                        cart_product_size: "0",
                        cart_product_color: "blue",
                        cart_product_qty: '1',
                        cart_product_old_price:
                            sections[index]['old_price'].toString(),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          //aqui tngo q convertir el producto que esta en json a producto para pasarselo al metodo
                          onTap: () {
                            //Product temp = Product.fromJson(sections[index]); // este no puede ser porq no se como crear producto desde json
                            userBloc.eliminarProductoCarrito(sections[index]);
                            print("elimino de favorito");
                          },
                        ),
                      ],
                    );

                    /*Single_Cart_Product(
                      cart_product_name: sections[index]['name'],
                      cart_product_picture: sections[index]["picture"],
                      cart_product_price: sections[index]["price"],
                      cart_product_numero:
                      sections[index]["numero"],
                      cart_product_size: "0",
                      cart_product_color: "blue",
                      cart_product_qty: '1',
                      cart_product_old_price: sections[index]['old_price'].toString(),
                    )*/
                  }),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

/*  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Products_info.length,
        itemBuilder: (context, index) {
          return Single_Cart_Product(
              cart_product_name: Products_info[index]["name"],
              cart_product_picture: Products_info[index]["picture"],
              cart_product_price: Products_info[index]["price"],
              cart_product_numero: Products_info[index]["numero"],
              cart_product_size: Products_info[index]["size"],
              cart_product_color: Products_info[index]["color"],
              cart_product_qty: Products_info[index]["qty"]);
        });
  }*/
}

/*cart_product_name: Products_info[index]["name"],
            cart_product_picture: Products_info[index]["picture"],
            cart_product_price: Products_info[index]["price"],
            cart_product_numero: Products_info[index]["numero"],
            cart_product_size: Products_info[index]["size"],
            cart_product_color: Products_info[index]["color"],
            cart_product_qty: Products_info[index]["qty"],*/

class Single_Cart_Product extends StatelessWidget {
  final String cart_product_name;
  final String cart_product_picture;
  final double cart_product_price;
  final cart_product_numero;
  final cart_product_size;
  final cart_product_color;
  final cart_product_qty;
  final String cart_product_old_price;

  Single_Cart_Product(
      {this.cart_product_name,
      this.cart_product_picture,
      this.cart_product_price,
      this.cart_product_numero,
      this.cart_product_size,
      this.cart_product_color,
      this.cart_product_qty,
      this.cart_product_old_price});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          //aqui va product details cdo se da clicks ProductDetails()
          MaterialPageRoute(
              builder: (context) => ProductDetails(
                    //aqui estoy diciendo de q producto son los datos
                    //para generar la productdetails page corespondint
                    product_detail_name: cart_product_name,
                    //product_detail_price: document['price'].toString(),
                    product_detail_price: cart_product_price,
                    product_detail_old_price: cart_product_old_price,
                    //product_detail_picture: product_list[index]["picture"],
                    product_detail_picture: cart_product_picture,
                    numero: cart_product_numero,
                    //"numero": "12",
                    //images: producto_Actual.images,
                  )),
        );
      },
      child: Card(
        elevation: 10,
        child: Row(
          children: <Widget>[
            //aqui va la foto
            Expanded(
                child: Image.asset(
              cart_product_picture,
              height: 100,
              width: 100,
            )),

            //aqui l nombre con las variantes
            Expanded(
                child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 150,
                  child: Text(
                    cart_product_name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                        child: Text("S: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                        child: Text(cart_product_size,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 1, 1, 1),
                        child: Text("C: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                        child: Text(cart_product_color,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text("Qty:"),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.grey,
                        ),
                        /*onPressed: () => Navigator.push(
                            //arreglar a donde va
                            context,
                            MaterialPageRoute(
                                builder: (context) => cart_product_picture())),*/
                      ),
                    ),
                    Text(cart_product_qty.toString()),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Colors.grey,
                        ),
                        /*onPressed: () => Navigator.push(
                            //arreglar a donde va
                            context,
                            MaterialPageRoute(
                                builder: (context) => cart_product_picture())),*/
                      ),
                    ),
                  ],
                ),
              ],
            )),

            //aqui l preco con l contador de qtyy
            //Expanded(child: Text("sdfg")),

            //aqui el boton de cancelar
            Expanded(
                child: Text(
              "\$" + cart_product_price.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
    );
  }

/*  void addQty(){
    int cant = cart_product_qty;
    cant ++;
    cant = cart_product_qty;
  }*/
}
