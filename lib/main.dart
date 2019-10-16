import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter windows Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Map>>(builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return Scrollbar(
            child: ListView.builder(itemBuilder: (context, index) {
              final Map item = data[index]; 
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        final route = MaterialPageRoute(builder: (context) => Item(
                            map: item,
                        ));
                        Navigator.of(context).push(route);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item['作物名稱'], style: Theme.of(context).textTheme.title),
                          Text(item['交易日期']),
                          Text(item['作物代號']),
                          Row(
                            children: <Widget>[
                              Expanded(flex:1, child: Center(child: Text('${item['上價']}'))),
                              Expanded(flex:1, child: Center(child: Text('${item['中價']}'))),
                              Expanded(flex:1, child: Center(child: Text('${item['下價']}'))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
                itemCount: data.length
            ),
          );
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          return Center(child: Text('Error $error'));
        } else {
          //  還在抓 -> 轉轉轉
          return Center(child: CupertinoActivityIndicator());
        }
      },
        future: fetchData(),
      ),
    );
  }
}
