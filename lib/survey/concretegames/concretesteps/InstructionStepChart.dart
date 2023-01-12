import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';
import 'package:tender_sims/survey/widgets/InstructionStepGeneric.dart';

class InstructionStepChart extends InstructionStepGeneric {
  InstructionStepChart(context)
      : super(context,
            asset: 'assets/tn_logo.png',
            bodytext:
                'body text body text body text body text body text body text body text body text body text body text body text body text body text body text body text body text body text body text body text body text body text ',
            title: 'This is a title');
}
