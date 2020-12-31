import 'dart:typed_data';
import 'package:bg_remover/Models/generator.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:io' as IO;
import 'package:image/image.dart' as image2;
//import 'dart:js' as js;

//import 'dart:convert'; 
//import 'dart:typed_data';
//import 'dart:html';
//import 'package:http/http.dart' as http;
//import 'package:http_parser/http_parser.dart';

import 'loading.dart';

class BackgroundRemover extends StatefulWidget {
  @override
  _BackgroundRemoverState createState() => _BackgroundRemoverState();
}

class _BackgroundRemoverState extends State<BackgroundRemover> {
  // variable to hold image to be displayed 
  bool loading = false;

  Uint8List uploadedImage;
  Uint8List newImage;
  IO.File image;
  String error = '';
  //method to load image and update `uploadedImage`


  _startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader =  FileReader();
        reader.onLoadEnd.listen((e) {
                    setState(() {
                      uploadedImage = reader.result;
                      //image = new IO.File('imageToProcess.png')..writeAsBytesSync(image2.encodePng(reader.result));
                    });
                    /* setState(() {
                      image = new IO.File('imageToProcess.png')..writeAsBytesSync(image2.encodePng(reader.result));                      
                    }); */
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            error = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Height (without SafeArea)
    var padding = MediaQuery.of(context).padding;
    //double height1 = height - padding.top - padding.bottom;

    // Height (without status bar)
    //double height2 = height - padding.top;

    // Height (without status and toolbar)
    double height3 = height - padding.top - kToolbarHeight;

    

    return loading ? Loading() : Container(
      width: width,
      height: height3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Spacer(),
          Container(
            //height: height3,
            //width: 400,
            child: uploadedImage != null? Image.memory(uploadedImage) : Container(decoration: BoxDecoration(color: Colors.red),),
          ),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () async {
                  _startFilePicker();
                  print('magen cargada');
                },
                child: Text('Subir imagen'),
              ),
              SizedBox(height: 30,),
              RaisedButton(
                onPressed: () async {
                  setState(() async {
                    //js.context.callMethod("alert", <String>["starting request"]);
                    setState(() => loading = true);
                    //SRWGeneratorOnline genOnline = SRWGeneratorOnline(image: uploadedImage, modelConfig: '0000');
                    newImage = await SRWGeneratorOnline.removeBG('0000', uploadedImage);
                    setState(() => loading = false);       
                    //js.context.callMethod("alert", <String>["image generated"]);
                  });

                  
                  /* try{
                    
                    //newImage = await genOnline.generate2xImage();
                  } on Error {
                    //setState(() => loading = false);
                    //setState(() => error = true);
                    print('Error');
                    js.context.callMethod("alert", <String>["Error"]);
                  } on Exception{
                    //setState(() => imageError = true);
                    print('Exeption');
                    js.context.callMethod("alert", <String>["Exeption"]);
                  } */
                },

                child: Text('Procesar'),
              ),
            ],
          ),
          Container(
            //height: height3,
            //width: 400,
            child: newImage != null? Image.memory(newImage) : Container(decoration: BoxDecoration(color: Colors.red),),
          ),
          //Spacer(),
        ],
      ),
    );
  }
}
