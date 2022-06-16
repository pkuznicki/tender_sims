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

class TenderSimsGame01 extends ISurveyConnector {
  @override
  List<Step> getSteps() {
    IInstructionStep ISTenderNationLogo = InstructionStepTenderNationLogo();
    IInstructionStep ISMarketInTenderNation =
        InstructionStepMarketInTenderNation();
    IQuestionStep QSZipper = QuestionStepPriceZipper();
    IQuestionStep QSTeamName = QuestionStepTeamName();
    ICompletionStep CSEndGame = CompletionStepEndGame();

    return [ISTenderNationLogo, ISMarketInTenderNation, QSZipper, CSEndGame];
  }
}
