import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';
import 'package:flutter/material.dart';

class InstructionStepTenderNationLogo extends IInstructionStep {
  InstructionStepTenderNationLogo()
      : super(Image.asset('tn_logo_small.png'), Container(),
            id: StepIdentifier(id: 'is_tn_logo'),
            title: 'The Market in Tender Nation',
            text: '');
}
