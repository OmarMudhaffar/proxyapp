import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List proxys = [];
var showdata = false;

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    // TODO: implement initState

    getProxys().then( (data){
     setState(() {
       showdata = true;
       proxys = data;
     });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
leading: IconButton(icon: Icon(Icons.person_add),onPressed: (){
UrlLauncher.launch("https://t.me/developer_vip");
},),
        backgroundColor: Colors.green,
        title: Text("Telegran Proxy"),
        centerTitle: true,
      ),

      body: showdata ? ListView.builder(itemBuilder: (BuildContext context,int pos){
        return Proxy(proxys[pos]["host"],proxys[pos]["ping"],"omar");
      },itemCount: proxys.length,) : Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      )
    );
  }
}


class Proxy extends StatelessWidget {

  final String title;
  final String sub;
  final String url;

  Proxy(this.title,this.sub,this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))
      ),
      child: ListTile(
        onTap: (){
          UrlLauncher.launch(url);
        },
        trailing: IconButton(icon: Icon(Icons.verified_user),color: Colors.lightBlueAccent,onPressed: (){

        },),
        leading: Container(
          alignment: Alignment.center,
          width: 20.0,
          height: 50.0,
child: Icon(Icons.whatshot,color: Colors.deepOrangeAccent,),
        ),
        title: Text(title),
        subtitle: Row(
          children: <Widget>[
            Text("ping : "),
            Text(sub,style: TextStyle(color: Colors.blueGrey),)
          ],
        ),
      ),
    );
  }
}


getProxys() async {
  var url = "http://api.lgast.com/proxy";
  http.Response httpRes = await http.get(url);

  return json.decode(httpRes.body);

}
