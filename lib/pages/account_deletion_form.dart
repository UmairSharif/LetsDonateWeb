import 'package:flutter/material.dart';
import 'package:lets_donate_web/constants/app_colors.dart';
import 'package:lets_donate_web/common/checkbox_item.dart';
import 'package:lets_donate_web/common/text_input_widget.dart';
import 'package:lets_donate_web/services/authentication.dart';
import 'package:lets_donate_web/services/donation_service.dart';
import 'package:lets_donate_web/services/user_service.dart';
import 'package:lets_donate_web/utils/validators.dart';

import '../common/custom_alert_dialog.dart';
import '../common/password_input_widget.dart';
import '../common/primary_button.dart';

class AccountDeletionForm extends StatefulWidget {
  const AccountDeletionForm({super.key});

  @override
  _AccountDeletionFormState createState() => _AccountDeletionFormState();
}

class _AccountDeletionFormState extends State<AccountDeletionForm> {
  final DonationService donationService = DonationService();
  final UserService userService = UserService();
  final BaseAuth auth = Auth();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailErrorText;
  String? _passwordErrorText;
  bool isLoading = false;
  bool isTermAccepted = false;
  bool isDeleted = false;

  bool _isValidEmail() {
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailErrorText = "Email is required";
      });
      return false;
    } else if (!Validators.isEmailValid(_emailController.text)) {
      setState(() {
        _emailErrorText = "Enter a valid email";
      });
      return false;
    } else {
      setState(() {
        _emailErrorText = null;
      });
      return true;
    }
  }

  bool _isValidPassword() {
    if (_passwordController.text.length < 6) {
      setState(() {
        _passwordErrorText = "Password must be 6 characters long";
      });
      return false;
    }

    setState(() {
      _passwordErrorText = null;
    });
    return true;
  }

  void setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void setIsDeleted(bool value) {
    setState(() {
      isDeleted = value;
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_isValidEmail() && _isValidPassword() && isTermAccepted) {
      try {
        setIsLoading(true);
        await _deletePressed();
        setIsLoading(false);
        setIsDeleted(true);
      } catch (e) {
        setIsLoading(false);
        _showAlert(message: 'Error deleting your account: $e');
      }
    }
  }

  void _showAlert({String title = 'Error', required String message}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(title: title, message: message);
        });
  }

  Future<void> _deletePressed() async {
    try {
      // 0 - reauthenticate the user
      final userId =
          await auth.signIn(_emailController.text, _passwordController.text);
      // 1 - delete donations of user
      await donationService.deleteAllDonationForOwnerId(userId!);
      // 2 - delete user from firestore
      await userService.removeItem(userId);
      // 3 - delete user from firebase auth
      await auth.deleteUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 600,
          width: 600,
          child: isDeleted
              ? const Text(
                  "Your account has been deleted successfully!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("LetsDonate",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                fontSize: 40,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              height: 14,
                              width: 14,
                              decoration: BoxDecoration(
                                  color: AppColors.primary.value,
                                  borderRadius: BorderRadius.circular(7.0)),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        TextInputWidget(
                            hint: 'Email',
                            textController: _emailController,
                            icon: 'assets/images/icon_message.png',
                            inputType: TextInputType.emailAddress,
                            errorText: _emailErrorText),
                        const SizedBox(height: 20),
                        PasswordInputWidget(
                            hint: 'Password',
                            passwordController: _passwordController,
                            icon: 'assets/images/square-lock.png',
                            errorText: _passwordErrorText),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 20),
                          child: CheckboxItem(
                            isSelected: isTermAccepted,
                            text:
                                'I accept that my account information will be deleted permanently, and all associated data will be irreversibly removed from the system.',
                            onChanged: (p0) {
                              setState(() {
                                isTermAccepted = p0;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: PrimaryButton(
                              title: 'Request Account Deletion',
                              isLoading: isLoading,
                              onPressed: () => _submitForm(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
