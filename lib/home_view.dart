import 'package:flutter/material.dart';
import 'package:flutter_user_guildance/flutter_user_guildance.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  UserGuidanceController userGuidanceController = UserGuidanceController();
  var tabs = ["Task", "Done", "Deleted"];

  @override
  void dispose() {
    userGuidanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UserGuidance(
      controller: userGuidanceController,
      opacity: 0.5,
      slotBuilder: (context, data) {
        if (data?.step == 1) {
          return BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(data!.position.height / 2.0),
          );
        }
        return null;
      },
      tipBuilder: (context, data) {
        if (data != null) {
          return TipWidget(
            data: data,
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250.0),
                child: Text("${data.tag}")),
          );
        }

        return null;
      },
      child: DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              title: const Text(
                'ToDoOs...',
                style: TextStyle(color: Colors.black),
              ),
            ),
            floatingActionButton: UserGuildanceAnchor(
                group: 1,
                step: 1,
                tag: "Start by adding Todos",
                child: FloatingActionButton(
                  backgroundColor: Colors.amber,
                  onPressed: () {
                    userGuidanceController.show(group: 1);
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                )),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  TabBar(
                    indicatorColor: Colors.amber,
                    tabs: tabs.map<Widget>(
                      (txt) {
                        var subStep = tabs.indexOf(txt);
                        return Tab(
                          child: UserGuildanceAnchor(
                            group: 1,
                            step: 3,
                            subStep: subStep,
                            reportType: AnchorReportParentType.tab,
                            tag: "This is $txt",
                            child: Text(
                              txt,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: tabs
                          .map<Widget>((txt) => Center(
                                child: Container(
                                  child: Text(
                                    txt,
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  UserGuildanceAnchor(
                    group: 1,
                    step: 2,
                    tag: "Press the button to delete todos",
                    adjustRect: (rect) {
                      return Rect.fromLTWH(rect.left, rect.top + 5.0,
                          rect.width, rect.height - 10.0);
                    },
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.amber),
                        onPressed: () {
                          userGuidanceController.show();
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ]),
              ),
            ),
          )),
    );
  }
}
