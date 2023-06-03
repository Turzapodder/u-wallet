import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uwallet/NID_info.dart';
import '../widgets/common_buttons.dart';
import 'package:uwallet/select_photo_options_screen.dart';

class SetPhotoScreen extends StatefulWidget {
  const SetPhotoScreen({super.key});

  static const id = 'set_photo_screen';

  @override
  State<SetPhotoScreen> createState() => _SetPhotoScreenState();
}

class _SetPhotoScreenState extends State<SetPhotoScreen> {
  File? _image;
  bool _showScanButton = false;

  Future<void> storeImagePath(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', imagePath);
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        _showScanButton = (_image != null);
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          leading: const BackButton(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            "Scan Your NID",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: Colors.black,
              fontFamily: 'Titillium Web',
            ),
          ),
          backgroundColor: Color(0xFFFFAE58),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28.0, bottom: 28.0, left: 10 , right: 10),
                child: Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _showSelectPhotoOptions(context);
                    },
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.grey.shade200,
                              ),
                              child: Center(
                                child: _image == null
                                    ? Image.asset('assets/images/img.png', fit: BoxFit.cover,)
                                    : Image.file(_image!,
                                    fit: BoxFit.cover, // Adjust the image's fit as per your requirement
                              ),
                              ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Position your document inside the frame. Make sure that all the data is clearly visible.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Titillium Web",
                              fontSize: 15,
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _showScanButton==true
                      ?CommonButtons(
                        onTap: () {
                          //storeImagePath(_image);
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PersonalInfoPage(nidImage: _image!,)),
                        );},
                        backgroundColor: Color(0xFFFFAE58),
                        textColor: Colors.white,
                        textLabel: 'Verify Information',
                      )
                    :CommonButtons(
                      onTap: () => _showSelectPhotoOptions(context),
                      backgroundColor: Color(0xFFFFAE58),
                      textColor: Colors.white,
                      textLabel: 'Scan Now',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
