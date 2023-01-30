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

class w1g0 extends ISurveyConnector {
  @override
  List<Step> getSteps(context) {
    IInstructionStep ISTenderNationLogo = InstructionStepTenderNationLogo();
    Step w1g0s1 = helper.get_step_by_id('w1g0s1', context);
    Step w1g0s2 = helper.get_step_by_id('w1g0s2', context);
    Step w1g0s3 = helper.get_step_by_id('w1g0s3', context);
    Step w1g0s4 = helper.get_step_by_id('w1g0s4', context);
    Step w1g0s5 = helper.get_step_by_id('w1g0s5', context);

    ICompletionStep CSEndGame = CompletionStepEndGame();

    return [w1g0s1, w1g0s2, w1g0s3, w1g0s4, w1g0s5, CSEndGame];
  }
}
