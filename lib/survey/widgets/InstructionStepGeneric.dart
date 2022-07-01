import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepGeneric extends IInstructionStep {
  InstructionStepGeneric(BuildContext context,
      {String title = 'no title',
      String asset = 'no asset path',
      String bodytext = 'no body text'})
      : super(
            Container(
                child: Column(children: [
              Text(
                title,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                asset,
                scale: 4,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  bodytext,
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_market_tn'),
            title: 'The Market in Tender Nation',
            text: '');
}
