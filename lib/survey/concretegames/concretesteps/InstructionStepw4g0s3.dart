import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepw4g0s3 extends IInstructionStep {
  InstructionStepw4g0s3(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Tender Award Criteria Assessment Framework',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_w4g0s3.png',
                scale: 2.2,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_w4g0s3'),
            title: 'Tender Award Criteria Assessment Framework',
            text: '');
}
