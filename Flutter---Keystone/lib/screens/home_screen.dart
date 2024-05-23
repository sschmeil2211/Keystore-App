// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keystore/models/models.dart';
import 'package:keystore/providers/providers.dart';
import 'package:keystore/services/auth_service.dart';

import 'package:keystore/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PasswordProvider passwordProvider = Provider.of<PasswordProvider>(context, listen: false);

    return CustomBackground(
      floatingButton: FloatingActionButton(
        onPressed: () => showCupertinoModalPopup(
          barrierColor: Colors.black87,
          context: context,
          builder: (context) => const NewPasswordModal()
        ),
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFFF58428),
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Color(0xFFFFFFFF),
          size: 32,
        ),
      ),
      title: '',
      leadingWidth: double.infinity,
      leading: const ProfileHeader(),
      child: passwordProvider.passwords != null ? ListView(
        children: List.generate(passwordProvider.passwords!.length, (index) => PasswordBox(
          platformName: passwordProvider.passwords![index].platformName,
          passwordID: passwordProvider.passwords![index].id,
        )).toList(),
      ) : Container()
    );
  }
}

class PasswordBox extends StatefulWidget {
  final String platformName;
  final String passwordID;

  const PasswordBox({
    required this.platformName,
    required this.passwordID,
    super.key
  });

  @override
  State<PasswordBox> createState() => _PasswordBoxState();
}

class _PasswordBoxState extends State<PasswordBox> {
  bool isObscured = true;

  String decryptedPassword = '';

  void _updatePassword(String password) {
    setState(() {
      decryptedPassword = password;
      isObscured = !isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1B2C57),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.platformName,
                  style: const TextStyle(color: Color(0xFFFFFFFF)),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context){
                        List<String> enteredNumbers = [];
                        return StatefulBuilder(
                          builder: (context, setState){

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

                            return Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.5, 0.8],
                                  colors: [
                                    Color(0xFF101B38),
                                    Color(0xFF06031C),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    PinNumbers(enteredNumbers: enteredNumbers),
                                    CustomKeyboard(
                                      onDeletePressed: deleteLast,
                                      onKeyPressed: (value) {
                                        updatePin(
                                            value,
                                            onPinComplete: (value) async {
                                              ControllersProvider controllersProvider = Provider.of<ControllersProvider>(context, listen: false);
                                              controllersProvider.pin = value;
                                              bool isValid = await Provider.of<UserProvider>(context, listen: false).validatePin(controllersProvider.pin);
                                              if(!isValid) return;
                                              if(!context.mounted) return;
                                              String pass = await Provider.of<PasswordProvider>(context, listen: false).getDecryptedPassword(widget.passwordID) ?? 'Invalid Pin';
                                              _updatePassword(pass);
                                              if(!context.mounted) return;
                                              Navigator.of(context).pop();
                                            }
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        );
                      }
                    );
                  },
                  child: Icon(
                    isObscured ? FontAwesomeIcons.eyeLowVision : FontAwesomeIcons.eye,
                    color: const Color(0xFFF58428),
                  ),
                )
              ]
            ),
            if(!isObscured)
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  decryptedPassword,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class NewPasswordModal extends StatelessWidget {
  const NewPasswordModal({super.key});

  @override
  Widget build(BuildContext context) {
    ControllersProvider controllersProvider = Provider.of<ControllersProvider>(context, listen: false);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          color: const Color(0xFF101B38),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: TitleText(title: 'New Password'),
                  ),
                  CustomInput(
                    controller: controllersProvider.newPlatform,
                    inputName: 'Platform',
                    hint: 'Enter your Platform Name',
                    icon: FontAwesomeIcons.globe,
                  ),
                  CustomInput(
                    controller: controllersProvider.newPlatformPassword,
                    inputName: 'Password',
                    hint: 'Enter your Password',
                    icon: FontAwesomeIcons.lock,
                    passwordInput: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100, bottom: 30),
                    child: LargeButton(
                        label: 'SAVE',
                        onPressed: () {
                          Provider.of<PasswordProvider>(context, listen: false).addPassword(
                            Password(
                              id: 'asd',
                              userId: AuthService().userID,
                              platformName: controllersProvider.newPlatform.text,
                              password: controllersProvider.newPlatformPassword.text
                            )
                          );
                          controllersProvider.newPlatform = TextEditingController();
                          controllersProvider.newPlatformPassword = TextEditingController();
                          Provider.of<PasswordProvider>(context, listen: false).getAllPasswords();
                          Navigator.of(context).pop();
                        }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
