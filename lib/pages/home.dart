import 'package:flutter/material.dart';
import 'package:weplayball/service/auth/auth_provider.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';

class HomePage extends StatelessWidget {
  HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(getColourHexFromString(primaryWhiteGrey)),
        appBar: AppBar(
          title: Text('Welcome'),
          actions: <Widget>[
            FlatButton(
                child: Text('Logout',
                    style: TextStyle(fontSize: 17.0, color: Colors.black)),
                onPressed: () => _signOut(context))
          ],
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 250.0,
                      width: double.infinity,
                      color: Color(getColourHexFromString(primaryOrange)),
                    ),
                    //  Create our bubble effect
                    //  Control where the child of a stack is created
                    Positioned(
                      // bottom margin
                      bottom: 50.0,
                      //  right margin
                      right: 100.0,
                      child: Container(
                        height: 400.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: Color(getColourHexFromString("#FFFFFF")).withOpacity(0.2),

                        ),
                      ),
                    ),
                    Positioned(
                      // bottom margin
                      bottom: 100.0,
                      //  right margin
                      left: 150.0,
                      child: Container(
                        height: 300.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: Color(getColourHexFromString("#FFFFFF")).withOpacity(0.2),

                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //  add some padding
                        addSizedBoxPadding(15.0, 0),
                        Row(
                          children: <Widget>[
                            //  add some padding
                            SizedBox( width: 15.0,),
                            Container(
                              alignment: Alignment.topLeft,
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border:Border.all(color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                image: DecorationImage(
                                  image: AssetImage('graphics/profile.png'),
                                ),
                              ),
                            ),
                            //  add some padding
                            SizedBox(width: MediaQuery.of(context).size.width - 120.0,),
                            Container(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(Icons.menu),
                                //  TODO
                                onPressed: (){},
                                color: Colors.white,
                                iconSize: 30.0,
                              ),
                            )
                          ],
                        ),
                        //  add some padding
                        addSizedBoxPadding(50.0, 0),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                              'Hello Michiel!',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Color(getColourHexFromString(primaryBlack)),
                              )
                          ),
                        ),
                        //  add some padding
                        addSizedBoxPadding(15.0, 0),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                              'What do you want to buy?',
                              style: TextStyle(
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold,
                                color: Color(getColourHexFromString(primaryBlack)),
                              )
                          ),
                        ),
                        //  add some padding
                        addSizedBoxPadding(25.0, 0),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(5.0),
                            child: TextFormField(
                              decoration:InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(getColourHexFromString(primaryOrange),
                                  ),
                                  size: 30.0,
                                ),
                                contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //  add some padding
                        addSizedBoxPadding(10.0, 0),
                      ],
                    )
                  ],
                ),

                //  add some padding
                addSizedBoxPadding(10.0, 0),
                Stack(
                  children: <Widget>[
                    addSizedBoxPadding(10.0, 0),
                    Material(
                      elevation: 0.75,
                      child: Container(
                        height: 75.0,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 75.0,
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('graphics/basketball-icon.png'),
                                  ),
                                ),
                              ),
                              Text(
                                'Division 1',
                                style: TextStyle(
                                  color: Color(getColourHexFromString(primaryBlack)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //  Item 2
                        Container(
                          height: 75.0,
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('graphics/basketball-icon.png'),
                                  ),
                                ),
                              ),
                              Text(
                                'Division 2',
                                style: TextStyle(
                                  color: Color(getColourHexFromString(primaryBlack)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //  Item 3
                        Container(
                          height: 75.0,
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('graphics/basketball-icon.png'),
                                  ),
                                ),
                              ),
                              Text(
                                'Division 3',
                                style: TextStyle(
                                  color: Color(getColourHexFromString(primaryBlack)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),


              ],
            ),
          ],
        )
    );
  }
}