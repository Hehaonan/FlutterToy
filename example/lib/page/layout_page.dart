import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toy_example/utils/utils.dart';

class LayoutPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final String imageUrl = "http://www.devio.org/img/avatar.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: true, //控制是否有按钮
        title: const Text('Layout Demo'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Utils.showSnackBar(scaffoldKey.currentState, 'Show Snackbar');
            },
          ),
          IconButton(
            icon: const Icon(Icons.nature_people),
            tooltip: 'Next page',
            onPressed: () {
              openPage(context);
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: false,
            expandedHeight: 200.0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
//              title: const Text('ScrollView'),
              background: Image.asset(
                Utils.getImgPath('scbg', format: 'jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: new SliverToBoxAdapter(
                child: buildContentWidget(),
              )),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid(
              //Grid
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          //List
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return new Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: new Text('list item $index'),
              );
            }, childCount: 50 //50个列表项
                ),
          ),
        ],
      ),
    );
  }

  buildContentWidget() {
    return Container(
      //垂直布局
      child: Column(
        //默认属性，实际的宽度取决于子项中宽度最大的Widget
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //第一个水平布局
          buildRowAvatar(),
          //第二个ViewPage
          Container(
            height: 100,
            margin: EdgeInsets.all(10),
            child: PhysicalModel(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              clipBehavior: Clip.antiAlias,
              child: PageView(
                children: <Widget>[
                  buildPageViewItem('Page One', Colors.deepPurple),
                  buildPageViewItem('Page Two', Colors.greenAccent),
                  buildPageViewItem('Page Three', Colors.blue),
                  buildPageViewItem('Page Four', Colors.red),
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.yellow),
              child: Center(child: Text('横向填充')),
            ),
          ),
          Stack(
            children: <Widget>[
              buildImage(),
              Positioned(
                right: 0,
                bottom: 0,
                child: buildImage(width: 50, height: 50),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 2,
            children: <Widget>[
              buildChip('1叶文洁'),
              buildChip('逻辑'),
              buildChip('埃文斯'),
              buildChip('黑暗森林法则'),
              buildChip('云天明'),
              buildChip('程心'),
              buildChip('艾AA'),
              buildChip('关一帆'),
            ],
          ),
          Row(
            children: <Widget>[
              Container(margin: EdgeInsets.only(left: 5), child: Text('向左走')),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(color: Colors.green),
                  child: Center(child: Text('test expanded')),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Text('向右走'))
            ],
          )
        ],
      ),
    );
  }

  buildImage({double width, double height}) {
//    return Image.network(
//      imageUrl,
//      width: width ?? 100,
//      height: height ?? 100,
//    );
    return Image.asset(
      Utils.getImgPath('monkey_d_luffy', format: 'jpg'),
      width: width ?? 100,
      height: height ?? 100,
      fit: BoxFit.cover,
    );
  }

  buildRowAvatar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ClipRect(
            child: buildImage(width: 80, height: 80),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Opacity(opacity: 0.5, child: buildImage()),
          ),
        ),
        ClipOval(
          child: buildImage(),
        ),
      ],
    );
  }

  buildPageViewItem(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  void openPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Center(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Next page'),
            ),
            body: const Center(
              child: Text(
                'This is the next page',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      },
    ));
  }

  buildChip(String label) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Colors.lightBlue.shade800,
        child: Text(
          label.substring(0, 1),
          style: TextStyle(fontSize: 10),
        ),
      ),
      label: new Text(label),
    );
  }
}
