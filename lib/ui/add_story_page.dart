// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/build_variant/flavor_config.dart';
import 'package:story_apps/common/common.dart';
import 'package:story_apps/provider/credential_provider.dart';
import 'package:story_apps/provider/location_provider.dart';
import 'package:story_apps/provider/story_provider.dart';
import 'package:story_apps/utils/response_state.dart';
import 'package:story_apps/widgets/button_widget.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      int fileSizeInBytes = imageFile.lengthSync();
      double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
      if (fileSizeInMb <= 2) {
        Provider.of<LocationProvider>(context, listen: false).setImageFile(
            imageFile); // Mengatur gambar menggunakan LocationProvider
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('The selected image exceeds 2MB.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<StoryProvider>(context, listen: false);
    Provider.of<LocationProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
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
                                    GoRouter.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Take a Picture'),
                                  onTap: () {
                                    getImage(ImageSource.camera);
                                    GoRouter.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child:
                        Provider.of<LocationProvider>(context).imageFile == null
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
                                    image: FileImage(
                                        Provider.of<LocationProvider>(context)
                                            .imageFile!),
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
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.deskripsiUpload,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FlavorConfig.instance.flavor == FlavorType.paid
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<LocationProvider>(
                              builder: (context, locationProvider, _) {
                                return TextButton(
                                  onPressed: () {
                                    context.goNamed('map_pick');
                                  },
                                  child: Text(
                                    locationProvider.selectedLat == null ||
                                            locationProvider.selectedLon == null
                                        ? 'Add Location'
                                        : 'Location Added',
                                    style: TextStyle(
                                      color: locationProvider.selectedLat ==
                                                  null ||
                                              locationProvider.selectedLon ==
                                                  null
                                          ? Colors.white
                                          : Colors.green,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .deleteLocation();
                              },
                              icon: const Icon(Icons.clear),
                              color: Colors.white,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  if (Provider.of<LocationProvider>(context).selectedLat !=
                          null &&
                      Provider.of<LocationProvider>(context).selectedLon !=
                          null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Selected Location: ${Provider.of<LocationProvider>(context).selectedLat}, ${Provider.of<LocationProvider>(context).selectedLon}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Consumer3<StoryProvider, CredentialProvider,
                      LocationProvider>(
                    builder: (context, provider, cred, loc, _) {
                      return CustomFilledButton(
                        onPressed: () async {
                          final description = _descriptionController.text;
                          final imageFile = loc
                              .imageFile; // Mengambil gambar dari LocationProvider
                          final selectedLat = loc.selectedLat;
                          final selectedLon = loc.selectedLon;

                          if (description.isNotEmpty &&
                              imageFile != null &&
                              selectedLat != null &&
                              selectedLon != null) {
                            // Memeriksa apakah semua informasi sudah ada
                            if (provider.state == ResultState.loading) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please wait, uploading in progress...'),
                                ),
                              );
                              return;
                            }

                            final token = await cred.preferences.getToken();
                            final response = await provider.postStory(
                              description: description,
                              imagePath: imageFile.path,
                              token: token,
                              lat: selectedLat,
                              lon: selectedLon,
                            );

                            if (provider.state == ResultState.done &&
                                response.error == false &&
                                context.mounted) {
                              provider.getAllStory();
                              provider.refresh();
                              context.goNamed('bottomNav');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Failed to upload story. Please try again.'),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please provide description, image, and location.',
                                ),
                              ),
                            );
                          }
                        },
                        child: provider.state == ResultState.loading
                            ? const CircularProgressIndicator(
                                color: Colors.black)
                            : Text(
                                AppLocalizations.of(context)!.uploadButtonTitle,
                                style: const TextStyle(
                                  color: Color(0XFF12111F),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
