// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:keystore/models/models.dart';
import 'package:keystore/providers/providers.dart';
import 'package:keystore/utils/texts.dart';

import 'package:keystore/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  List<String> enteredNumbers = [];

  void updatePin(String value, {required Function(String) onPinComplete}) {
    if (enteredNumbers.length < 6)
      setState(() => enteredNumbers.add(value));
    if (enteredNumbers.length == 6)
      onPinComplete(enteredNumbers.join(''));
  }

  void deleteLast() {
    if (enteredNumbers.isNotEmpty)
      setState(() => enteredNumbers.removeLast());
  }

  @override
  Widget build(BuildContext context) {
    final PinScreenType args = ModalRoute.of(context)?.settings.arguments as PinScreenType;
    ControllersProvider controllersProvider = Provider.of<ControllersProvider>(context, listen: false);

    return CustomBackground(
      title: title(args),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 90, bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PinNumbers(enteredNumbers: enteredNumbers),
                  CustomKeyboard(
                    onKeyPressed: (value) {
                      updatePin(
                        value,
                        onPinComplete: (value) async {
                          if(args == PinScreenType.create) {
                            controllersProvider.pin = value;
                            Navigator.of(context).pushNamed('pinScreen', arguments:  PinScreenType.verify);
                          }
                          else if(args == PinScreenType.verify) {
                            controllersProvider.verifiedPin = value;
                            if(controllersProvider.pin != controllersProvider.verifiedPin) return;
                            controllersProvider.pin = '';
                            Navigator.of(context).pushNamed('seedScreen');
                          }
                          else{
                            controllersProvider.pin = value;
                            bool pinValidated = await Provider.of<UserProvider>(context, listen: false).validatePin(controllersProvider.pin);
                            if(!pinValidated) return;
                            if(!context.mounted) return;
                            Navigator.of(context).pushNamed('homeScreen');
                          }
                      }
                      );
                    },
                    onDeletePressed: deleteLast,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

