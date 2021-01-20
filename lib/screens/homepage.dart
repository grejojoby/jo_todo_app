import 'package:flutter/material.dart';
import 'package:jo_todo/database_helper.dart';
import 'package:jo_todo/screens/taskpage.dart';
import 'package:jo_todo/widgets.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new Homepage(),
      title: new Text(
        'Jo ToDo',
        textScaleFactor: 2,
      ),
      image: Image(
        image: AssetImage('assets/images/logo.png'),
      ),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          color: Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 32.0,
                          bottom: 32.0,
                        ),
                        child: Image(
                          image: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 24.0),
                        child: Text("Jo Todo",
                            style: TextStyle(
                              color: Color(0xFF211551),
                              fontSize: 40.0,
                              fontWeight: FontWeight.w900,
                            )),
                      ),
                    ],
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Taskpage(
                                        task: snapshot.data[index],
                                      ),
                                    ),
                                  ).then(
                                    (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data[index].title,
                                  desc: snapshot.data[index].description,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Taskpage(
                                task: null,
                              )),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF7349FE), Color(0xFF643FDB)],
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 1.0)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Image(
                      image: AssetImage(
                        "assets/images/add_icon.png",
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
