import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepw1g1s1 extends IInstructionStep {
  InstructionStepw1g1s1(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Tender 1: Hospital, price only & single winner tender',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_w1g1s1.png',
                scale: 2.6,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''Open Procedure #ABC123 for inflammation care products within Polaris Region:''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_w1g1s1'),
            title: 'Tender 1: Hospital, price only & single winner tender',
            text: '');
}
