import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../styling/constants.dart';

class QuestionAnswerColumn extends StatefulWidget {
  final Function(int, String) answerHandler;
  final String question;
  final List<String> answers;
  final String? helpText;

  const QuestionAnswerColumn({
    super.key,
    required this.answerHandler,
    required this.question,
    required this.answers,
    this.helpText,
  });

  @override
  State<StatefulWidget> createState() => _QuestionAnswerColumnState();
}

class _QuestionAnswerColumnState extends State<QuestionAnswerColumn> {
  bool isHelpShown = false;

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    const double topDistance = 0.05;
    const double bottomDistance = 0.12;
    const double questionWidth = 250;
    const double elementDistance = distanceDefault;
    const double closeDistance = elementDistance / 2;
    const double questionCloseDistance = elementDistance / 4;
    const double openHelpFontSize = 14;
    const double helpShownWidth = buttonWidth-20;
    const double helpShownPadding = paddingSmall;
    const double helpShownBorderRadius = borderRadiusMedium;
    const double helpTitleFontSize = 18;

    List<Widget> children = [
      Container(
        height: mediaQuery.height * topDistance,
      ),
      Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: questionWidth,
          child: Text(
            widget.question,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    ];

    if (widget.helpText != null) {
      children.add(Container(height: questionCloseDistance));
      if (isHelpShown) {
        children.add(
          Container(
            width: helpShownWidth,
            padding: const EdgeInsets.only(
              top: helpShownPadding,
              left: helpShownPadding,
              right: helpShownPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(helpShownBorderRadius),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.helpTextTitle,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: helpTitleFontSize,
                  ),
                ),
                Container(
                  height: closeDistance,
                ),
                Text(
                  widget.helpText!,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
                Container(
                  height: closeDistance,
                ),
                Align(alignment: Alignment.centerRight,child: ActionChip(
                  shadowColor: const Color.fromARGB(0, 0, 0, 0),
                  label: Text(
                    AppLocalizations.of(context)!.closeHelpText,
                    style: const TextStyle(
                      fontSize: openHelpFontSize,
                    ),
                  ),
                  avatar: const Icon(
                    Icons.check,
                    size: iconSizeVeryTiny,
                  ),
                  onPressed: () {
                    setState(() {
                      isHelpShown = false;
                    });
                  },
                ),),
              ],
            ),
          ),
        );
      } else {
        children.add(
          ActionChip(
            shadowColor: const Color.fromARGB(0, 0, 0, 0),
            onPressed: () {
              setState(() {
                isHelpShown = true;
              });
            },
            label: Text(
              AppLocalizations.of(context)!.openHelpText,
              style: const TextStyle(
                fontSize: openHelpFontSize,
              ),
            ),
            avatar: const Icon(
              Icons.help_outline,
              size: iconSizeVeryTiny,
            ),
          ),
        );
      }
    }

    children.add(
      Container(
        height: mediaQuery.height * bottomDistance,
      ),
    );
    widget.answers.asMap().forEach((index, answer) {
      children.add(const SizedBox(height: elementDistance));
      children.add(
        ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.onSecondary),
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.secondary),
          ),
          onPressed: () => widget.answerHandler(index, answer),
          child: Text(answer),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
