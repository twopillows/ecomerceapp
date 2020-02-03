import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/Product/model/product.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/User/ui/screens/cart.dart';
import 'package:ecomerceapp/widgets/custom_appbar_text.dart';
import 'package:ecomerceapp/widgets/size_config.dart';

class ProductDetails extends StatefulWidget {
  final String uid;
  final String product_detail_name;
  final double product_detail_price;
  final String product_detail_old_price;
  final String product_detail_picture;
  final int numero;

  var product_info = [
    [
      "images/products/paw_print_pad/1.jpg",
      "images/products/paw_print_pad/2.jpg",
      "images/products/paw_print_pad/3.jpg",
      "images/products/paw_print_pad/4.jpg",
      "images/products/paw_print_pad/5.jpg",
      "images/products/paw_print_pad/6.jpg"
    ],
    [
      "images/products/cat_backpack/1.jpg",
      "images/products/cat_backpack/2.jpg",
      "images/products/cat_backpack/3.jpg",
      "images/products/cat_backpack/4.jpg",
      "images/products/cat_backpack/5.jpg",
      "images/products/cat_backpack/6.jpeg"
    ],
    [
      "images/products/dog_paw_clean/1.jpg",
      "images/products/dog_paw_clean/2.jpg",
      "images/products/dog_paw_clean/3.jpg",
      "images/products/dog_paw_clean/4.jpg",
      "images/products/dog_paw_clean/5.jpg",
      "images/products/dog_paw_clean/6.jpg",
      "images/products/dog_paw_clean/7.jpg",
      "images/products/dog_paw_clean/8.jpg",
      "images/products/dog_paw_clean/9.jpg",
      "images/products/dog_paw_clean/10.jpg",
      "images/products/dog_paw_clean/11.jpg"
    ],
    [
      "images/products/beds_for_pets/1.jpg",
      "images/products/beds_for_pets/2.jpg",
      "images/products/beds_for_pets/3.jpg",
      "images/products/beds_for_pets/4.jpg",
      "images/products/beds_for_pets/5.jpg",
      "images/products/beds_for_pets/6.jpg",
      "images/products/beds_for_pets/7.jpg"
    ],
    [
      "images/products/hair_remover/1.jpg",
      "images/products/hair_remover/2.jpg",
      "images/products/hair_remover/3.jpg",
      "images/products/hair_remover/4.jpg",
      "images/products/hair_remover/5.jpg",
      "images/products/hair_remover/6.jpg",
      "images/products/hair_remover/7.jpg",
      "images/products/hair_remover/8.jpg"
    ],
    //por aqui
    [
      "images/products/portable_water_bottle/1.jpg",
      "images/products/portable_water_bottle/2.jpg",
      "images/products/portable_water_bottle/3.jpg",
      "images/products/portable_water_bottle/4.jpg",
      "images/products/portable_water_bottle/5.jpg",
      "images/products/portable_water_bottle/6.jpg",
      "images/products/portable_water_bottle/7.jpg",
    ],
    [
      "images/products/dog_carrier_backpack/1.jpg",
    ],
    [
      "images/products/bags_dispenser/1.jpg",
      "images/products/bags_dispenser/2.jpg",
      "images/products/bags_dispenser/3.jpg",
      "images/products/bags_dispenser/4.jpg",
      "images/products/bags_dispenser/5.jpg",
      "images/products/bags_dispenser/6.jpg",
      "images/products/bags_dispenser/7.jpg",
      "images/products/bags_dispenser/8.jpg"
    ],
    [
      "images/products/food_treat_ball/1.jpg",
      "images/products/food_treat_ball/2.jpg",
      "images/products/food_treat_ball/3.jpg",
      "images/products/food_treat_ball/4.jpg",
      "images/products/food_treat_ball/5.jpg",
      "images/products/food_treat_ball/6.jpg",
      "images/products/food_treat_ball/7.jpg",
    ],
    [
      "images/products/poop_rolls/1.jpg",
    ],
    [
      "images/products/waterproof_cat_backpack/1.jpg",
      "images/products/waterproof_cat_backpack/2.jpg",
      "images/products/waterproof_cat_backpack/3.jpg",
      "images/products/waterproof_cat_backpack/4.jpg",
      "images/products/waterproof_cat_backpack/5.jpg",
      "images/products/waterproof_cat_backpack/6.jpg",
      "images/products/waterproof_cat_backpack/7.jpg",
      "images/products/waterproof_cat_backpack/8.jpg"
    ],
    [
      "images/products/finger_t/1.jpg",
      "images/products/finger_t/2.jpg",
      "images/products/finger_t/3.jpg",
    ],
  ];

