import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/provider/story_provider.dart';
import 'package:story_apps/utils/response_state.dart';
import 'package:story_apps/widgets/card_list.dart';
import 'package:story_apps/widgets/flag_icon_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final apiProvider = context.read<StoryProvider>();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (apiProvider.pageItems != null) {
          apiProvider.getAllStory();
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
        actions: const [
          FlagWidget(),
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
                  builder: (context, provider, child) {
                    if (provider.state == ResultState.loading &&
                        provider.pageItems == 1) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else if (provider.state == ResultState.error) {
                      return Center(
                        child: Text(provider.message),
                      );
                    } else {
                      final listStory = provider.allStory;
                      return ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: listStory.length +
                            (provider.pageItems != null ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == listStory.length &&
                              provider.pageItems != null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return CardListStory(
                            stories: listStory[index],
                          );
                        },
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
}
