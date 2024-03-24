import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/provider/story_provider.dart';
import 'package:story_apps/utils/response_state.dart';
import 'package:story_apps/widgets/card_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: const Text(
          'Story Apps',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.flag),
            onPressed: () {
              // Aksi ketika tombol "Flag" ditekan
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Aksi ketika tombol "Add Story" ditekan
            },
          ),
        ],
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
                      return const Center(child: CircularProgressIndicator());
                    } else if (provider.state == ResultState.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.result.listStory.length,
                        itemBuilder: (context, index) {
                          var stories = provider.result.listStory[index];
                          return GestureDetector(
                            onTap: () {},
                            child: CardListStory(
                              stories: stories,
                            ),
                          );
                        },
                      );
                    } else if (provider.state == ResultState.noData) {
                      return const Center(
                        child: Material(
                          child: Text('Tidak ada Data!'),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Material(
                          child: Text('Error: state null'),
                        ),
                      );
                    }
                  },
                ),
                // child: SingleChildScrollView(
                //   physics: const AlwaysScrollableScrollPhysics(),
                //   padding: const EdgeInsets.symmetric(
                //     vertical: 40,
                //     horizontal: 10,
                //   ),
                //   child: Consumer<StoryProvider>(
                //     builder: (context, state, _) {
                //       if (state.state == ResultState.loading) {
                //         return const Center(child: CircularProgressIndicator());
                //       } else if (state.state == ResultState.hasData) {
                //         return ListView.builder(
                //           itemCount: state.result.listStory.length,
                //           itemBuilder: (context, index) {
                //             var stories = state.result.listStory[index];
                //             return GestureDetector(
                //               onTap: () {},
                //               child: CardListStory(
                //                 stories: stories,
                //               ),
                //             );
                //           },
                //         );
                //       } else if (state.state == ResultState.noData) {
                //         return const Center(
                //           child: Material(
                //             child: Text('Tidak ada Data!'),
                //           ),
                //         );
                //       } else {
                //         return const Center(
                //           child: Material(
                //             child: Text('dfdffd'),
                //           ),
                //         );
                //       }
                //     },
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
