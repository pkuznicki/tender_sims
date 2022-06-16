import 'package:survey_kit/survey_kit.dart';
import 'package:flutter/material.dart' as fl;
import 'CustomResult.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepTenderNationLogo.dart'
    as iss;

class CustomStep extends Step {
  final String title;
  final String text;
  final fl.Widget topWidget;
  final fl.Widget bottomWidget;

  CustomStep(
    this.topWidget,
    this.bottomWidget, {
    required StepIdentifier id,
    bool isOptional = false,
    String buttonText = 'Next',
    required this.title,
    required this.text,
  }) : super(
            isOptional: isOptional, buttonText: buttonText, stepIdentifier: id);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  fl.Widget createView({required QuestionResult? questionResult}) {
    return StepView(
      step: iss.InstructionStepTenderNationLogo(),
      resultFunction: () => CustomResult(
        id: Identifier(id: 'id'),
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        valueIdentifier: 'custom', //Identification for NavigableTask,
        result: 'custom_result',
      ),
      title: topWidget,
      child: bottomWidget,
    );
  }
}
