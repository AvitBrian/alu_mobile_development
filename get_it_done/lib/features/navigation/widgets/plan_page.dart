import 'package:flutter/material.dart';
import 'package:get_it_done/utils/constants.dart';

class Plan extends StatelessWidget {
  Plan({super.key});

  final List<Map> tasks = List.generate(
      5,
      (index) => {
            "id": index,
            "name": "Task ${index + 1}",
            "state": "",
            "photoUrl": ""
          });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                        constraints: BoxConstraints(
                            maxHeight: MyConstants.screenHeight(context) * 0.2),
                        child: Scaffold(
                          body: Center(child: Text("${tasks[index]["name"]}")),
                        ));
                  },
                  context: context,
                );
              },
              child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  width: MyConstants.screenWidth(context),
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MyConstants.screenHeight(context),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0))),
                                          width:
                                              MyConstants.screenWidth(context),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Text(
                                              "${tasks[index]["name"]}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: MyConstants.screenWidth(context),
                                    child: const Text(
                                      "Important",
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            )),
                            Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0))),
                                width: MyConstants.screenWidth(context),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.delete_forever,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  )),
            );
          }),
    );
  }
}
