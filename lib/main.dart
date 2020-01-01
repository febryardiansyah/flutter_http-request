import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp>{
  final String url ='https://api.banghasan.com/quran/format/json/surat';
  List data;

  Future<String> getData() async {
    var res = await http.get(Uri.encodeFull(url), headers:{'accept':'application/json'});

    setState(() {
      var content = json.decode(res.body);
      data = content['hasil'];
    });
    return 'success!';
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Alquran',
      home: Scaffold(
        appBar: AppBar(title: Text('Surat List'),),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: data == null ? 0:data.length,
            itemBuilder: (BuildContext context, int i){
              return Container(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Text(data[i]['nomor'], style: TextStyle(fontSize: 30.0),),
                        title: Text(data[i]['nama'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Arti : ',style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[i]['arti'], style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Jumlah Ayat : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[i]['ayat'])
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Diturunkan : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[i]['type'])
                              ],
                            ),
                          ],
                        ),
                      ),
                      // ignore: deprecated_member_use
                      ButtonTheme.bar(
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: Text('Lihat Detail'),
                              onPressed: (){},
                            ),
                            FlatButton(
                              child: Text('Dengarkan'),
                              onPressed: (){},
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }

}

