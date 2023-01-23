import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepw3g1s1 extends IInstructionStep {
  InstructionStepw3g1s1(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Tender 7: National, price only & multiple awardees tender',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_w3g1s1.png',
                scale: 2,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_w3g1s1'),
            title: 'Tender 7: National, price only & multiple awardees tender',
            text: '');
}
