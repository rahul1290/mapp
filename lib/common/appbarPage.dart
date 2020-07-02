import 'package:flutter/material.dart';

class AppbarPage extends StatefulWidget {
  @override
  _AppbarPageState createState() => _AppbarPageState();
}

class _AppbarPageState extends State<AppbarPage> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: Text('IBC24'),
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
        );
    }
}
