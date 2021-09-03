part of "widgets.dart";

class PrimaryButton extends StatelessWidget {

  final String content;
  final bool isGoogleButton;
  final bool isCTA;
  final Function() onPressed;
  const PrimaryButton({
    Key? key,
    required this.content,
    required this.isGoogleButton,
    required this.isCTA,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: isGoogleButton
      ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Ionicons.logo_google, color: ColorModel.kWhite),
            SizedBox(width: Spacers.s8),
            Text(
              this.content,
              style: Font.textLMedium.copyWith(
                color: this.isCTA ? ColorModel.kWhite : ColorModel.majorText,
              ),
            ),
          ],
        )
      : Text(
          this.content,
          style: Font.textLMedium.copyWith(
            color: this.isCTA ? ColorModel.kWhite : ColorModel.majorText,
          ),
        ),
      style: ElevatedButton.styleFrom(
        primary: this.isCTA ? ColorModel.primaryRed : ColorModel.kWhite,
        padding: EdgeInsets.only(
          top: Spacers.m16,
          bottom: 18,
          left: this.isGoogleButton ? 56 : 84,
          right: this.isGoogleButton ? 56 : 84
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: this.isCTA ? Colors.transparent : ColorModel.kText),
          borderRadius: Spacers.borderRadius
        )
      ),
    );
  }
}