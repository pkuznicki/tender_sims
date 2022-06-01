import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/ISurveyConnector.dart';
import 'package:flutter/material.dart' hide Step;
import 'steps/InstructionStepMarketInTenderNation.dart';

class TenderSimsGame01 extends ISurveyConnector {
  @override
  List<Step> getSteps() {
    return [
      InstructionStepMarketInTenderNation().getStep(),
      QuestionStep(
        title: 'How old are you?',
        answerFormat: IntegerAnswerFormat(
          defaultValue: 25,
          hint: 'Please enter your age',
        ),
        isOptional: true,
      ),
      QuestionStep(
        title: 'Medication?',
        text: 'Are you using any medication',
        answerFormat: BooleanAnswerFormat(
          positiveAnswer: 'Yes',
          negativeAnswer: 'No',
          result: BooleanResult.POSITIVE,
        ),
      ),
      QuestionStep(
        title: 'Tell us about you',
        text: 'Tell us about yourself and why you want to improve your health.',
        answerFormat: TextAnswerFormat(
          maxLines: 5,
          validationRegEx: "^(?!\s*\$).+",
        ),
      ),
      QuestionStep(
        title: 'Select your body type',
        answerFormat: ScaleAnswerFormat(
          step: 1,
          minimumValue: 1,
          maximumValue: 5,
          defaultValue: 3,
          minimumValueDescription: '1',
          maximumValueDescription: '5',
        ),
      ),
      QuestionStep(
        title: 'Known allergies',
        text: 'Do you have any allergies that we should be aware of?',
        isOptional: false,
        answerFormat: MultipleChoiceAnswerFormat(
          textChoices: [
            TextChoice(text: 'Penicillin', value: 'Penicillin'),
            TextChoice(text: 'Latex', value: 'Latex'),
            TextChoice(text: 'Pet', value: 'Pet'),
            TextChoice(text: 'Pollen', value: 'Pollen'),
          ],
        ),
      ),
      QuestionStep(
        title: 'Done?',
        text: 'We are done, do you mind to tell us more about yourself?',
        isOptional: true,
        answerFormat: SingleChoiceAnswerFormat(
          textChoices: [
            TextChoice(text: 'Yes', value: 'Yes'),
            TextChoice(text: 'No', value: 'No'),
          ],
          defaultSelection: TextChoice(text: 'No', value: 'No'),
        ),
      ),
      QuestionStep(
        title: 'When did you wake up?',
        answerFormat: TimeAnswerFormat(
          defaultValue: TimeOfDay(
            hour: 12,
            minute: 0,
          ),
        ),
      ),
      QuestionStep(
        title: 'When was your last holiday?',
        answerFormat: DateAnswerFormat(
          minDate: DateTime.utc(1970),
          defaultDate: DateTime.now(),
          maxDate: DateTime.now(),
        ),
      ),
      CompletionStep(
        stepIdentifier: StepIdentifier(id: '321'),
        text: 'Thanks for taking the survey, we will contact you soon!',
        title: 'Done!',
        buttonText: 'Submit survey',
      ),
    ];
  }
}
