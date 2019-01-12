import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

var picture = Image(
    image: AssetImage("assets/male-avatar.jpg"), width: 200.0, height: 200.0);

class ImageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImageWidgetState();
}

class ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
            icon: picture,
            iconSize: 200,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("Image source"),
                    content: new Text("Select an image source"),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        child: new Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      new FlatButton(
                          child: new Text("Camera"),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            var img = Image.file(await ImagePicker.pickImage(
                                source: ImageSource.camera));
                            setState(() {
                              if (img != null) picture = img;
                            });
                          }),
                      new FlatButton(
                        child: new Text("Gallery"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          var img = Image.file(await ImagePicker.pickImage(
                              source: ImageSource.gallery));
                          setState(() {
                            if (img != null) picture = img;
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            }));
  }
}
