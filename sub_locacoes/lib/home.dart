import 'package:sub_locacoes/apps/calendario/calendario-main.dart';
import 'package:sub_locacoes/clone/Constants/Constants.dart';
import 'package:sub_locacoes/clone/Model/SliderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sub_locacoes/clone/Routes/Properties.dart';
import 'package:sub_locacoes/main-widget/common.dart';

class SubLocacoes extends StatefulWidget {
  @override
  MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<SubLocacoes> {
  List<SliderModel> slides = new List<SliderModel>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

// Example code for sign out.
  Future<void> _signOut() async {
    await _auth.signOut();
  }

  int currentState;

  PageController pageController = new PageController(initialPage: 0);
  @override
  void initState() {
    slides = SliderModel.getSlides();
  }

  @override
  Widget build(BuildContext context) {
    //StartMenu();
    MaterialApp(
      title: 'Sub Locações',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: const Color(0xFF9c27b0),
        accentColor: const Color(0xFF9c27b0),
        canvasColor: const Color(0xFFfafafa),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Locações"), // Passando paramtro -->(widget.title),
      ),
      drawer: menuPrincipal(),
      backgroundColor: Colors.white,
      body: PageView.builder(
        itemBuilder: (context, index) {
          return SlideTiles(
            slides[index].imagePath,
            slides[index].text,
            slides[index].title,
            index,
          );
        },
        controller: pageController,
        itemCount: slides.length,
        scrollDirection: Axis.horizontal,
        onPageChanged: (val) {
          currentState = val;
        },
      ),
    );
  }
}

class SlideTiles extends StatelessWidget {
  String imagePath, text, title;
  int current;
  String textoBotao = "Selecionar";

  SlideTiles(this.imagePath, this.text, this.title, this.current);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: -60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < SliderModel.getSlides().length; i++)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: current == i ? 20 : 8,
                  height: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: current == i
                          ? Constants.greenAirbnb
                          : Colors.grey[400]),
                ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 22,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.black38),
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: () {
              if (title == "Reserve por hora") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalendarioInterface()),
                );
              }
              if (title == "Reserve por sala") {
                //AddProperty
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Properties()),
                );
              }
              /*if (title == "Sair do modo agendamento") {
                //AddProperty
                //textoBotao = "Sair";

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyHomePage()));
              }*/
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Constants.greenAirbnb,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, color: Colors.grey, offset: Offset(0, 2))
                  ]),
              child: Text(
                textoBotao,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
