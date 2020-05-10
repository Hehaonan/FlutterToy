import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toy/flutter_toy.dart';
import 'package:flutter_toy_example/utils/utils.dart';

class GesturePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GesturePageState();
  }
}

class GesturePageState extends State<GesturePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String _printStr = "";

  //圆的左上角顶点坐标
  double _positionX = 0, _positionY = 0;

  // 圆半径
  double _circleRadius = 40; //直径：diameter

  @override
  void initState() {
    super.initState();
    FlutterToy.channel.setMethodCallHandler(_onMethodCall);
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    switch (call.method) {
      case 'viewFocused':
        break;
    }
    return null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(GesturePage oldWidget) {
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
          title: Text('手势Demo'),
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
                  GestureDetector(
                    onTap: () => printMsg('onTap'),
                    onDoubleTap: () => printMsg('onDoubleTap'),
                    onLongPress: () => printMsg('onLongPress'),
                    onTapUp: (e) => printMsg('onTapUp'),
                    onTapDown: (e) => printMsg('onTapDown'),
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(color: Colors.pinkAccent),
                      child: Text(
                        'click me!!!!',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  Text(_printStr),
                ],
              ),
              Positioned(
                  left: getCorrectPositionX(),
                  top: getCorrectPositionY(),
                  child: GestureDetector(
                    onPanUpdate: (e) => moveUpdate(e),
                    onTap: () => onCircleTap(scaffoldKey.currentState),
                    child: Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 80,
                      child: Center(child: Text('drag me!')),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(_circleRadius)),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  printMsg(String s) {
    setState(() {
      _printStr += s + ',';
    });
  }

  double getCorrectPositionX() {
    return _positionX <= 0
        ? 0
        : _positionX <= MediaQuery.of(context).size.width - _circleRadius * 2
            ? _positionX
            : MediaQuery.of(context).size.width - _circleRadius * 2;
  }

  double getCorrectPositionY() {
    //屏幕高度
    double _mHeight = MediaQuery.of(context).size.height;
    //状态栏高度
    double _mStateHeight = MediaQuery.of(context).padding.top;
    //导航栏高度
    double _mAppbarHeight = kToolbarHeight;
    //正确的高度
    double _correctHeight =
        _mHeight - _mAppbarHeight - _mStateHeight - _circleRadius * 2;
    return _positionY <= 0
        ? 0
        : _positionY <= _correctHeight ? _positionY : _correctHeight;
  }

  moveUpdate(DragUpdateDetails e) {
    setState(() {
      _positionY += e.delta.dy;
      _positionX += e.delta.dx;
    });
    //printMsg(_positionX.toString());
  }

  onCircleTap(ScaffoldState scaffoldState) {
    Utils.showSnackBar(scaffoldState, '轻点~');
  }
}
