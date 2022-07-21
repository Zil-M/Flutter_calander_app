import 'dart:io';
import 'package:flutter_calander_app/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCalanderPage extends StatefulWidget {
  @override
  State<AddCalanderPage> createState() => _AddCalanderPageState();
}

class _AddCalanderPageState extends State<AddCalanderPage> {
  final _nameController = TextEditingController();
  File? _pickedImage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '무엇을 기록할까요?',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: largeSpace),
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    child: CupertinoButton(
                      padding: _pickedImage == null ? null : EdgeInsets.zero,
                      onPressed: () {
                        ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then((xfile) {
                          if (xfile == null) return;
                          setState(() {
                            _pickedImage = File(xfile.path);
                          });
                        });
                      },
                      child: _pickedImage == null
                          ? const Icon(
                              CupertinoIcons.photo_camera_solid,
                              size: 30,
                              color: Colors.white,
                            )
                          : CircleAvatar(
                              foregroundImage: FileImage(_pickedImage!),
                              radius: 40,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: largeSpace + regularSpace),
                Text(
                  '일정 제목',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                TextFormField(
                  controller: _nameController,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    hintText: '기록할 일정 제목을 입력해주세요.',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                    contentPadding: textFieldContentPadding,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonBoxPadding,
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.subtitle1,
              ),
              child: const Text('다음'),
            ),
          ),
        ),
      ),
    );
  }
}

class CalanderImageButton extends StatefulWidget {
  const CalanderImageButton({Key? key}) : super(key: key);

  @override
  State<CalanderImageButton> createState() => _CalanderImageButtonState();
}

class _CalanderImageButtonState extends State<CalanderImageButton> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      child: CupertinoButton(
        onPressed: _showBottomSheet,
        padding: _pickedImage == null ? null : EdgeInsets.zero,
        child: _pickedImage == null
            ? const Icon(
                CupertinoIcons.photo_camera_solid,
                size: 30,
                color: Colors.white,
              )
            : CircleAvatar(
                foregroundImage: FileImage(_pickedImage!),
                radius: 40,
              ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return PickImageBottomSheet(
          onPressedCamera: () => _onPressed(ImageSource.camera),
          onPressedGallery: () => _onPressed(ImageSource.gallery),
        );
      },
    );
  }

  void _onPressed(ImageSource source) {
    ImagePicker().pickImage(source: source).then((xfile) {
      if (xfile != null) {
        setState(() {
          _pickedImage = File(xfile.path);
        });
      }
      Navigator.maybePop(context);
    });
  }
}

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet(
      {Key? key, required this.onPressedCamera, required this.onPressedGallery})
      : super(key: key);

  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: onPressedCamera,
              child: const Text('카메라로 촬영'),
            ),
            TextButton(
              onPressed: onPressedGallery,
              child: const Text('앨범에서 가져오기'),
            ),
          ],
        ),
      ),
    );
  }
}
