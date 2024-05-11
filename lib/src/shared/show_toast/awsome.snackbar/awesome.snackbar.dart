import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/extensions/extensions.dart';

// class AssetsPath {
//   static const String help = 'assets/types/help.svg';
//   static const String failure = 'assets/types/failure.svg';
//   static const String success = 'assets/types/success.svg';
//   static const String warning = 'assets/types/warning.svg';

//   static const String back = 'assets/types/back.svg';
//   static const String bubbles = 'assets/types/bubbles.svg';
// }

class DefaultColors {
  /// help
  static const Color helpBlue = Color(0xff3282B8);

  /// failure
  static const Color failureRed = Color(0xffc72c41);

  /// success
  static const Color successGreen = Color(0xff2D6A4F);

  /// warning
  static const Color warningYellow = Color(0xffFCA652);
}

/// to handle failure, success, help and warning `ContentType` class is being used
class MessageType {
  /// message is `required` parameter
  final String message;

  /// color is optional, if provided null then `DefaultColors` will be used
  final Color? color;

  MessageType(this.message, [this.color]);

  static MessageType help = MessageType('Message', DefaultColors.helpBlue);
  static MessageType failure = MessageType('Failed', DefaultColors.failureRed);
  static MessageType success =
      MessageType('Success', DefaultColors.successGreen);
  static MessageType warning =
      MessageType('Warning', DefaultColors.warningYellow);
}

class AwesomeSnackbarContent extends StatelessWidget {
  /// message String is the body message which shows only 2 lines at max
  final String message;

  /// contentType will reflect the overall theme of SnackBar/MaterialBanner: failure, success, help, warning
  final MessageType messageType;

  const AwesomeSnackbarContent({
    super.key,
    required this.message,
    required this.messageType,
  });

  @override
  Widget build(BuildContext context) {
    /// For reflecting different color shades in the SnackBar
    final hsl = HSLColor.fromColor(messageType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    return Row(
      children: [
        context.isScreenDesktop ? const Spacer() : const SizedBox(width: 20),
        Expanded(
          flex: context.isScreenDesktop ? 4 : 1,
          // flex: 1,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              /// SnackBar Body
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: context.isScreenDesktop ? context.width * 0.1 : 0,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: context.isScreenDesktop
                      ? context.width * 0.1
                      : context.width * 0.05,
                  vertical: context.isScreenDesktop
                      ? context.height * 0.03
                      : context.height * 0.025,
                ),
                decoration: BoxDecoration(
                  color: messageType.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: context.isScreenMobile ? 8 : 25,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// `title` parameter
                              Expanded(
                                flex: 3,
                                child: Text(
                                  messageType.message,
                                  style: TextStyle(
                                    fontSize: context.isScreenDesktop
                                        ? context.height * 0.03
                                        : context.height * 0.025,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar(),
                                child: SvgPicture.asset(
                                  'assets/types/failure.svg',
                                  height: context.height * 0.022,
                                ),
                              ),
                            ],
                          ),

                          /// `message` body text parameter
                          Text(
                            message,
                            style: TextStyle(
                              fontSize: context.height * 0.016,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// other SVGs in body
              Positioned(
                bottom: 0,
                left: context.isScreenDesktop ? context.width * 0.1 : 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    'assets/types/bubbles.svg',
                    height: context.height * 0.06,
                    width: context.width * 0.05,
                    colorFilter: hslDark.toColor().toColorFilter,
                  ),
                ),
              ),

              Positioned(
                top: -context.height * 0.02,
                left: context.isScreenDesktop
                    ? context.width * 0.125
                    : context.width * 0.02,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/types/back.svg',
                      height: context.height * 0.06,
                      colorFilter: hslDark.toColor().toColorFilter,
                    ),
                    Positioned(
                      top: context.height * 0.015,
                      child: SvgPicture.asset(
                        assetSVG(messageType),
                        height: context.height * 0.022,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        context.isScreenDesktop ? const Spacer() : const SizedBox(width: 20),
      ],
    );
  }

  /// Reflecting proper icon based on the contentType
  String assetSVG(MessageType messageType) {
    if (messageType == MessageType.failure) {
      /// failure will show `CROSS`
      return 'assets/types/failure.svg';
    } else if (messageType == MessageType.success) {
      /// success will show `CHECK`
      return 'assets/types/success.svg';
    } else if (messageType == MessageType.warning) {
      /// warning will show `EXCLAMATION`
      return 'assets/types/warning.svg';
    } else if (messageType == MessageType.help) {
      /// help will show `QUESTION MARK`
      return 'assets/types/help.svg';
    } else {
      return 'assets/types/failure.svg';
    }
  }
}
