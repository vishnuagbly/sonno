import 'package:flutter/material.dart';
import 'package:sonno/components/custom_sliding_route.dart';
import 'package:sonno/constants.dart';
import 'package:sonno/objects/questions.dart';
import 'package:sonno/pages/question_page.dart';

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: Questions.all.length,
        itemBuilder: (context, i) {
          double topMargin = 0;
          if (i == 0) topMargin = 20;
          return Container(
            margin: EdgeInsets.only(top: topMargin),
            padding: const EdgeInsets.all(10),
            color: kPrimaryColor,
            child: ListTile(
              title: Text(
                Questions.all[i].question,
                maxLines: 2,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  createSlidingRoute(
                    QuestionPage(Questions.all[i]),
                    Offset(1, 0),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
