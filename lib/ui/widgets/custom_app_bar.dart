part of "widgets.dart";

class CustomAppBar extends StatelessWidget {

  final String title;
  final String leftButton;
  final String? rightButton;
  final Function() leftButtonMethod;
  final Function()? rightButtonMethod;
  final bool? rightButtonCTA;

  const CustomAppBar({ Key? key, required this.title, required this.leftButton, this.rightButton, required this.leftButtonMethod, this.rightButtonMethod, this.rightButtonCTA}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorModel.kWhite,
      elevation: 0,
      leadingWidth: 100,
      toolbarHeight: 68,
      leading: Container(
        height: double.infinity,
        margin: EdgeInsets.only(
          left: Spacers.m16,
          top: Spacers.m16,
          bottom: Spacers.m16,
        ),
        child: Center(
          child: TextButton(
            onPressed: this.leftButtonMethod,
            style: ElevatedButton.styleFrom(
              onSurface: ColorModel.disabledRed,
              primary: ColorModel.kWhite,
              shape: RoundedRectangleBorder(
                borderRadius: Spacers.borderRadius,
                side: BorderSide(color: ColorModel.kText)
              )
            ),
            child: Center(
              child: Text(
                this.leftButton,
                style: Font.textSRegular.copyWith(
                  color: ColorModel.majorText
                ),
              )
            )
          ),
        ),
      ),
      title: this.rightButton != null
      ? Container(
          height: 64,
          width: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              this.title,
              style: Font.headingXS.copyWith(
                letterSpacing: 7.5,
                color: ColorModel.majorText
              )
            ),
          ),
        )
      : SizedBox(),
      centerTitle: this.rightButton != null,
      actions: [
        this.rightButton != null
        ? Container(
            width: 80,
            height: double.infinity,
            margin: EdgeInsets.only(
              right: Spacers.m16,
              top: Spacers.m16,
              bottom: Spacers.m16  
            ),
            child: Center(
              child: TextButton(
                onPressed: this.rightButtonMethod,
                style: ElevatedButton.styleFrom(
                  onSurface: ColorModel.disabledRed,
                  primary: this.rightButtonCTA != null && this.rightButtonCTA == true
                    ? ColorModel.primaryRed
                    : ColorModel.kWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: Spacers.borderRadius,
                    side: this.rightButtonCTA != null && this.rightButtonCTA == true
                    ? BorderSide.none
                    : BorderSide(color: ColorModel.kText),
                  )
                ),
                child: Center(
                  child: Text(
                    this.rightButton ?? "",
                    style: Font.textSRegular.copyWith(
                      color: this.rightButtonCTA != null && this.rightButtonCTA == true
                      ? ColorModel.kWhite
                      : ColorModel.majorText,
                    ),
                  )
                )
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.only(
              right: Spacers.m16,
            ),
            height: double.infinity,
            child: Center(
              child: Text(
                this.title,
                style: Font.headingXS.copyWith(
                  letterSpacing: 7.5,
                  color: ColorModel.majorText
                )
              ),
            ),
          )
      ],
    );
  }
}