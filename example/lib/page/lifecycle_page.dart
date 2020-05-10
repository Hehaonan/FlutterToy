import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toy_example/utils/utils.dart';

/// StatelessWidget 只有createElement、build两个生命周期
///
/// StatefulWidget 生命周期三组：
/// 1.初始化时期
///   createState()
///   initState()
/// 2.更新时期
///   didChangeDependencies()
///   build()
///   didUpdateWidget()
/// 3.销毁时期
///   deactivate()
///   dispose()
///
class LifecyclePage extends StatefulWidget {
  /// 创建State时第一个执行
  @override
  State<StatefulWidget> createState() {
    return LifecyclePageState();
  }
}

class LifecyclePageState extends State<LifecyclePage>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String _printStr = "---";
  int count = 0;
  bool isDispose = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      printMsg('---paused---');
    } else if (state == AppLifecycleState.resumed) {
      printMsg('---resumed---');
    } else if (state == AppLifecycleState.inactive) {
      printMsg('---inactive---'); //非活动状态 来电话、任务管理器显示
    } else {
      printMsg('---other---');
    }
//    else if (state == AppLifecycleState.suspending) {
//      printMsg('---suspending---'); //ios 上未实现
//    }
  }

  /// 除构造外第一个调用，完成初始化工作
  @override
  void initState() {
    super.initState();
    printMsg('---initState---');
    //绑定应用生命周期
    WidgetsBinding.instance.addObserver(this);
  }

  /// 当依赖的State对象改变时调用
  /// a.第一次构建widget是，在initState()后调用
  /// b.当StatefulWidget依赖InheritedWidget时，InheritedWidget中的改变时，也会调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    printMsg('---didChangeDependencies---');
  }

  /// 父组件需要重绘时调用
  /// 可以判断 oldWidget 与 newWidget的某些属性不同时更新页面，防止过度刷新
  @override
  void didUpdateWidget(LifecyclePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    printMsg('---didUpdateWidget---');
  }

  /// didChangeDependencies()调用后立即调用
  /// setState()方法调用后也会调用
  @override
  Widget build(BuildContext context) {
    printMsg('---build---');
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('生命周期Demo'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => buttonClick(),
                    child: Text(
                      '点我' + count.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.purple),
                    ),
                  ),
                  Text(_printStr),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  printMsg(String msg) {
    if (isDispose) {
      return;
    }
    setState(() {
      _printStr += msg + ',\n';
    });
    debugPrint(msg);
  }

  showToast(String msg) {
    Utils.showSnackBar(scaffoldKey.currentState, msg);
  }

  /// 从当前对象树中销毁，某些情况下，其他对象树可以在重新引用
  /// 先于 dispose()方法执行
  /// 个人理解：彻底销毁前的存在的缓冲时期
  @override
  void deactivate() {
    super.deactivate();
    isDispose = true;
    printMsg('---deactivate---');
  }

  /// 从当前对象树中永久的彻底的销毁(permanently)
  /// 用于一些释放操作
  @override
  void dispose() {
    super.dispose();
    isDispose = true;
    printMsg('---dispose---');
    WidgetsBinding.instance.removeObserver(this);
  }

  buttonClick() {
    setState(() {
      count++;
    });
  }
}
