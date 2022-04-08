import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef StringCallback = void Function(String imagePath);

class PickedImage extends StatefulWidget {
  final StringCallback onImagePicked;

  PickedImage({
    required this.onImagePicked,
    Key? key,
  }) : super(key: key);

  @override
  State<PickedImage> createState() => _PickedImageState();
}

class _PickedImageState extends State<PickedImage> {
  File? _cachedImage;
  File? _storedImage;

//choose image to add to the task
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _cachedImage = File(imageFile.path);
    });
    final appDirectory = await syspath.getApplicationDocumentsDirectory();
    final fileNeme = path.basename(imageFile.path);
    _storedImage =
        await File(imageFile.path).copy('${appDirectory.path}/$fileNeme');

    widget.onImagePicked(_storedImage!.path);
  }

//delete added image
  Future<void> deleteImage() async {
    await _storedImage!.delete().then((_) async {
      await _cachedImage!.delete();
    }).then((value) {
      _storedImage = null;
      _cachedImage = null;
    });
    widget.onImagePicked('');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_storedImage != null)
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.file(
                _storedImage!,
                width: 150,
                height: 150,
              ),
              Positioned(
                top: -15,
                right: 3,
                child: CircleAvatar(
                  radius: 15,
                  child: IconButton(
                      onPressed: () async {
                        await deleteImage();
                      },
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      iconSize: 18),
                ),
              ),
            ],
          ),
        TextButton(
          onPressed: () async {
            await _pickImage();
          },
          child: Text(
            _storedImage == null
                ? AppLocalizations.of(context)!.setimage
                : AppLocalizations.of(context)!.changeimage,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
