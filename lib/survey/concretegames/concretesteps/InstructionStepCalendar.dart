import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepCalendar extends IInstructionStep {
  InstructionStepCalendar(context)
      : super(
            Container(
                child: Column(children: [
              const Text(
                'Tender Calendar',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/tn_calendar.png',
                scale: 2.3,
              ),
            ])),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  '''''',
                  textAlign: TextAlign.justify,
                )),
            id: StepIdentifier(id: 'is_calendar'),
            title: 'Tender Calendar',
            text: '');
}