  ProductDetails(
      {this.product_detail_name,
      this.product_detail_price,
      this.product_detail_old_price,
      this.product_detail_picture,
      this.numero,
      this.uid});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    userBloc = BlocProvider.of<UserBloc>(context);

    Product productoActual = Product(
        name: widget.product_detail_name,
        numero: widget.numero,
        old_price: widget.product_detail_old_price,
        picture: widget.product_detail_picture,
        price: widget.product_detail_price);

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              //aqui va el header
              _headerProductDetails(context),

              Flexible(
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 300,
                      child: GridTile(
                        child: Container(
                          color: Colors.white,
                          child: CarouselSlider(
                            height: 300.0,
                            //===================aquiiii lo q falta del numero q corresponde=====
                            items: widget.product_info[widget.numero].map((i) {
                              //items: widget.prueba.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Image.asset(
                                      i.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        footer: Container(
                          color: Colors.white70,
                          //height: 40,
                          child: ListTile(
                            leading: Text(
                              widget.product_detail_name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                            ),
                            title: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  "         \$${widget.product_detail_price.toString()}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                                Expanded(
                                    child: Text(
                                        "  ${widget.product_detail_old_price}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            decoration: (widget
                                                    .product_detail_old_price
                                                    .isEmpty)
                                                ? TextDecoration.none
                                                : TextDecoration.lineThrough)))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //=============THE VARIANTS BUTTONS BEGINS HERE=========
                    Row(
                      children: <Widget>[
                        // ========the size swith begiins here
                        Expanded(
                            child: MaterialButton(
                          elevation: 0.5,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Size"),
                                    //aqui en content puedo poner un column pa los sizes distintos
                                    content: Text("Variants"),
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(context);
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                });
                          },
                          color: Colors.white,
                          textColor: Colors.grey,
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text("Size")),
                              Expanded(child: Icon(Icons.keyboard_arrow_down)),
                            ],
                          ),
                        )),
                        // ========the color swith begiins here
                        Expanded(
                            child: MaterialButton(
                          elevation: 0.5,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Color"),
                                    //aqui en content puedo poner un column pa los sizes distintos
                                    content: Text("Variants"),
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(context);
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                });
                          },
                          color: Colors.white,
                          textColor: Colors.grey,
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text("Color")),
                              Expanded(child: Icon(Icons.keyboard_arrow_down)),
                            ],
                          ),
                        )),
                        // ========the qty swith begiins here
                        Expanded(
                            child: MaterialButton(
                          elevation: 0.5,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Qty"),
                                    //aqui en content puedo poner un column pa los sizes distintos
                                    content: Text("Variants"),
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(context);
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                });
                          },
                          color: Colors.white,
                          textColor: Colors.grey,
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text("Qty")),
                              Expanded(child: Icon(Icons.keyboard_arrow_down)),
                            ],
                          ),
                        )),
                      ],
                    ),

                    //Here begins the share and favorites bar
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {},
                            child: IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {},
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Expanded(child: Text("      ")),

                        ///AQUI ESTAN LOS FAVORTIOS
                        Expanded(
                            child: MaterialButton(
                          onPressed: () {},
                          child: IconButton(
                              icon: Icon(Icons.favorite),
                              color: Colors.red,
                              onPressed: () {
                                userBloc.subirProductos(productoActual);
                              }),
                        )),
                      ],
                    ),

                    //botton add to cart
                    Container(
                      //color: Colors.white,
                      height: 50,
                      child: Center(
                        child: Container(
                          width: 350,
                          height: 45,
                          child: RaisedButton(
                            elevation: 5,

                            ///aqui q agregue al carrito pero no vaya para la pagina de cart
                            ///mostrar animacion de cdo se agregue al carrito
                            onPressed: () => {
                              userBloc.subirProductosCarrito(productoActual)
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Color(0xFF108CED),
                            child: Text(
                              "Add To Cart",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Product Details"),
                      subtitle: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
                    ),
                    Divider(),
                    // product name
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 5, 5, 5),
                              child: Text(
                                "Product Name",
                                style: TextStyle(color: Colors.grey),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 5, 15, 5),
                              child: Text(
                                widget.product_detail_name,
                                //style: TextStyle(color: Colors.grey),
                              )),
                        ),
                      ],
                    ),
                    //product brand
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 5, 5, 5),
                              child: Text(
                                "Product Brand",
                                style: TextStyle(color: Colors.grey),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 5, 15, 5),
                              child: Text(
                                "Swap Trendy",
                                //style: TextStyle(color: Colors.grey),
                              )),
                        ),
                      ],
                    ),
                    //product condition
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 5, 5, 5),
                              child: Text(
                                "Product Condition",
                                style: TextStyle(color: Colors.grey),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 5, 15, 5),
                              child: Text(
                                "New",
                                //style: TextStyle(color: Colors.grey),
                              )),
                        ),
                      ],
                    ),
                    Divider(),

                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(' Pet Lovers Also Bought',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    //==============similar producto
                    Container(
                      height: 360,
                      child: SimilarProduct(),
                    ),
                    //=====AQUI VIENE LA PARTE DE RELATED PRODUCTS
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerProductDetails(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          //height: 80,
          height: SizeConfig.safeBlockVertical * 11,
//120
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                //Color(0xff1e2a54),
                //Color(0xff1773b3),
                Color(0xFF0060FF),
                Color(0xFF00A1FF),
              ],
            ),
          ),
        ),
        Padding(
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
              TitleHeader(
                title: 'Swap Trendy',
                //style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: userBloc.currentUserStream(widget.uid),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                                  builder: (context) => Cart(uid: widget.uid)));
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
      ],
    );
  }
}

