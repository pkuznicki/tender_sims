import 'package:survey_kit/survey_kit.dart';

class InstructionStepMarketInTenderNation {
  InstructionStep getStep() {
    return InstructionStep(
      title: 'The Market in Tender Nation',
      text:
          '''All in-patient products are procured through tenders published by regional authorities    
      Inflammation Care products are classified as hospital products and therefore tenders
      The 3 regions have similar volumes of purchase
      The 3 regions have similar economics & demographics
      There is no difference in all major healthcare characteristics of the 3 regions
      ''',
      buttonText: 'Let\'s go!',
    );
  }
}
