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
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g0s1.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g0s2.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g0s3.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g0s4.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g0s5.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g0s6.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g0s7.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepw4g0s8.dart';

class w4g0 extends ISurveyConnector {
  @override
  List<Step> getSteps(context) {
    return [
      InstructionStepTenderNationLogo(),
      InstructionStepw4g0s1(context),
      InstructionStepw4g0s2(context),
      InstructionStepw4g0s3(context),
      InstructionStepw4g0s4(context),
      InstructionStepw4g0s5(context),
      InstructionStepw4g0s6(context),
      InstructionStepw4g0s7(context),
      InstructionStepw4g0s8(context),
      CompletionStepEndGame()
    ];
  }
}
