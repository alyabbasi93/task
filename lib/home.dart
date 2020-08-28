import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/view/fragment_1.dart';
import 'package:task/view/fragment_2.dart';

import 'main.dart';

class Home extends StatefulWidget {
  const Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTabIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget drawable() {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            child: Text(
              'BEEDYO',
              textAlign: TextAlign.center,
              style: GoogleFonts.russoOne(color: Colors.red, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          new ListTile(
              leading: Icon(Icons.home),
              title: new Text("Map"),
              onTap: () {
                setState(() {
                  _changeIndex(0);
                });
                Navigator.pop(context);
              }),
          new ListTile(
            leading: Icon(Icons.note),
            title: new Text("List"),
            onTap: () {
              setState(() {
                _changeIndex(1);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _changeIndex(int index) async {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirstSeen();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      FeatureDiscovery.dismissAll(context);
    } else {
      prefs.setBool('seen', true);
      FeatureDiscovery.discoverFeatures(
        context,
        const <String>{
          feature2,
          feature3,
          feature4,
          feature5,
        },
      );
    }
  }

  var feature1OverflowMode = OverflowMode.clipContent;
  var feature1EnablePulsingAnimation = true;

  var feature3ItemCount = 15;

  @override
  Widget build(BuildContext context) {
    const icon1 = Icon(
      FontAwesome.bars,
      color: Colors.black,
    );
    const icon2 = Icon(
      Icons.search,
      color: Colors.black,
    );
    const icon3 = Icon(
      Icons.filter_list,
      color: Colors.black,
    );
    const icon4 = Icon(
      Icons.map,
      color: Colors.black,
    );
    const icon5 = Icon(
      Icons.location_on,
      color: Colors.black,
    );
    List _pages = [Fragment1(), Fragment2()];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: icon1,
            onPressed: () => _scaffoldKey.currentState
                .openDrawer()), //_scaffoldKey.currentState.openDrawer()),

        title: Center(
            child: Padding(
          padding: EdgeInsets.only(left: 60),
          child: Text(
            'BEEDYO',
            style: GoogleFonts.russoOne(color: Colors.red, fontSize: 20),
          ),
        )),
        actions: <Widget>[
          DescribedFeatureOverlay(
            featureId: feature2,
            tapTarget: icon2,
            backgroundColor: Colors.red,
            title: const Text('Search'),
            description: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                    'Search for any specific Pitch.Search can be perfomed using:'),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesome.dot_circle_o,
                      color: Colors.white,
                    ),
                    Text(' Pitch Title'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesome.dot_circle_o,
                      color: Colors.white,
                    ),
                    Text(' Creator Name'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesome.dot_circle_o,
                      color: Colors.white,
                    ),
                    Text(' Location'),
                  ],
                ),
              ],
            ),
            child: IconButton(
              icon: icon2,
              onPressed: () {},
            ),
          ),
          DescribedFeatureOverlay(
            featureId: feature3,
            tapTarget: icon3,
            backgroundColor: Colors.red,
            title: const Text('Filters'),
            description: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                    'Use the option to filter Pitches.Pitches can be filtered based on:'),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesome.dot_circle_o,
                      color: Colors.white,
                    ),
                    const Text(' Category'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesome.dot_circle_o,
                      color: Colors.white,
                    ),
                    const Text(' Rating'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesome.dot_circle_o,
                      color: Colors.white,
                    ),
                    const Text(' price'),
                  ],
                ),
              ],
            ),
            child: IconButton(
              icon: icon3,
              onPressed: () {},
            ),
          ),
          DescribedFeatureOverlay(
            featureId: feature4,
            tapTarget: icon4,
            backgroundColor: Colors.red,
            title: const Text('Switch View'),
            description: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Tap here to switch between'
                    'MapView'
                    ' And List view to view Pitches close to you'),
              ],
            ),
            child: IconButton(
              icon: icon4,
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: drawable(),
      body: Container(child: _pages[_selectedTabIndex]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) =>
                DescribedFeatureOverlay(
          featureId: feature5,
          tapTarget: icon5,
          backgroundColor: Colors.red,
          overflowMode: OverflowMode.extendBackground,
          title: const Text('Map Pins'),
          description: Column(children: <Widget>[
            const Text(
                'Each of these pins mark the location of a Pitch near you.Tapping on them will show you some basic information'),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                const Text(
                  'Pitch',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const Text(
                'A pitch can be a meet up a product launch,a knowledge sharing session.'),
          ]),
          child: FloatingActionButton(
            onPressed: () {},
            child: icon5,
          ),
        ),
      ),
    );
  }
}
