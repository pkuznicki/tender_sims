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
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw2g2s1.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/QuestionStepPriceZipperVolume.dart';

class w2g2 extends ISurveyConnector {
  @override
  List<Step> getSteps(context) {
    IInstructionStep ISTenderNationLogo = InstructionStepTenderNationLogo();
    IInstructionStep ISw2g2s1 = InstructionStepw2g2s1(context);
    IQuestionStep ISQuestionStepZipper = QuestionStepPriceZipper();

    ICompletionStep CSEndGame = CompletionStepEndGame();

    return [
      ISTenderNationLogo,
      QuestionStepTeamName(),
      ISw2g2s1,
      ISQuestionStepZipper,
      QuestionStepPriceZipperVolume(volume: 3000000),
      CSEndGame
    ];
  }
}
