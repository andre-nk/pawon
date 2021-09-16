part of "widgets.dart";

SnackBar customSnackBar({required String content, required Icon icon}){
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    backgroundColor: ColorModel.kWhite,
    shape: RoundedRectangleBorder(
      borderRadius: Spacers.borderRadius,
      side: BorderSide(color: ColorModel.kText),
    ),
    margin: EdgeInsets.symmetric(
      horizontal: Spacers.m16,
      vertical: Spacers.m24,
    ),
    padding: EdgeInsets.symmetric(horizontal: Spacers.m16, vertical: 20),
    content: Row(
      children: [
        icon,
        SizedBox(width: 12),
        Expanded(
          flex: 5,
          child: Text(
            content.indexOf("]") >= 0
            ? content.substring(content.indexOf("]") + 2, content.length)
            : content,
            style: Font.textMRegular.copyWith(
              color: ColorModel.majorText
            )
          ),
        ),
      ],
    )
  );
}