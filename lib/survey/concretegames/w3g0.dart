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
import 'package:tender_sims/survey/helpers/helper.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw3g0s1.dart';

class w3g0 extends ISurveyConnector {
  @override
  List<Step> getSteps(context) {
    return [InstructionStepw3g0s1(context), CompletionStepEndGame()];
  }
}
