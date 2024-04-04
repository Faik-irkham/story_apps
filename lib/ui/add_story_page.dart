import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
  final TextEditingController _descriptionController = TextEditingController();
  late LocationProvider _locationProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locationProvider = Provider.of<LocationProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _locationProvider.setLocation(null, null);
    _locationProvider.setImageFile(null);
    _locationProvider.setImagePath(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.close,
          ),
        ),
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
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
                child: Consumer<LocationProvider>(
                    builder: (context, provider, state) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    children: [
                      provider.imagePath == null
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SafeArea(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading:
                                                const Icon(Icons.photo_library),
                                            title: const Text(
                                                'Choose from Gallery'),
                                            onTap: () => provider.fromGallery(),
                                          ),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.camera_alt),
                                            title: const Text('Take a Picture'),
                                            onTap: () => provider.fromCamera(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height / 2.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[300],
                                ),
                                child: const Icon(
                                  Icons.image,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : provider.state == ResultState.loading
                              ? const CircularProgressIndicator()
                              : Image.file(
                                  File(
                                    provider.imagePath.toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: _descriptionController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.deskripsiUpload,
                            hintStyle: const TextStyle(color: Colors.white),
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
                      const SizedBox(height: 15),
                      Consumer<LocationProvider>(
                          builder: (context, provider, state) {
                        return SizedBox(
                          child: provider.location == null
                              ? GestureDetector(
                                  onTap: () => context.goNamed('map_pick'),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_sharp,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'addLocation',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.arrow_forward_ios_rounded),
                                    ],
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_sharp),
                                        const SizedBox(width: 10),
                                        Text(provider.location!),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios_rounded),
                                  ],
                                ),
                        );
                      }),
                      const SizedBox(height: 25),
                      Consumer3<StoryProvider, CredentialProvider,
                          LocationProvider>(
                        builder: (context, provider, cred, loc, state) {
                          return CustomFilledButton(
                            onPressed: () async {
                              if (_descriptionController.text.isNotEmpty &&
                                  loc.imageFile != null) {
                                if (provider.state == ResultState.error &&
                                    context.mounted) {
                                  const ScaffoldMessenger(
                                      child: SnackBar(
                                    content: Text('tidak ada internet'),
                                  ));
                                }
                                final response = await provider.postStory(
                                  token: cred.token!,
                                  description: _descriptionController.text,
                                  imagePath: loc.imagePath!,
                                  lat: loc.latLng?.latitude,
                                  lon: loc.latLng?.longitude,
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger(
                                      child: SnackBar(
                                    content: Text(response.message),
                                  ));
                                }
                                if (response.error == false &&
                                    context.mounted) {
                                  provider.refresh();
                                  context.goNamed('bottomNav');
                                }
                              }
                            },
                            child: provider.state == ResultState.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : Text(AppLocalizations.of(context)!
                                    .uploadButtonTitle),
                          );
                        },
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
