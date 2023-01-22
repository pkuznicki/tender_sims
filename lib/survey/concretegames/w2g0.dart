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
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw2g0s1.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw2g0s2.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw2g0s3.dart';

class w2g0 extends ISurveyConnector {
  @override
  List<Step> getSteps(context) {
    return [
      InstructionStepTenderNationLogo(),
      InstructionStepw2g0s1(context),
      InstructionStepw2g0s2(context),
      InstructionStepw2g0s3(context),
      CompletionStepEndGame()
    ];
  }
}
