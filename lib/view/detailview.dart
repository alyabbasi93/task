import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detailview extends StatefulWidget {
  final image;
  final title;
  final url;

  Detailview({Key key, this.image, this.title, this.url}) : super(key: key);
  @override
  _DetailviewState createState() => _DetailviewState(image, title, url);
}

class _DetailviewState extends State<Detailview>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var image;
  var title;
  var url;
  _DetailviewState(this.image, this.title, this.url);

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Detail',
            textAlign: TextAlign.center,
            style: GoogleFonts.russoOne(color: Colors.red, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: image,
                        height: 50,
                        width: 50,
                        imageBuilder: (context, imageProvider) => Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 300,
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Image.network(
                  url,
                  height: 600,
                  width: 600,
                )
              ],
            ),
          ),
        ));
  }
}
