import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepw2g0s2 extends IInstructionStep {
  InstructionStepw2g0s2(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Thoughts on COGS',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_w2g0s2.png',
                scale: 2.5,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_w1g1s2'),
            title: 'Thoughts on COGS',
            text: '');
}
