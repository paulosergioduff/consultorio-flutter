import 'package:flutter/material.dart';
import 'my_webview.dart';

class WebHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: FlatButton(
          child: Text("Abrir relatórios"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MyWebView(
                      title: "Meus relatórios",
                      selectedUrl: "https://sublocacoesweb.web.app/",
                    )));
          },
        ),
      ),
    );
  }
}
