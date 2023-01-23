import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepw3g0s1 extends IInstructionStep {
  InstructionStepw3g0s1(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Your tender manager identified upcoming opportunities for wave 3 (3 Tenders)',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_w3g0s1.png',
                scale: 2,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_w3g0s1'),
            title:
                'Your tender manager identified upcoming opportunities for wave 3 (3 Tenders)',
            text: '');
}
