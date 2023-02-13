import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepw4g0s5 extends IInstructionStep {
  InstructionStepw4g0s5(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Perceived Bidding Price Computation',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_w4g0s5.png',
                scale: 2.5,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_w4g0s5'),
            title: 'Perceived Bidding Price Computation',
            text: '');
}
