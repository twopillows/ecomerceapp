import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecomerceapp/Product/model/product.dart';
import 'package:ecomerceapp/User/model/user.dart';
import 'package:ecomerceapp/User/ui/widgets/profile_place.dart';
import 'package:ecomerceapp/Product/ui/screens/product_details.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PRODUCTS = "product_list";
  final String FAVORITES = "favorites";
  Firestore _db = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  ///este metodo es para q se actualice la info del usuario cada vez q se loguea
  void updateUserDataFirestore(User user) async {
    DocumentReference ref = _db.collection(USERS).document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myOrders': user.myOrders,
      //'myFavoriteProducts8': user.myFavoriteProducts,
      //'myCart': user.myCart,
      'lastSignIn': DateTime.now()
    }, merge: true);
  }

  ///contar la cantidad a pagar para mostrarlo en el total en el carrito
  Future<double> calcularTotal() async {
    var user = await _auth.currentUser();
  }

  ///este lo q hace es agregar el producto al q se le dio favorito a la pagina de favoritos
  void subirProductos(Product productoAgregar) async {
    var user = await _auth.currentUser();
    List<Map<String, dynamic>> productosSerializados;
    final productoJSON =
        productoAgregar.toJson(); // este prod esta listo para ser subido

    productosSerializados = [productoJSON];
    print("alla");
    _db.collection(USERS).document(user.uid).updateData({
      //'myFavoriteProducts': FieldValue.arrayUnion(productosSerializados);
      'myFavoriteProducts': FieldValue.arrayUnion(productosSerializados)
    });
  }

  ///este lo q hace es agregar el producto al q se le dio ADD TO CART a la pagina de CARRITO
  void subirProductosCarrito(Product productoAgregar) async {
    var user = await _auth.currentUser();
    List<Map<String, dynamic>> productosSerializados;
    final productoJSON =
        productoAgregar.toJson(); // este prod esta listo para ser subido

    productosSerializados = [productoJSON];
    print("SE ANNADIO AL CARRITO");
    _db.collection(USERS).document(user.uid).updateData({
      //'myFavoriteProducts': FieldValue.arrayUnion(productosSerializados);
      'myCart': FieldValue.arrayUnion(productosSerializados)
    });
  }

  ///aqui va el metodo para eliminar un producto de la lista de favoritos
  void eliminarDeFavoritos(var producto) async {
    // me dan el producto en json
    var user = await _auth.currentUser();
//tengo q ver cual es la diferencia entre List<Map<String, dynamic>> y List<dynamic>
    List<dynamic> prodAELiminar = [producto];
    _db.collection(USERS).document(user.uid).updateData(
        {'myFavoriteProducts': FieldValue.arrayRemove(prodAELiminar)});
  }

  ///aqui va el eliminar producto del carrito
  void eliminarProductoCarrito(var producto) async {
    var user = await _auth.currentUser();
    List<dynamic> prodAELiminar = [producto];

    _db
        .collection(USERS)
        .document(user.uid)
        .updateData({'myCart': FieldValue.arrayRemove(prodAELiminar)});
  }

  ///aqui dado todos los usuarios quiero escoger el actual y mostrar su lista de favs
/*
  void buildPlaces(List<DocumentSnapshot> usersListSnapshot) async {
    List<User> usersList = List<User>();

    usersListSnapshot.forEach((p) {
      usersList.add(User.fromJson(json.decode(p.data.toString())));
    });

    await _auth.currentUser().then((FirebaseUser user) async {
      List<Product> productosActuales = List<Product>();
      bool found = false;
      if (usersList[0] != null) {
        for (int x = 0; x < usersList.length || found; x++) {
          User temp = usersList[x];
          if (user.uid == temp.uid) {
            found = true;
            productosActuales = temp.myFavoriteProducts.toList();
          }
        }
      }

      Widget _buildProductCard(BuildContext context, Product document) {
        //final producto_Actual = product_list[index];
        return InkWell(
          onTap: () => Navigator.of(context).push(
              //aqui va product details cdo se da clicks ProductDetails()
              MaterialPageRoute(
                  builder: (context) => ProductDetails(
                        //aqui estoy diciendo de q producto son los datos
                        //para generar la productdetails page corespondint
                        product_detail_name: document.name,
                        product_detail_price: document.price,
                        product_detail_old_price: document.old_price.toString(),
                        product_detail_picture: document.picture,
                        numero: document.numero,
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
                          child: //NetworkImage(url),

                          Image.asset(
                            document.picture,
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
                                document.name,
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600),
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
                                        color: Colors.yellowAccent,
                                        fontSize: 18.0),
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
                                    "\$" + document.price.toString(),
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text("   "),
                                  //old price
                                  Text(
                                    document.old_price.toString(),
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              ),

                              Padding(padding: EdgeInsets.all(8)),
                              //BOTON ADD TO CART
                              */
