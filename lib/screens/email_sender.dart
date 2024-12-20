import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red),
      home: EmailSender(),
    );
  }
}

class EmailSender extends StatefulWidget {
  const EmailSender({Key? key}) : super(key: key);

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  List<String> attachments = [];
  bool isHTML = false;
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  final _recipientController = TextEditingController(
    text: 'donate@shufimafi.com',
  );

  final _subjectController = TextEditingController(text: 'Donation');

  final _bodyController = TextEditingController(
    text: 'Tell us about your donation',
  );

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 255, 115, 0),
        ),
        backgroundColor: Colors.white,
        title: Text('Donate', style: TextStyle(color: mainColor)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: Icon(Icons.send),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _recipientController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Subject',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      labelStyle: TextStyle(color: mainColor),
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            // CheckboxListTile(
            //   contentPadding:
            //       EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            //   title: Text('HTML'),
            //   onChanged: (bool? value) {
            //     if (value != null) {
            //       setState(() {
            //         isHTML = value;
            //       });
            //     }
            //   },
            //   value: isHTML,
            // ),
            // Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Column(
            //     children: <Widget>[
            //       for (var i = 0; i < attachments.length; i++)
            //         Row(
            //           children: <Widget>[
            //             Expanded(
            //               child: Text(
            //                 attachments[i],
            //                 softWrap: false,
            //                 overflow: TextOverflow.fade,
            //               ),
            //             ),
            //             IconButton(
            //               icon: Icon(Icons.remove_circle),
            //               onPressed: () => {_removeAttachment(i)},
            //             )
            //           ],
            //         ),
            //       Align(
            //         alignment: Alignment.centerRight,
            //         child: IconButton(
            //           icon: Icon(Icons.attach_file),
            //           onPressed: _openImagePicker,
            //         ),
            //       ),
            //       TextButton(
            //         child: Text('Attach file in app documents directory'),
            //         onPressed: () => _attachFileFromAppDocumentsDirectoy(),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    PickedFile? pick = await picker.getImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachments.add(pick.path);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  Future<void> _attachFileFromAppDocumentsDirectoy() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final filePath = appDocumentDir.path + '/file.txt';
      final file = File(filePath);
      await file.writeAsString('Text file in app directory');

      setState(() {
        attachments.add(filePath);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create file in applicion directory'),
        ),
      );
    }
  }
}
