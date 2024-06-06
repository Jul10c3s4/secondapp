import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:secondapp/shared/Custom_buttom.dart';
import 'package:secondapp/shared/custom_appbar.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker picker = ImagePicker();
  XFile? photo;

  void cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );
    if (croppedFile != null) {
      await GallerySaver.saveImage(croppedFile.path);
      photo = XFile(croppedFile.path);
      print("foto: $photo");
      print("path: ${photo!.path}");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "Camera Page"),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButtom(
                  title: CustomTitle.buildTitleButton(context, "Tirar foto"),
                  color: Colors.green,
                  onPressed: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Wrap(
                            children: [
                              ListTile(
                                leading: const FaIcon(FontAwesomeIcons.camera),
                                title: CustomTitle.buildSubTitle(
                                    context, "Camera"),
                                onTap: () async {
                                  photo = await picker.pickImage(
                                      source: ImageSource.camera);
                                  if (photo != null) {
                                    String path = (await path_provider
                                            .getApplicationDocumentsDirectory())
                                        .path;
                                    String name = basename(photo!.path);
                                    await photo!.saveTo("$path/$name");
                                    cropImage(photo!);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              ListTile(
                                leading: const FaIcon(FontAwesomeIcons.image),
                                title: CustomTitle.buildSubTitle(
                                    context, "galeria"),
                                onTap: () async {
                                  photo = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  cropImage(photo!);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const FaIcon(FontAwesomeIcons.video),
                                title: CustomTitle.buildSubTitle(
                                    context, "videos"),
                                onTap: () async {
                                  final XFile? galleryVideo = await picker
                                      .pickVideo(source: ImageSource.gallery);
                                },
                              ),
                            ],
                          );
                        });
                  }),
              const SizedBox(
                height: 10,
              ),
              photo != null
                  ? Image.file(
                      File(photo!.path),
                      height: 200,
                      width: 300,
                    )
                  : Container(
                      child: Image.file(
                        File(
                            "/data/user/0/com.juliocesar.bootcamp.secondapp/cache/image_cropper_1697940897359.jpg"),
                        height: 200,
                        width: 300,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
