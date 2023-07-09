import 'package:dream_tracker/backend.dart';
import 'package:dream_tracker/colors.dart';
import 'package:dream_tracker/global_variables.dart';
import 'package:dream_tracker/widgets/ad_place.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:expandable_text/expandable_text.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({super.key, required this.id});
  final String id;

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getGoalItemStream(widget.id),
      builder: (context, itemSnapShot) {
        if (itemSnapShot.hasError) {
          return const Center(
            child: Text('Dang!! Couldnt fetch data'),
          );
        } else if (itemSnapShot.connectionState == ConnectionState.waiting) {
          return ExpansionTileCard(
            leading: const Icon(Icons.circle),
            title: const Text('Title'),
            subtitle: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                //________ Progress Bar
                //
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: LinearProgressIndicator(value: 1),
                ),
                //
                // ______ amount text __
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '50 / 100',
                    )
                  ],
                ),
              ],
            ),
            children: [
              //
              // __________ Expandable Text __//
              //
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ExpandableText(
                  "Notes...",
                  expandText: 'Show More',
                  collapseText: 'Show Less',
                ),
              ),
              //
              // ____________ Ad Place __//
              //
              const AdPlace(),
              //
              // ____________ Buttons Place __//
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //
                  //________ Add Button ______//
                  //
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Add Money'),
                  ),
                  //
                  //________ Three Buttons ______//
                  //
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          // Handle button tap
                        },
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFebddff),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        } else {
          //
          //____ Expansion Card ______//
          //
          return ExpansionTileCard(
            leading: const Icon(Icons.abc),
            title: Text(itemSnapShot.data!.title),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                //________ Progress Bar
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: LinearProgressIndicator(
                    value: (itemSnapShot.data!.amountSaved >
                            itemSnapShot.data!.goalAmount)
                        ? 1
                        : itemSnapShot.data!.amountSaved /
                            itemSnapShot.data!.goalAmount,
                  ),
                ),
                //
                // ______ amount text __
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      (itemSnapShot.data!.amountSaved >
                              itemSnapShot.data!.goalAmount)
                          ? 'Exceeded!!  '
                          : ' ',
                    ),
                    Text(
                      '${itemSnapShot.data!.amountSaved}/${itemSnapShot.data!.goalAmount}',
                    )
                  ],
                ),
              ],
            ),
            children: [
              //
              // __________ Expandable Text __//
              //
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ExpandableText(
                  itemSnapShot.data!.notes,
                  expandText: 'Show More',
                  collapseText: 'Show Less',
                ),
              ),
              //
              // ____________ Ad Place __//
              //
              const AdPlace(),
              //
              // ____________ Buttons Place __//
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //
                  //________ Add Button ______//
                  //
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Add Money'),
                  ),
                  //
                  //________ Three Buttons ______//
                  //
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: InkWell(
                          onTap: () {
                            // Handle button tap
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F1FB),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                (index == 0)
                                    ? Icons.share
                                    : (index == 1)
                                        ? Icons.delete
                                        : Icons.edit,
                                color: const Color(0xFF8e6ccd),
                                size: 30.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
