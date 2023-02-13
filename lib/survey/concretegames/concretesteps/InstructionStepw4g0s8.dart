import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepw4g0s8 extends IInstructionStep {
  InstructionStepw4g0s8(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Your tender manager identified upcoming opportunities for wave 4 (3 Tenders)',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_w4g0s8.png',
                scale: 2.2,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_w4g0s8'),
            title:
                'Your tender manager identified upcoming opportunities for wave 4 (3 Tenders)',
            text: '');
}
