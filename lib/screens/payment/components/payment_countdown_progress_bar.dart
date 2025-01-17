import 'package:flutter/material.dart';
import 'dart:async';

import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class PaymentCountdownProgressBar extends StatefulWidget {
  // final int durationInSeconds;
  final String expirationDate;
  final double size;
  final Color progressColor;
  final Function() onExpired;

  const PaymentCountdownProgressBar({
    Key? key,
    // this.durationInSeconds = 240, // 4 minutes in seconds
    required this.expirationDate,
    required this.onExpired,
    this.size = 100.0,
    this.progressColor = successColor, // Material Green
  }) : super(key: key);

  @override
  State<PaymentCountdownProgressBar> createState() =>
      _PaymentCountdownProgressBarState();
}

class _PaymentCountdownProgressBarState
    extends State<PaymentCountdownProgressBar> {
  late Timer _timer;
  late DateTime _expirationDateTime;
  late int _totalSeconds;
  int _currentSeconds = 0;
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    // Parse expiration date
    _expirationDateTime = DateTime.parse(widget.expirationDate);
    final now = DateTime.now();

    // Calculate total duration in seconds
    final duration = _expirationDateTime.difference(now);
    _totalSeconds = duration.inSeconds;
    _currentSeconds = _totalSeconds;

    if (_currentSeconds <= 0) {
      _isExpired = true;
      widget.onExpired();
    } else {
      startTimer();
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentSeconds > 0) {
          _currentSeconds--;
        } else {
          _isExpired = true;
          _timer.cancel();
          widget.onExpired();
        }
      });
    });
  }

  String get timeString {
    if (_isExpired) return '0:00';

    final minutes = (_currentSeconds ~/ 60).toString();
    final seconds = (_currentSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    if (!_isExpired) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: defaultPadding,
            right: defaultPadding,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: widget.size,
                height: widget.size,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular Progress Indicator
                    SizedBox(
                      width: widget.size,
                      height: widget.size,
                      child: CircularProgressIndicator(
                        value: _isExpired ? 0 : _currentSeconds / _totalSeconds,
                        strokeWidth: 4.0,
                        backgroundColor: widget.progressColor.withOpacity(0.2),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(widget.progressColor),
                      ),
                    ),
                    // Timer Text
                    Text(
                      timeString,
                      style: TextStyle(
                        fontSize: widget.size * 0.25,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              CustomText(
                _isExpired
                    ? 'Tempo expirado'
                    : 'Confirme o pagamento\nno seu telemóvel.',
                color: Color(0xFF718096),
                fontSize: 14,
                height: 1.3,
                fontWeight: FontWeight.w500,
                maxLines: 2,
                softWrap: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: defaultPadding),
        const Divider(
          color: whiteColor,
          thickness: 6,
        ),
      ],
    );
  }
}
