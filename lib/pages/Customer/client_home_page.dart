import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ia_card/constants.dart';
import 'package:ia_card/pages/Customer/category_listing_page.dart';
import 'package:ia_card/pages/Customer/cart_listing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ia_card/pages/Customer/user_profile_page.dart';
import 'package:ia_card/widgets/appBar.dart';
import 'package:ia_card/widgets/post_get_firebase.dart';

import '../../main.dart';
import 'customer_purchase_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required var this.user}) : super(key: key);
  final User user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(
        textTitle: "Restaurante",
        leading: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: new IconButton(
            icon: new Icon(Icons.person),
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserPageSettings(
                        user: FirebaseAuth.instance.currentUser!)),
              );
            },
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
      children: [
        _buildVerticalSpace(),
        _buildToolBar(),
        _buildVerticalSpace(),
        _categoryBuilder(),
        _buildVerticalSpace(),
        _buildCategoryOptions(),
        _buildVerticalSpace(height: 54),
        _buildHistoryButton(),
      ],
    );
  }

  Align _categoryBuilder() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 225,
        decoration: new BoxDecoration(
          color: K_PRIMARY_COLOR_LIGHT,
          borderRadius: new BorderRadius.only(
            bottomRight: const Radius.circular(25),
            topRight: const Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Categorias',
            style: GoogleFonts.passionOne(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }

  Container _buildToolBar() {
    return Container(
      //color: Colors.white,
      height: 70,
      child: Wrap(
        children: [
          MyApp.searchBarBuilderStatic(searchController),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartListingPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 0.0,
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            child: Icon(
              Icons.shopping_cart,
              size: 35,
              color: K_PRIMARY_COLOR_LIGHT,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildHistoryButton() {
    return Container(
      width: 269,
      height: 41,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: K_PRIMARY_COLOR_LIGHT,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          '>  Ver meu histórico  <',
          style: GoogleFonts.passionOne(
            color: Colors.white,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 24.0,
          ),
        ),
        onPressed: () {
          ToFirebaseWidget.getCustomerHistory(
              FirebaseAuth.instance.currentUser?.uid);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HistoryListingPageClass(costumerName: "Historico")),
          );
        },
      ),
    );
  }

  _buildCategoryOptions() {
    return Wrap(
      spacing: 39, // gap between adjacent chips
      runSpacing: 35, // gap between lines
      children: <Widget>[
        Container(
          child: stackedButtonImage(
            imageAddress: 'assets/images/categories/bebidas.png',
            categoryName: "Drink",
          ),
        ),
        Container(
          child: stackedButtonImage(
            imageAddress: 'assets/images/categories/porcoes.png',
            categoryName: "Portions",
          ),
        ),
        Container(
          child: stackedButtonImage(
            imageAddress: 'assets/images/categories/lanches.png',
            categoryName: "Lanches",
          ),
        ),
        Container(
          child: stackedButtonImage(
            imageAddress: 'assets/images/categories/a_la_carte.png',
            categoryName: "A la carte",
          ),
        ),
        Container(
          child: stackedButtonImage(
            imageAddress: 'assets/images/categories/saladas.png',
            categoryName: "Saladas",
          ),
        ),
        Container(
          child: stackedButtonImage(
            imageAddress: 'assets/images/categories/sobremesas.png',
            categoryName: "Sobremesas",
          ),
        ),
      ],
    );
  }

  Stack stackedButtonImage({
    String imageAddress = "",
    double containerWidth = 149,
    double containerHeight = 42,
    String categoryName = "",
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: containerWidth,
          height: containerHeight,
          child: Row(
            children: [
              ElevatedButton(
                child: Text(
                  categoryName,
                  style: GoogleFonts.acme(
                    color: K_TEXT_COLOR_HARD,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,
                    fontSize: 18.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  primary: Color.fromARGB(255, 253, 237, 231),
                  minimumSize: Size(containerWidth, containerHeight),
                  elevation: 0.0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CategoryListingPageClass(name: categoryName)),
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          // image in right
          top: -20,
          right: -30,
          child: new Image.asset(
            imageAddress,
            width: 80.0,
            height: 80.0,
          ),
        )
      ],
    );
  }

  _buildVerticalSpace({double height = 26}) {
    return SizedBox(height: height);
  }
}