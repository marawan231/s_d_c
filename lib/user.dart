import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:self_d_c/loginPage.dart';
import 'package:self_d_c/secondhome.dart';
import 'package:self_d_c/homescreen.dart';
import 'package:self_d_c/createQRcode.dart';
import 'package:self_d_c/mainQR.dart';
import 'Register.dart';
import 'package:self_d_c/mainlist.dart';

class user extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading:
              IconButton(onPressed: () {}, icon: Icon(Icons.view_headline)),
          backgroundColor: Colors.teal,
          title: Text("Self Deriven Car "),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ),
        backgroundColor: Colors.grey[200],
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Material(
              elevation: 15,
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: "logo",
                child: Padding(
                  padding: EdgeInsets.only(left: 70, right: 70, top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage("images/pointer.jpg"),
                          fit: BoxFit.cover,
                        )),
                    height: 320,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 9, bottom: 9, right: 9),
                child: Text(
                  "Welcome To Our Application ....!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                )),
            SizedBox(
              height: 20,
            ),

            /*/ Padding(
                padding: EdgeInsets.only(left: 60,right: 60),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child:  MaterialButton(

                    minWidth:MediaQuery.of(context).size.width/2,
                    height: 55,
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    child: Text("Employee",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Loginemployees();
                      },

                      ),
                      );
                    }
    )
    ),
              ),*/

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 60, right: 60),
              child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 52,
                  color: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Start",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return homescreen();
                        },
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
