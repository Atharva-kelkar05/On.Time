import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class ScheduleTimeLine extends StatelessWidget {
  const ScheduleTimeLine({super.key});

  //Color primaryColor = Colors.primaries[Random().nextInt(2)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Schedule Timeline',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Timeline.tileBuilder(
                theme: TimelineThemeData(
                  nodePosition: 0,
                  indicatorTheme: const IndicatorThemeData(
                    position: 0,
                    size: 20.0,
                  ),
                  connectorTheme: const ConnectorThemeData(
                    thickness: 2.5,
                  ),
                ),
                builder: TimelineTileBuilder.connected(
                  connectionDirection: ConnectionDirection.before,
                  itemCount: 5,
                  contentsBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Timeline Event $index'),
                        ),
                      ),
                    );
                  },
                  indicatorBuilder: (context, index) {
                    return const DotIndicator(
                      color: Colors.red,
                      child: Icon(Icons.schedule),
                    );
                  },
                  connectorBuilder: (context, index, type) {
                    return const SolidLineConnector(
                      color: Colors.red,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