/*RaisedButton(

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () => Navigator.of(context).push(
                                //aqui va product details cdo se da clicks ProductDetails()
                                MaterialPageRoute(
                                    builder: (context) => ProductDetails())),
                            child: Text("ADD TO CART"),
                          ),*/ /*

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

      Widget algo() {
        return ListView.builder(
          itemExtent: 300.0,
          itemCount: productosActuales.length,
          itemBuilder: (context, index) =>
              _buildProductCard(context, productosActuales[index]),
          scrollDirection: Axis.vertical,
        );
      }
    });
  }
*/

  ///
  ///
  /// ahora tngo q hacer un metodo q dado la lista de usuario escoga el actual y lograr sacar la lista de productos
  ///
  /// /*    var userActual = await _auth.currentUser();
  //
  //
  //
  //    bool found = false;
  //    if (usersList[0] != null) {
  //      for (int x = 0; x < usersList.length || found; x++) {
  //        User temp = usersList[x];
  //        if (userActual.uid == temp.uid) {
  //          found = true;
  //          List<Product> productosActuales = temp.myFavoriteProducts.toList();
  //        }
  //      }
  //    }*/
/*

  Future<List<Product>> obtenerListaProductosUsuarioActual(List<User> usuarios) async {
    var userActual = await _auth.currentUser();
    bool found = false;
    if (usuarios[0] != null) {
      for (int x = 0; x < usuarios.length || found; x++) {
        User temp = usuarios[x];
        if (userActual.uid == temp.uid) {
          found = true;
          List<Product> productosActuales = temp.myFavoriteProducts.toList();
        }
      }
    }
  }*/

  /*void subirProductos(Product ) async {
    var user = await _auth.currentUser();
    List<Map<String, dynamic>> productosSerializados;
    final productoJSON =
        productoAgregar.toJson(); // este prod esta listo para ser subido

    productosSerializados = [productoJSON];
    print("alla");
    _db.collection(USERS).document(user.uid).updateData({
      //'myFavoriteProducts': FieldValue.arrayUnion(productosSerializados);
      'myFavoriteProducts': FieldValue.arrayUnion(productosSerializados)
    });
  }*/

/*  Future<void> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);

    await _auth.currentUser().then((FirebaseUser user){
      refPlaces.add({
        'name' : place.name,
        'description': place.description,
        'likes': place.likes,
        'userOwner': _db.document("${USERS}/${user.uid}"),//reference
      }).then((DocumentReference dr) {
        dr.get().then((DocumentSnapshot snapshot){
          //ID Place REFERENCIA ARRAY
          DocumentReference refUsers = _db.collection(USERS).document(user.uid);
          refUsers.updateData({
            'myPlaces' : FieldValue.arrayUnion([_db.document("${FAVORITES}/${snapshot.documentID}")])
          });

        });
      });
    });
  }*/
  /// metodo para agregar un favorito a la lista de favoritos pero como objeto y no como referencia
  /// para despues leerlo y convertirlo a una lista de objetos product

/*  Future<void> updateFavoritesData(Product product) async {
    CollectionReference refProducts = _db.collection(FAVORITES);

    await _auth.currentUser().then((FirebaseUser user) {
      refProducts.add({
        'name': product.name,
        'numero': product.numero.toString(),
        'old_price': product.old_price,
        'picture': product.picture,
        'price': product.price,
      }).then((DocumentReference dr) {
        dr.get().then((DocumentSnapshot snapshot) {
          DocumentReference refUsers = _db.collection(USERS).document(user.uid);
          refUsers.updateData({
            'myFavoriteProducts':
                FieldValue.arrayUnion(["${FAVORITES}/${snapshot.documentID}"])
          });
        });
      });
    });
  }*/

////////////////////////
  Future<List<Product>> showFavoritesProducts() async {
    CollectionReference ref = _db.collection(USERS);

    await _auth.currentUser().then((FirebaseUser user) async {
      QuerySnapshot eventsQuery =
          await ref.where(user.uid, isEqualTo: user.uid).getDocuments();

      HashMap<String, User> listaProductos = HashMap<String, User>();

      eventsQuery.documents.forEach((document) {
        listaProductos.putIfAbsent(
            document['id'],
            () => new User(
                  name: document['name'],
                  email: document['email'],
                  photoURL: document['photoURL'],
                  myOrders: document['myOrders'],
                  myFavoriteProducts: document['myFavoriteProducts'],
                  myCart: document['myCart'],
                  //photoUrl: _getEventPhotoUrl(document['group']),
                  //latLng: _getLatLng(document)
                ));
      });

      return listaProductos.values.toList();
    });

    //CollectionReference ref = _db.collection(USERS);
    //DocumentReference usersRef = ref.document();

    //HashMap<String, Product> eventsHashMap = new HashMap<String, Product>();
  }