//======================Similar Products=============================
class SimilarProduct extends StatefulWidget {
  @override
  _SimilarProductState createState() => _SimilarProductState();
}

class _SimilarProductState extends State<SimilarProduct> {
  var product_List = [
    {
      "name": "Paw Print Pad",
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
  ];

  @override
  Widget build(BuildContext context) {
    //final producto_Actual = product_List[index];

    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: product_List.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Similar_Single_product(
            //prod_name: product_info[index],
            prod_name: product_List[index]["name"],
            prod_picure: product_List[index]["picture"],
            prod_oldprice: product_List[index]["old_price"],
            prod_price: product_List[index]["price"],
            numero: product_List[index]["numero"],
          );
        });
  }
}

//===================single product====================
class Similar_Single_product extends StatelessWidget {
  final prod_name;
  final prod_picure;
  final prod_oldprice;
  final prod_price;
  final numero;

  const Similar_Single_product(
      {this.prod_name,
      this.prod_picure,
      this.prod_oldprice,
      this.prod_price,
      this.numero});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Hero(
        tag: Text("hero 1"),
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(
                //aqui va product details cdo se da clicks ProductDetails()
                MaterialPageRoute(builder: (context) => ProductDetails())),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              child: Stack(
                children: <Widget>[
                  GridTile(
                    child: Container(
                      child: Image.asset(prod_picure, fit: BoxFit.cover),
                    ),
                    footer: Container(
                      color: Colors.white70,
                      height: 50,
                      width: 300,
                      child: ListTile(
                        leading: Text(
                          prod_name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
