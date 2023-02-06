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
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g2s1.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g2s2.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/QuestionStepPriceZipperVolume.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/QuestionStepQualitativeCriteria.dart';

class w4g2 extends ISurveyConnector {
  @override
  List<Step> getSteps(context) {
    IInstructionStep ISTenderNationLogo = InstructionStepTenderNationLogo();
    IInstructionStep ISw4g2s1 = InstructionStepw4g2s1(context);
    IInstructionStep ISw4g2s2 = InstructionStepw4g2s2(context);
    IQuestionStep ISQuestionStepZipper = QuestionStepPriceZipper();

    ICompletionStep CSEndGame = CompletionStepEndGame();

    return [
      QuestionStepTeamName(),
      ISw4g2s1,
      ISw4g2s2,
      ISQuestionStepZipper,
      QualitativeCriteria(),
      CSEndGame
    ];
  }
}
