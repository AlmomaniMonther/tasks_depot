import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final String _founderEmail = 'malmomani29.ru@gmail.com';
  TextEditingController feedbackBody = TextEditingController();
  String _feedback = '';
  TextEditingController senderEmail = TextEditingController();
  TextEditingController subject = TextEditingController();
  String? _imagePath;

  //choose screenshot to attach to the feedback email
  void _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final _xImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (_xImage != null) {
      setState(() {
        _imagePath = _xImage.path;
      });
    } else {
      _imagePath = null;
    }
  }

  //send feedback email
  void sendEmail() async {
    final mail = Email(
        recipients: ['malmomani29.ru@gmail.com'],
        body:
            '${AppLocalizations.of(context)!.from} ${senderEmail.text} \n$_feedback',
        attachmentPaths: _imagePath == null ? null : [_imagePath!],
        subject: subject.text.isEmpty
            ? AppLocalizations.of(context)!.nosubject
            : subject.text,
        isHTML: false);

    await FlutterEmailSender.send(mail);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 14, 114, 228),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Text(AppLocalizations.of(context)!.feedback1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.feedback2),
        actions: [
          IconButton(onPressed: sendEmail, icon: const Icon(Icons.send))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 41, 132, 155),
          Color.fromARGB(255, 129, 179, 255),
          Color.fromARGB(255, 173, 173, 173)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                //user email
                TextFormField(
                  controller: senderEmail,
                  autovalidateMode: AutovalidateMode.always,
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    String pattern =
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?)*$";
                    RegExp regex = RegExp(pattern);
                    if (value == null ||
                        value.isEmpty ||
                        !regex.hasMatch(value.trim())) {
                      return AppLocalizations.of(context)!.email1;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    label: const Text("Email"),
                    hintText: AppLocalizations.of(context)!.email2,
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.white),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //developer email
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: _founderEmail,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.white),
                    label: Text(AppLocalizations.of(context)!.to),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //subject
                TextFormField(
                  controller: subject,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.white),
                    label: Text(AppLocalizations.of(context)!.subject),
                    hintText: AppLocalizations.of(context)!.entersubject,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //feedback text
                TextFormField(
                  maxLines: 15,
                  style: const TextStyle(fontSize: 20),
                  controller: feedbackBody,
                  onChanged: (value) {
                    setState(() {
                      _feedback = value;
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.feedback3,
                    filled: true,
                    fillColor: Colors.white60,
                    contentPadding: const EdgeInsets.all(20.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //attach screenshot
                Row(
                  mainAxisAlignment: _imagePath != null
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.end,
                  children: [
                    if (_imagePath != null)
                      Container(
                        height: MediaQuery.of(context).size.width * 1 / 3,
                        width: MediaQuery.of(context).size.width * 1 / 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Image.file(
                          File(_imagePath!),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(
                        Icons.attach_file,
                      ),
                      label: Text(AppLocalizations.of(context)!.screenshot),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
