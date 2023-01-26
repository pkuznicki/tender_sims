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
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g1s1.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g1s2.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/QuestionStepPriceZipperVolume.dart';

class w4g1 extends ISurveyConnector {
  @override
  List<Step> getSteps(context) {
    IInstructionStep ISTenderNationLogo = InstructionStepTenderNationLogo();
    IInstructionStep ISw4g1s1 = InstructionStepw4g1s1(context);
    IInstructionStep ISw4g1s2 = InstructionStepw4g1s2(context);
    IQuestionStep ISQuestionStepZipper = QuestionStepPriceZipper();

    ICompletionStep CSEndGame = CompletionStepEndGame();

    return [
      ISTenderNationLogo,
      QuestionStepTeamName(),
      ISw4g1s1,
      ISw4g1s2,
      ISQuestionStepZipper,
      QuestionStepPriceZipperVolume(),
      CSEndGame
    ];
  }
}
