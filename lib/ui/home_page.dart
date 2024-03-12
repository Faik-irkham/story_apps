import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story_apps/widgets/card_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: const SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardListStory(
                        imageUrl: 'assets/coffee1.jpg',
                        name: 'Dimas',
                        description: 'sdmksmdskdk',
                      ),
                      CardListStory(
                        imageUrl: 'assets/coffee1.jpg',
                        name: 'Dimas',
                        description: 'sdmksmdskdk',
                      ),
                      CardListStory(
                        imageUrl: 'assets/coffee1.jpg',
                        name: 'Dimas',
                        description: 'sdmksmdskdk',
                      ),
                      CardListStory(
                        imageUrl: 'assets/coffee1.jpg',
                        name: 'Dimas',
                        description: 'sdmksmdskdk',
                      ),
                      CardListStory(
                        imageUrl: 'assets/coffee1.jpg',
                        name: 'Dimas',
                        description: 'sdmksmdskdk',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
