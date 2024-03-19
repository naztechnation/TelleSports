import 'package:flutter/material.dart';

/// Widget that will check password strength and display validation messages
class PasswordStrengthChecker extends StatefulWidget {
  const PasswordStrengthChecker({
    Key? key,
    required this.password,
    required this.onStrengthChanged,
  }) : super(key: key);

  /// Password value: obtained from a text field
  final String password;

  /// Callback that will be called when password strength changes
  final Function(bool isStrong) onStrengthChanged;

  @override
  State<PasswordStrengthChecker> createState() =>
      _PasswordStrengthCheckerState();
}

class _PasswordStrengthCheckerState extends State<PasswordStrengthChecker> {
  /// Override didUpdateWidget to re-validate password strength when the value
  /// changes in the parent widget
  @override
  void didUpdateWidget(covariant PasswordStrengthChecker oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Check if the password value has changed
    if (widget.password != oldWidget.password) {
      /// If changed, re-validate the password strength
      final isStrong = _validators.entries.every(
        (entry) => entry.key.hasMatch(widget.password),
      );

      /// Call callback with new value to notify parent widget
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => widget.onStrengthChanged(isStrong),
      );
    }
  }

  /// Map of validators to be used to validate the password.
  ///
  /// Key: RegExp to check if the password contains a certain character type
  /// Value: Validation message to be displayed
  ///
  /// Note: You can add, remove, or change validators as per your requirements
  /// and if you are not good with RegExp, (most of us aren't), you can get help
  /// from Bard or ChatGPT to generate RegExp and validation messages.
  final Map<RegExp, String> _validators = {
    RegExp(r'[A-Z]'): 'One uppercase letter',
    RegExp(r'[!@#\$%^&*(),.?":{}|<>]'): 'One special character',
    RegExp(r'\d'): 'One number',
    RegExp(r'^.{8,32}$'): '8-32 characters',
  };

  @override
  Widget build(BuildContext context) {
    final hasValue = widget.password.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _validators.entries.map(
            (entry) {
              final hasMatch = entry.key.hasMatch(widget.password);
              final barColor = hasMatch ? Colors.green : Colors.red;
              final barWidth = MediaQuery.of(context).size.width *
                  (_validators.length / (_validators.length + 1));

              return Expanded(
                child: Container(
                  width: barWidth,
                  
                  height: 8,
                  decoration: BoxDecoration(
                    color: hasValue ? barColor : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: const EdgeInsets.only(right: 4),
                ),
              );
            },
          ).toList(),
        ),
        SizedBox(height: 8), // Add some space between bars and validation messages
        ..._validators.entries.map(
          (entry) {
            final hasMatch = entry.key.hasMatch(widget.password);
            final color = hasValue ? (hasMatch ? Colors.green : Colors.red) : null;
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                entry.value,
                style: TextStyle(color: color),
              ),
            );
          },
        ).toList(),
      ],
    );
  }
}
