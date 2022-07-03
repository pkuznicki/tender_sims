import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/QuestionStepPriceZipper.dart';
import 'package:tender_sims/survey/interfaces/ICompletionStep.dart';
import 'package:tender_sims/survey/interfaces/ISurveyConnector.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepMarketInTenderNation.dart';
import '../concretegames/concretesteps/InstructionStepTenderNationLogo.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:tender_sims/survey/interfaces/IQuestionStep.dart';
import '../concretegames/concretesteps/QuestionStepTeamName.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/CompletionStepEndGame.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepChart.dart';

class TenderSimsGame01 extends ISurveyConnector {
  @override
  List<Step> getSteps(context) {
    IInstructionStep ISTenderNationLogo = InstructionStepTenderNationLogo();
    IInstructionStep ISTestStep = InstructionStepChart(context);
    IInstructionStep ISMarketInTenderNation =
        InstructionStepMarketInTenderNation(context);
    IQuestionStep QSZipper = QuestionStepPriceZipper();
    IQuestionStep QSTeamName = QuestionStepTeamName();
    ICompletionStep CSEndGame = CompletionStepEndGame();

    return [
      ISTenderNationLogo,
      ISTestStep,
      QSTeamName,
      ISMarketInTenderNation,
      QSZipper,
      CSEndGame
    ];
  }
}
