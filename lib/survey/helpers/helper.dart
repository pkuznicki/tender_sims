import 'package:survey_kit/survey_kit.dart' as srv;
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepMarketInTenderNation.dart';
import 'package:tender_sims/survey/interfaces/IInstructionStep.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/ErrorStepEndGame.dart'
    as error_step;
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepHistoricalPrices.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepCalendar.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepCalendar2.dart';
import 'package:tender_sims/survey/concretegames/concretesteps/InstructionStepCalendar3.dart';

class helper {
  static srv.Step get_step_by_id(String step_id, context) {
    srv.Step result = error_step.CompletionStepEndGame();

    if (step_id == 'w1g0s1') {
      IInstructionStep ISMarketInTenderNation =
          InstructionStepMarketInTenderNation(context);
      result = ISMarketInTenderNation;
    }
    if (step_id == 'w1g0s2') {
      IInstructionStep ISHistoricalPrices =
          InstructionStepHistoricalPrices(context);
      result = ISHistoricalPrices;
    }
    if (step_id == 'w1g0s3') {
      IInstructionStep ISCalendar = InstructionStepCalendar(context);
      result = ISCalendar;
    }
    if (step_id == 'w1g0s4') {
      IInstructionStep ISCalendar2 = InstructionStepCalendar2(context);
      result = ISCalendar2;
    }
    if (step_id == 'w1g0s5') {
      IInstructionStep ISCalendar3 = InstructionStepCalendar3(context);
      result = ISCalendar3;
    }

    return result;
  }
}
