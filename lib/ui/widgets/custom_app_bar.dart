part of "widgets.dart";

class CustomAppBar extends StatelessWidget {

  final String title;
  final String leftButton;
  final String? rightButton;
  final Function() leftButtonMethod;
  final Function()? rightButtonMethod;

  const CustomAppBar({ Key? key, required this.title, required this.leftButton, this.rightButton, required this.leftButtonMethod, this.rightButtonMethod}) : super(key: key);

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
      : SizedBox(),
      centerTitle: this.rightButton != null,
      actions: [
        this.rightButton != null
        ? Container(
            width: 80,
            height: double.infinity,
            margin: EdgeInsets.all(Spacers.m16),
            child: Center(
              child: TextButton(
                onPressed: this.rightButtonMethod,
                style: ElevatedButton.styleFrom(
                  primary: ColorModel.kWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: Spacers.borderRadius,
                    side: BorderSide(color: ColorModel.kText)
                  )
                ),
                child: Center(
                  child: Text(
                    this.rightButton ?? "",
                    style: Font.textSRegular.copyWith(
                      color: ColorModel.majorText
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