import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/common/common.dart';
import 'package:story_apps/data/model/response_story_model.dart';
import 'package:story_apps/provider/story_provider.dart';
import 'package:story_apps/ui/map_page.dart';
import 'package:story_apps/utils/response_state.dart';
import 'package:geocoding/geocoding.dart' as geo;

class DetailStoryPage extends StatefulWidget {
  final String id;
  const DetailStoryPage({super.key, required this.id});

  @override
  State<DetailStoryPage> createState() => _DetailStoryPageState();
}

class _DetailStoryPageState extends State<DetailStoryPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<StoryProvider>(context, listen: false)
            .detailStory(widget.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.detailPostTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
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
                child: Consumer<StoryProvider>(
                  builder: (context, provider, _) {
                    if (provider.state == ResultState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else if (provider.state == ResultState.done) {
                      if (provider.story != null) {
                        return buildContent(context, provider.story!);
                      } else {
                        return Center(
                          child:
                              Text(AppLocalizations.of(context)!.noDataTitle),
                        );
                      }
                    } else {
                      return Center(
                        child: Text('Terjadi kesalahan: ${provider.message}'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context, Story story) {
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(story.photoUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            story.name,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            story.description,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 15),
        story.lat != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FutureBuilder<String>(
                    future: _storyLocation(story),
                    builder: (_, snapshot) {
                      return Row(
                        children: [
                          const Icon(
                            Icons.location_on_sharp,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            snapshot.data ?? '',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    }),
              )
            : const SizedBox(),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              if (story.lat != null && story.lon != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(
                      id: story.id,
                      lat: story.lat.toString(),
                      lon: story.lon.toString(),
                    ),
                  ),
                );
              }
            },
            child: const Text('Lihat di Peta'),
          ),
        ),
      ],
    );
  }

  Future<String> _storyLocation(Story story) async {
    final latLng = LatLng(story.lat!, story.lon!);
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];

    return place.subAdministrativeArea ?? '';
  }
}
