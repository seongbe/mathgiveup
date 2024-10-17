import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:mathgame/page/mypage/learningInfo/calenderWidget.dart';
import 'package:provider/provider.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/model/progressModel.dart';
import 'package:mathgame/auth/auth_token.dart';

class StudyDaysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '연속 학습 일수'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          MyWidget(),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final progressModel = Provider.of<ProgressModel>(context);
    double progressValue = progressModel.currentDay / progressModel.targetDay;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '뱃지 지급까지 ${progressModel.targetDay - progressModel.currentDay}일 남았어요',
                      style: skyboriBaseTextStyle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '연속 학습 ',
                            style: skyboriBaseTextStyle.copyWith(
                              fontSize: 15,
                              color: Colors.blueGrey,
                            ),
                          ),
                          TextSpan(
                            text: '${progressModel.currentDay}',
                            style: skyboriBaseTextStyle.copyWith(
                              fontSize: 15,
                              color: Colors.blue,
                            ),
                          ),
                          TextSpan(
                            text: '일차',
                            style: skyboriBaseTextStyle.copyWith(
                              fontSize: 15,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${progressModel.currentDay}/${progressModel.targetDay} days',
                style: skyboriBaseTextStyle.copyWith(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: progressValue,
            minHeight: 15,
            backgroundColor: Colors.grey[300],
            color: Colors.blue,
          ),
          SizedBox(height: 20),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(10.0),
              child: CalendarWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
