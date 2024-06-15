import 'package:flutter/material.dart';
import 'package:kode4u/configs/k_config.dart';
import '../states/story_item.dart';

class ListCard extends StatelessWidget {
  final int? itemIndex;
  final StoryItem? storyItem;
  final Function? press;

  const ListCard({
    Key? key,
    this.itemIndex,
    this.storyItem,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: KConfig.margin,
        vertical: 5,
      ),
      // color: Colors.blueAccent,
      height: 80,
      child: InkWell(
        onTap: () {
          press!();
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(KConfig.radius),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              top: 0,
              child: Container(
                margin: const EdgeInsets.only(right: 30),
                width: size.width - 30,
                child: SizedBox(
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Spacer(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: KConfig.margin),
                        child: Text(
                          '${storyItem!.id}. ${storyItem!.title}',
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),

                      const Spacer(),
                      // it use the available space
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
