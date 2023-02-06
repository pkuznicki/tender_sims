import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IQuestionStep.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';
import 'package:flutter/material.dart';
import 'package:tender_sims/enums/enums.dart' as enums;

class QualitativeCriteria extends IQuestionStep {
  QualitativeCriteria()
      : super(
          stepIdentifier: StepIdentifier(id: 'qual_crit'),
          title: 'Please Select Qualitiative Criteria.',
          answerFormat: const MultipleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Product Packaging', value: 'product_packaging'),
              TextChoice(text: 'Delivery Time', value: 'delivery_time'),
              TextChoice(text: 'Payment Terms', value: 'payment_terms'),
              TextChoice(text: 'Customer Support', value: 'customer_support'),
              TextChoice(
                  text: 'Patient Support Programs', value: 'patient_support'),
              TextChoice(text: 'No Upgrade', value: 'no_upgrade'),
            ],
          ),
          isOptional: false,
        );
}
