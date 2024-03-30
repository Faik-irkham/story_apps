import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/common/common.dart';
import 'package:story_apps/provider/story_provider.dart';
import 'package:story_apps/utils/response_state.dart';
import 'package:story_apps/widgets/card_list.dart';
import 'package:story_apps/widgets/flag_icon_widget.dart';

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
                  builder: (context, provider, _) {
                    if (provider.state == ResultState.loading) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    } else if (provider.state == ResultState.done) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.result.listStory.length,
                        itemBuilder: (context, index) {
                          var stories = provider.result.listStory[index];
                          return CardListStory(
                            stories: stories,
                          );
                        },
                      );
                    } else if (provider.state == ResultState.error) {
                      return Center(
                        child: Material(
                          child:
                              Text(AppLocalizations.of(context)!.noDataTitle),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
