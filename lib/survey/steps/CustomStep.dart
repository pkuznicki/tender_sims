import 'package:survey_kit/survey_kit.dart';
import 'package:flutter/material.dart' as fl;
import 'CustomResult.dart';
import 'InstructionStepMarketInTenderNation.dart' as iss;

class CustomStep extends Step {
  final String title;
  final String text;

  CustomStep({
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
      step: iss.InstructionStepMarketInTenderNation().getStep(),
      resultFunction: () => CustomResult(
        id: Identifier(id: ''),
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        valueIdentifier: 'custom', //Identification for NavigableTask,
        result: 'custom_result',
      ),
      title: fl.Text('Title'),
      child: fl.Container(
        width: 50,
        height: 100,
        child: fl.Column(children: [
          fl.Text('asdf'),
          fl.Image(image: fl.AssetImage('logo.jpg')),
        ]),
      ), //Add your view here
    );
  }
}
