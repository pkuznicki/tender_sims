import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:flutter/material.dart';

class InstructionStepMarketInTenderNation extends IInstructionStep {
  InstructionStepMarketInTenderNation()
      : super(
            Container(
                child: Column(children: [
              const Text('The Market in Tender Nation'),
              Image.asset('tn_map.png'),
              const Text(
                  'Tender authorities publish RFPs to procure medicines via tenders:')
            ])),
            const Text(
                '''All in-patient products are procured through tenders published by regional authorities    
      Inflammation Care products are classified as hospital products and therefore tenders
      The 3 regions have similar volumes of purchase
      The 3 regions have similar economics & demographics
      There is no difference in all major healthcare characteristics of the 3 regions
      '''),
            id: StepIdentifier(id: 'is_market_tn'),
            title: 'The Market in Tender Nation',
            text: '');
}
