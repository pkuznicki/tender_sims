import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IQuestionStep.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';
import 'package:flutter/material.dart';

class QuestionStepPriceZipperVolume extends IQuestionStep {
  QuestionStepPriceZipperVolume({int volume = 1000000})
      : super(
            stepIdentifier: StepIdentifier(id: 'price_zipper_volume'),
            title: 'Please Select Your Bidding Volume from 0 to 2\'100\'000',
            answerFormat: IntegerAnswerFormat(
              defaultValue: volume,
            ));
}
