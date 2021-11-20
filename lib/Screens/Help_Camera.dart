import 'package:brainsapp/main.dart';
import 'package:flutter/material.dart';

class HelpCamera extends StatelessWidget {
  const HelpCamera();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFF1597E5),
            flexibleSpace: SafeArea(child: Container(
              padding:  EdgeInsets.symmetric(vertical: 10 ,horizontal: 10),
              child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Image(image: AssetImage("images/DF-logo-dark.png"),width: 60,height: 60,),),
                    Text("BrEYEn",
                        style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight : FontWeight.w600,
                                fontSize: 26)
                    ),],
                   ),
              ),
            ),
          ),
        ),
        body: Center(
          child : Container(
            color: Color(0xFF1597E5),
            child : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : [
            Expanded(child :
            Center(child : Container(
              margin: EdgeInsets.only(top: 0 ,left: 15,right : 15,bottom  : 15),
              decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(20)
              ),
            child: Column(
              children: [
              
            SizedBox(height: 30,),
            Text("BrEYEn ",style: TextStyle(
                   color: Color(0xFF1597E5),
                   fontWeight : FontWeight.w600,
                   fontSize: 24)),
            SizedBox(height: 35,),
            // camera photo
            Container(
              decoration: BoxDecoration(border: Border(
                top: BorderSide(width: 2,color: Color(0xFF1597E5)),
                left: BorderSide(width: 2,color: Color(0xFF1597E5)),
                right: BorderSide(width: 2,color: Color(0xFF1597E5)),
                bottom: BorderSide(width: 2,color: Color(0xFF1597E5))
              ),
              borderRadius: BorderRadius.circular(10)),
              height: 270,
              width: 270,
            ),
            SizedBox(height: 30,),
            Container(
                width: 250,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child:  Text("Item detected .. ",
                   textAlign: TextAlign.start,
                   style: TextStyle(
                   fontSize: 14,
                   fontWeight: FontWeight.w400,
                   color: Colors.black54

               ),
               ),
               ),
              SizedBox(height: 5,),
            Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
               ),
               Container(
                  width: 250,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      top: BorderSide(width: 2,color: Color(0xFF1597E5)),
                      left: BorderSide(width: 2,color: Color(0xFF1597E5)),
                      right: BorderSide(width: 2,color: Color(0xFF1597E5)),
                      bottom: BorderSide(width: 2,color: Color(0xFF1597E5),)
                      ),
                  ),
                  child:  Text("chamso ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                    ),),),
            SizedBox(height: 7,),
             Container(
                  width: 250,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      top: BorderSide(width: 2,color: Color(0xFF1597E5)),
                      left: BorderSide(width: 2,color: Color(0xFF1597E5)),
                      right: BorderSide(width: 2,color: Color(0xFF1597E5)),
                      bottom: BorderSide(width: 2,color: Color(0xFF1597E5),)
                      ),
                  ),
                  child:  Text("chamso ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                    ),),),
               ],),),),),
              ]
            )
          )
      ),),
    );
  }
}
