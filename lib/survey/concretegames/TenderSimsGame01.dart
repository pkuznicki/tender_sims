import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/QuestionStepPriceZipper.dart';
import 'package:tender_sims/survey/interfaces/ISurveyConnector.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepMarketInTenderNation.dart';
import '../steps/CustomStep.dart';
import '../concretegames/concretesteps/InstructionStepTenderNationLogo.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:tender_sims/survey/interfaces/IQuestionStep.dart';

class TenderSimsGame01 extends ISurveyConnector {
  @override
  List<Step> getSteps() {
    IInstructionStep ISTenderNationLogo = InstructionStepTenderNationLogo();
    IInstructionStep ISMarketInTenderNation =
        InstructionStepMarketInTenderNation();
    IQuestionStep QSZipper = QuestionStepPriceZipper();

    return [
      ISTenderNationLogo,
      ISMarketInTenderNation,
      QSZipper,
      CompletionStep(
        stepIdentifier: StepIdentifier(id: '321'),
        text: 'Thank you!',
        title: 'Let\'evaluate the results.',
        buttonText: 'Submit',
      ),
    ];
  }
}
