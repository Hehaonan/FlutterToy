import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toy_example/plugin/plugin_textview.dart';
import 'package:flutter_toy_example/utils/utils.dart';

class PluginViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PluginViewPageState();
  }
}

class PluginViewPageState extends State<PluginViewPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String _printStr = "---";

  @override
  void initState() {
    super.initState();
    PluginTextView.channel.setMethodCallHandler(_onMethodCall);
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    switch (call.method) {
      case 'viewClick':
        Utils.showSnackBar(scaffoldKey.currentState,
            'flutter show: ' + call.arguments.toString());
        getNativeInfo();
        break;
    }
    return null;
  }

  Future<void> getNativeInfo() async {
    String temp = "==================";
    try {
      temp = await PluginTextView.getPlatformVersion();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _printStr = "get from native: " + temp;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(PluginViewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('插件ViewDemo'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      height: 100.0,
                      margin: EdgeInsets.all(10),
                      child: AndroidView(
                          onPlatformViewCreated: (id) =>
                              onViewCreated(scaffoldKey.currentState, id),
                          viewType: "QMapView",
                          creationParamsCodec: const StandardMessageCodec(),
                          creationParams: {
                            'method_text_str': 'flutter params: I from flutter!'
                          })),
                  Text(_printStr),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onViewCreated(ScaffoldState scaffoldState, int id) {
    Utils.showSnackBar(
        scaffoldState, 'flutter show: plugin view creted id=' + id.toString());
  }

  printMsg(String s) {
    setState(() {
      _printStr += s + ',';
    });
  }

  onCircleTap(ScaffoldState scaffoldState) {
    Utils.showSnackBar(scaffoldState, '轻点~');
  }
}
