import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ibc24/dbhelper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ibc24/common/global.dart' as global;

class Hrpolicies extends StatefulWidget {
  @override
  _HrpoliciesState createState() => _HrpoliciesState();
}

class _HrpoliciesState extends State<Hrpolicies> {
  final dbhelper = Databasehelper.instance;
  bool loader = false;
  List Hrpolicies;

  void Hr_policy() async{
    setState(() {
      loader = true;
    });
    List <dynamic> userdetail = await dbhelper.get(1);
    String url = global.baseUrl + "/Policies_ctrl/hr_policies";
    Map<String, String> headers = {"Content-type": "application/json","ibckey":userdetail[0]['key']};
    http.Response response = await http.get(url, headers: headers);
    int statusCode = response.statusCode;
    if(statusCode == 200) {
      Hrpolicies = jsonDecode(response.body);
      setState(() {
        loader = false;
      });
    } else {
      setState(() {
        loader = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hr_policy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HR POLICIES'),
        backgroundColor: Colors.red[500],
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right:20.0) ,
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/livetv');
              },
              child: Icon(
                Icons.live_tv,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: loader?Container(
        padding: EdgeInsets.all(70.0),
        child : Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 15.0,),
            Text('  Loading...',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold,),),
          ],
        ),
        ),
      ):ListView.builder(
          itemCount: Hrpolicies.length,
          itemBuilder: (BuildContext context,int index){
            return Card(
              elevation: 5.0,
              child: ListTile(
                trailing: Icon(Icons.file_download),
                title: Text(Hrpolicies[index]['title']),
                subtitle: Text(Hrpolicies[index]['title'].toLowerCase()),
                onTap: (){},
              ),
            );
          },
      ),
    );
  }
}
