import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepw4g3s2 extends IInstructionStep {
  InstructionStepw4g3s2(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Tender 12: Tender Award Criteria Framework',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_w4g3s2.png',
                scale: 2,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_w4g3s2'),
            title: 'Tender 12: Tender Award Criteria Framework',
            text: '');
}
