import 'package:flutter/material.dart';
import 'package:flutter_toy_example/routes.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Page lists'),
        ),
        body: ListView.builder(
          itemCount: MyRoutes.routes.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) {
            List<String> keys = MyRoutes.routes.keys.toList();
            String key = keys[index];
            return Container(
              height: 50,
              margin: const EdgeInsets.only(top: 3, bottom: 3),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.routes[key]);
                },
                color: Colors.white,
                child: Text(keys[index]),
                textColor: Colors.lightBlue,
              ),
            );
          },
        ),
      ),
      onWillPop: () => Future.value(true), // 首页禁止返回退出
    );
  }
}
