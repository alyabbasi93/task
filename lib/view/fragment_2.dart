import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/model/AlbumModel.dart';
import 'package:http/http.dart' as http;

class Fragment2 extends StatefulWidget {
  Fragment2({Key key}) : super(key: key);

  @override
  _Fragment2State createState() => _Fragment2State();
}

bool _loading;

class _Fragment2State extends State<Fragment2> {
  List<AlbumModel> _users;

  /*                                          Service                                       */
  static Future<List<AlbumModel>> _fetchData() async {
    try {
      final response = await http.get(
          "https://jsonplaceholder.typicode.com/albums/1/photos",
          headers: {'Accept': 'application/json'});
      if (200 == response.statusCode) {
        // print(response.body);
        final List<AlbumModel> users = albumModelFromJson(response.body);
        return users;
      } else {
        return List<AlbumModel>();
      }
    } catch (e) {
      return List<AlbumModel>();
    }
  }
  /*                                          Service                                       */

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    _fetchData().then((users) {
      setState(() {
        _users = users;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()))
          : Container(
              child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (BuildContext context, int index) {
                    AlbumModel Album = _users[index];
                    return Container(
                        margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(Album.url),
                                fit: BoxFit.cover)),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: CachedNetworkImage(
                                      imageUrl: Album.thumbnailUrl,
                                      height: 50,
                                      width: 50,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.white),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Expanded(
                                  child: Container(),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Container(
                              height: 89,
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          Album.title,
                                          style: GoogleFonts.raleway(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ));
                  }),
            ),
    );
  }
}
