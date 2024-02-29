import 'package:app_android_b_0245_24/ui/components/base_screen.dart';
import 'package:app_android_b_0245_24/ui/components/secondary_app_bar.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RulesView extends BaseScreen {
  const RulesView({super.key});

  @override
  State<RulesView> createState() => _RulesViewState();
}

class _RulesViewState extends BaseScreenState<RulesView> {
  @override
  Widget buildMain(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: AppColors.backgroundMain,
      child: Column(
        children: [
          const SecondaryAppBar(title: 'Game rules'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Gap(8),
                  const AppText(
                    text:
                        'Game Rules:\n1. Level Accessibility:\n• The player has access to all game levels from the beginning.\n• To pass each level, a certain number of points must be earned, indicated before the start of each level.\n2. Gameplay:\n• The player controls a character that moves up and down the game field.\n• The objective is to catch balls appearing on the field while avoiding banana peels.\n• For each caught ball, the player earns 5 coins, while each banana peel deducts 1 life.\n3. Lives and Results:\n• The player has 4 lives. If all lives are lost, the level will not be completed, and the results will be reset.\n• The number of stars the player receives for completing a level depends on the number of lives remaining: 3 stars - 4 lives, 2 stars - 3-2 lives, 1 star - 1 life.\n4. Difficulty Levels:\n• The game has three difficulty levels: easy, medium, and hard.\n• Easy difficulty consists of the first 4 levels of the game. Medium difficulty includes levels 5 through 10. Hard difficulty includes levels 11 through 14.',
                    style: AppTextStyles.regular14,
                    color: AppColors.textWhite,
                    maxLines: null,
                    align: TextAlign.justify,
                  ),
                  Gap(MediaQuery.paddingOf(context).bottom + 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
