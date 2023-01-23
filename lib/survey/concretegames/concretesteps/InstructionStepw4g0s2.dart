import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepw4g0s2 extends IInstructionStep {
  InstructionStepw4g0s2(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Are you willing to develop your quality criteria?',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_w4g0s2.png',
                scale: 2,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_w4g0s2'),
            title: 'Are you willing to develop your quality criteria?',
            text: '');
}
