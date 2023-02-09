import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepw1g2s1 extends IInstructionStep {
  InstructionStepw1g2s1(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Tender 2: Hospital, price only & single winner tender',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_w1g2s1.png',
                scale: 2,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''Open Procedure #BCD234 for inflammation care products within Riverland Region''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_w1g2s1'),
            title: 'Tender 2: Hospital, price only & single winner tender',
            text: '');
}
