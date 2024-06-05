import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:od_app/home.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  late File _image ;
  late List _output ;
  final picker = ImagePicker();


  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {

      }); //buoc tiep theo sau khi load duoc model len
    });
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults:2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5,
      asynch:true,
    );
    if(output == null) {
    print("checkkkkkkkkk");
    } else print("Trueeee");
    print(output);//detect tranfer to a image
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  } //buoc dau tien la phai load model len



  pickImage() async {
    var image = await picker.getImage(source : ImageSource.camera);
    if(image == null) {
      return null;
    } else {
      setState(() {
        _image = File(image.path);
      });
      detectImage(_image);
    }
  }


  pickGalleryImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if(image != null) {
      print("hehesss");
      setState(() {
        _image = File(image.path);
      });
      print(image.path);
      detectImage(_image);
      print('hehehe');
    } else {
      print('No image selected.');
      return null;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hehe'),
      ),
      backgroundColor: Colors.blue,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 50,),
          Text('Coding Cafe',
          style: TextStyle(color: Color(0x7D9E9E),
          fontSize: 20),
      ),
        SizedBox(height: 5),
        Text('Cat and Dog',style:
    TextStyle(color: Color(0x004241),
    fontWeight: FontWeight.w500,fontSize: 30)),
    SizedBox(height: 50),

      Center(child: _loading ?
      Container(
        width: 400,
         child: Column(children: <Widget>[
           SizedBox(height: 250,),
      ],),
      ) : Container(
        child : Column(children: <Widget>[
          Container(
            height: 300,
           child : Image.file(_image),
           ),
           SizedBox(height : 20),
           _output != null
               ? Text(
               '${_output[0]['label']}',
                  style : TextStyle(
                   color : Colors.red,
                   fontSize: 16,
               ),
           ) : Container(),
           SizedBox(height: 50)
         ],),
      )
      ),
      Container(
        width: MediaQuery.of(context).size.width,
      child: Column(children:<Widget>[
        GestureDetector(
          onTap: () {
            pickGalleryImage();
          },
        child : Container(
          width: MediaQuery.of(context).size.width - 250,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(6)),
          child: Text(
            'Capture Photo',
            style: TextStyle(color: Colors.white,fontSize: 16),
          ),
        ),
        ) ,
        SizedBox(height : 5),

        GestureDetector(
          onTap: () {
            pickGalleryImage();
          },
          child : Container(
            width: MediaQuery.of(context).size.width - 250,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Select Photofff',
              style: TextStyle(color: Colors.red,fontSize: 15),
            ),
          ),
        ),
        SizedBox(height : 20),
      ],),
      ),
    ],
      ),
    )
    );
  }
}
