import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uwallet/login_screen.dart';
import 'package:uwallet/welcome.dart';
import 'package:uwallet/welldone.dart';
import '../widgets/common_buttons.dart';
import 'package:uwallet/select_photo_options_screen.dart';

class SetProfilePhotoScreen extends StatefulWidget {
  const SetProfilePhotoScreen({super.key});

  static const id = 'set_photo_screen';

  @override
  State<SetProfilePhotoScreen> createState() => _SetProfilePhotoScreenState();
}

class _SetProfilePhotoScreenState extends State<SetProfilePhotoScreen> {
  File? _image;
  bool _showScanButton = false;

  Future<String> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userTypeKey') ?? "";
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
      builder: (context) =>
          DraggableScrollableSheet(
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
    return FutureBuilder<String>(
        future: getUserType(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            String userType = snapshot.data ?? "";
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.0),
                child: AppBar(
                  elevation: 0,
                  leading: const BackButton(
                    color: Colors.white,
                  ),
                  centerTitle: true,
                  title: Text(
                    "Face ID Verification",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 22,
                      color: Colors.white,
                      fontFamily: 'Titillium Web',
                    ),
                  ),
                  backgroundColor: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                ),
              ),
              body: Container(
                color: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                child: SafeArea(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(
                        left: 10, right: 10, bottom: 30, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: Text(
                                    'Please put your phone in front of your face',
                                    style: TextStyle(
                                      fontFamily: "Titillium Web",
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 28.0, right: 28.0),
                          child: Center(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                _showSelectPhotoOptions(context);
                              },
                              child: Center(
                                child: Container(
                                  height: 250.0,
                                  width: 250.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(
                                    child: _image == null
                                        ? Image.asset('assets/images/face2.png',
                                      fit: BoxFit.cover,)
                                        : CircleAvatar(
                                      backgroundImage: FileImage(_image!),
                                      radius: 250.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              _showScanButton == true
                                  ? CommonButtons(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Welldone()),
                                  );
                                },
                                backgroundColor: Colors.white,
                                textColor: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                                textLabel: 'Finish Registration',
                              ) : CommonButtons(
                                onTap: () => _showSelectPhotoOptions(context),
                                backgroundColor: Colors.white,
                                textColor: userType=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                                textLabel: 'Scan My Face',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        }
    );
  }
}

