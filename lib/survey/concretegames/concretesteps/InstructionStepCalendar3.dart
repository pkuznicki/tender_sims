import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepCalendar3 extends IInstructionStep {
  InstructionStepCalendar3(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Upcoming Opportunities',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_calendar3.png',
                scale: 2,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''Your tender manager identified upcoming opportunities for wave 1 (3 Tenders)''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_calendar3'),
            title: 'Upcoming Opportunities',
            text: '');
}