////////////////////////////

  ///ojooooooojojojojojjojojojoojojojojojojoojjoojojojojjoojjo

  /*List<User> buildPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<User> profilePlaces = List<User>();
    placesListSnapshot.forEach((p) {
      profilePlaces.add(User(
        name: p.data['name'],
        email: p.data['email'],
        photoURL: p.data['photoURL'],
        myOrders: p.data['myOrders'],
        myFavoriteProducts: p.data['myFavoriteProducts'],
        myCart: p.data['myCart'],
      ));
    });

    return profilePlaces;
  }*/

  //var jsonData = '{ "name" : "Dane", "alias" : "FilledStacks"  }';
  //var parsedJson = json.decode(jsonData);
  //var user = User(parsedJson);

  //cdo le de a annadir a los favoritos

  //coger ese producto pasarlo como parametro
  //primero lo q hay q hacer es agregar el producto a la lista de favoritos
  //y actualizar la lista de favoritos

  /*Future<void> updateFavoritesProductData(Product product) async {
    CollectionReference refProducts = _db.collection(USERS);
    List<Product> listaTemp;

    var user = await _auth.currentUser();
    var userQuery =
    _db.collection(USERS).where(user.uid, isEqualTo: user.uid).limit(1);
    userQuery.getDocuments().then((data) {
      if (data.documents.length > 0) {
        //listaTemp = data.documents[0].data['myFavoriteProducts'];
        listaTemp = List.from(data.documents[0].data['myFavoriteProducts']);
        print("holaaaaaa");

        print(listaTemp[1].name);
      }
      */ /*setState(() {
          firstName = data.documents[0].data['firstName'];
          lastName = data.documents[0].data['lastName'];
        });*/ /*
    });

    //List<Product> temp = [product];
    if (listaTemp == null) {
      DocumentReference userActual = _db.collection(USERS).document(user.uid);
      */ /*listaTemp = List.from(
          _db.collection(USERS).documents(user.uid).data['myFavoriteProducts']);*/ /*
      print("llego al if");
      //print(listaTemp.length.toString());
      listaTemp = [product];
      print("llego al if");
      print(listaTemp.length.toString());
      print(listaTemp[0].name);
      //print("listaTemp[0].price");
    } else {
      print("llego al else");

      listaTemp.add(product);
    }

    //List<String> names = List.from(document['names']);
    //List<String> newtuete;

    */ /*List<String> toList() {

      listaTemp.forEach((item) {

        newtuete.add(item.toString());
      });

      return newtuete.toList();
    }*/ /*

    //aqui lo q se hace es serializar el favorito para poder subirlo

*/ /*    final productoAAgregar = product;
    final productJson = productoAAgregar.toJson();
    List<Map<String, dynamic>> todosProductosSerializados;

    //para el primero
    todosProductosSerializados = [productJson];

    //para los demas
    todosProductosSerializados.add(productJson);*/ /*

    */ /*_db.collection(USERS).document(user.uid).setData({
      'myFavoriteProducts': listaTemp,
    }, merge: true);*/ /*
  }
*/

  ///Y OTRO METODO PARA RECIVIR EN JSON DE LA BD LA LISTA ACTUAL
  ///convertir del json de la bd a lista de prod y pasarselo al otro metodo
  ///obj pasar lista productos actual a metodo subir productos
  void obtenerListaProductosActual() async {
    var user = await _auth.currentUser();
    print("entorn al metodo");
    //List<Product> listaFinal;
    List<Map<String, dynamic>> listaFinal;

    StreamBuilder(
        stream: _db.collection(USERS).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("eempezo el stream");
            listaFinal = snapshot.data.document(user.uid).myFavoriteProducts;
            print(listaFinal[0].toString());
            //return print("retorno");
            print("termino el stream");
          }
        });
  }
}

/*await _auth
        .currentUser()
        .then((FirebaseUser user) => refProducts.document(user.uid).setData({
              'myFavoriteProducts': userActual.myFavoriteProducts,
            }, merge: true));
     */
//List<Product> listaTemp = refProducts.document(userActualID);
//refProducts.document(userActualID).

/*StreamBuilder(
      stream: _db.collection(USERS).snapshots(),
        builder: (context, snapshot){

        listaTemp = snapshot.data.document(userActualID).myFavoriteProducts();
        });

    _db.collection(USERS).document(userActualID).
*/

/*StreamBuilder(
        stream:
        Firestore.instance.collection('product_list').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');

          return Expanded(
            child: SizedBox(
              child: ListView.builder(
                  itemExtent: 300.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => _buildProductCard(
                      context, snapshot.data.documents[index])),
            ),
          );
        });
*/

//tngo q poner los productos favoritos en una coleccion de
//productos q corresponden a un usuario

/*
Future<void> updatePlaceData(Place place) async {
  CollectionReference refPlaces = _db.collection(PLACES);

  await _auth.currentUser().then((FirebaseUser user){
    refPlaces.add({
      'name' : place.name,
      'description': place.description,
      'likes': place.likes,
      'userOwner': "${USERS}/${user.uid}",//reference
    });
  });


}
*/
