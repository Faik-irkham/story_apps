import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/provider/credential_provider.dart';
import 'package:story_apps/provider/story_provider.dart';
import 'package:story_apps/utils/response_state.dart';
import 'package:story_apps/widgets/button_widget.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  File? _imageFile;
  final picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      int fileSizeInBytes = imageFile.lengthSync();
      double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
      if (fileSizeInMb <= 2) {
        setState(() {
          _imageFile = imageFile;
        });
      } else {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('The selected image exceeds 2MB.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // ignore: avoid_print
      print('No image selected.');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () {
      Provider.of<StoryProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final credProvider =
        Provider.of<CredentialProvider>(context, listen: false);
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.mirror,
                  colors: [
                    Color(0X6612111F),
                    Color(0XCC12111F),
                    Color(0X9912111F),
                    Color(0XFF12111F),
                  ],
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 60),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Choose from Gallery'),
                                  onTap: () {
                                    getImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Take a Picture'),
                                  onTap: () {
                                    getImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: _imageFile == null
                        ? Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[300],
                            ),
                            child: const Icon(
                              Icons.image,
                              size: 100,
                              color: Colors.grey,
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: FileImage(_imageFile!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer<StoryProvider>(
                    builder: (context, storyProvider, _) {
                      return CustomFilledButton(
                        onPressed: () async {
                          if (_descriptionController.text.isNotEmpty &&
                              _imageFile != null) {
                            if (storyProvider.state == ResultState.error &&
                                context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('error'),
                                ),
                              );
                            }
                            final description = _descriptionController.text;
                            final token =
                                await credProvider.preferences.getToken();

                            final response = await storyProvider.postStory(
                              description: description,
                              imagePath: _imageFile!.path,
                              token: token,
                              lat: null,
                              lon: null,
                            );

                            if (response.error == false && context.mounted) {
                              storyProvider.refresh();
                              // context.goNamed('bottomNav');
                              context.goNamed('bottomNav');
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'An error occurred while uploading the story.'),
                              ),
                            );
                          }
                        },
                        child: storyProvider.state == ResultState.loading
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : const Text(
                                'Upload Story',
                                style: TextStyle(
                                  color: Color(0XFF12111F),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
