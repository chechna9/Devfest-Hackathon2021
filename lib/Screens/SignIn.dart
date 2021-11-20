import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({ Key? key }) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  late TextEditingController _controller;

    @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

    @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFF1597E5),
            flexibleSpace: SafeArea(child: Container(
              margin:  EdgeInsets.symmetric(vertical: 10 ,horizontal: 10),
              child: 
                Padding(
                  padding: EdgeInsets.only(top : 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Image(image: AssetImage("images/DF-logo-dark.png"),width: 60,height: 60,),),
                      Text("BrAIns",
                          style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight : FontWeight.w600,
                                  fontSize: 24)
                      ),
                      ],
                     ),
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child : Container(
          color: Color(0xFF1597E5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Expanded(child: Container(
                  margin: EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 15) ,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
                  ),
                  child:  Center(child:
                     SingleChildScrollView(
                       child: Column(         
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text("Registre", style: TextStyle(color: Color(0xFF1597E5),fontWeight: FontWeight.bold , fontSize: 24),),
                            SizedBox(height: 50,),
                             Padding(padding:EdgeInsets.symmetric(vertical: 0,horizontal : 25 ),
                             child:  TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Address Email or phone number',
                              ),
                            ),),        
                            SizedBox(height: 25,),
                            Padding(padding:EdgeInsets.symmetric(vertical: 0,horizontal : 25 ),
                             child:  TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'user name',
                              ),
                            ),),
                            SizedBox(height: 25,),
                            Padding(padding:EdgeInsets.symmetric(vertical: 0,horizontal : 25 ),
                             child:  TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'password',
                              ),
                            ),),  
                            SizedBox(height: 25,),  
                               Padding(padding:EdgeInsets.symmetric(vertical: 0,horizontal : 25 ),
                             child:  TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "confirm password",
                              ),
                            ),),      
                            SizedBox(height: 25,),
                            Container(child: Text("Registre",style: TextStyle(
                              color: Colors.white ,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                            ),),
                                padding: EdgeInsets.symmetric(vertical: 13,horizontal: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF1597E5)
                                ),),
                              SizedBox(height: 40,),
                             Container(child: Text("you have already an acount",style: TextStyle(
                               color: Color(0xFF1597E5),
                               fontWeight: FontWeight.w500,
                               fontSize: 14
                             ),),),
                           ],),
                          ),) 
                        ,),),
                    
          ],),
        ),
      ),),
    );
  }
}