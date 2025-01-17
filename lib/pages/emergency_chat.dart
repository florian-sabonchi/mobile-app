import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:helpwave/components/chat_message.dart';
import 'package:helpwave/styling/constants.dart';

class EmergencyChatPage extends StatefulWidget {
  final Map<String, dynamic> emergencyRoom;

  const EmergencyChatPage({required this.emergencyRoom, super.key});

  @override
  State<StatefulWidget> createState() => _EmergencyChatPageState();
}

class _EmergencyChatPageState extends State<EmergencyChatPage> {
  List<Map<String, dynamic>> messages = [
    {"isFromEmergencyRoom": true, "message": "How are you?"},
    {"isFromEmergencyRoom": false, "message": "Fine"},
    {"isFromEmergencyRoom": true, "message": "okay..."}
  ];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  bool canSend = false;

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    addMessage() {
      setState(() {
        canSend = false;
        messages.add(
            {"isFromEmergencyRoom": false, "message": _controller.text.trim()});
        _controller.clear();
      });
      FocusScope.of(context).unfocus();
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    }

    const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadiusMedium),
      ),
    );

    List<Widget> listViewContent = [
      Container(
        height: distanceSmall,
      )
    ];
    listViewContent
        .addAll(messages.map((e) => ChatMessage(message: e)).toList());

    return Scaffold(
      appBar: AppBar(
        shadowColor: Theme.of(context).colorScheme.shadow,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: iconSizeSmall,
              height: iconSizeSmall,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: distanceTiny,
            ),
            Text(
              widget.emergencyRoom["name"],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: fontSizeMedium),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  children: listViewContent,
                ),
              ),
              Container(
                width: mediaQuery.width,
                padding: const EdgeInsets.all(paddingSmall),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.message,
                          focusedBorder: outlineInputBorder.copyWith(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          enabledBorder: outlineInputBorder.copyWith(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          bool couldSend = _controller.text.trim().isNotEmpty;
                          if (canSend != couldSend) {
                            setState(() {
                              canSend = couldSend;
                            });
                          }
                        },
                      ),
                    ),
                    Container(
                      width: distanceSmall,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Center(
                        child: Ink(
                          decoration: ShapeDecoration(
                            color: canSend
                                ? positiveColor
                                : Theme.of(context).disabledColor,
                            shape: const CircleBorder(),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.send,
                              size: iconSizeTiny,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            onPressed: canSend ? addMessage : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
