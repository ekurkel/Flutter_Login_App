import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String picturePath = "assets/male-avatar.jpg";

class ImageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImageWidgetState();
}

class ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
            iconSize: 200,
            icon: CircleAvatar(backgroundImage: AssetImage(picturePath), radius: 100,),
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
                            var img = await ImagePicker.pickImage(
                                source: ImageSource.camera, maxWidth: 200, maxHeight: 200);
                            setState(() {
                              if (img != null) picturePath = img.path;
                            });
                          }),
                      new FlatButton(
                        child: new Text("Gallery"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          var img = await ImagePicker.pickImage(
                              source: ImageSource.gallery,  maxWidth: 200, maxHeight: 200);
                          setState(() {
                            if (img != null) picturePath = img.path;
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
