import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IQuestionStep.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';
import 'package:flutter/material.dart';

class QuestionStepPriceZipperVolume extends IQuestionStep {
  QuestionStepPriceZipperVolume({int volume = 1000000})
      : super(
          stepIdentifier: StepIdentifier(id: 'price_zipper_volume'),
          title: 'Please Select Your Bidding Volume from 0 to 2\'100\'000',
          answerFormat: ScaleAnswerFormat(
              step: 100,
              minimumValue: 0,
              maximumValue: 2100000,
              defaultValue: 1000000,
              minimumValueDescription: '0',
              maximumValueDescription: '2100000'),
              enum_format: enum_scale_format.volume),
        );
}
