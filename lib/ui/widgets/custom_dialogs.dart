part of "widgets.dart";

class CustomDialog extends StatelessWidget {

  final String title;
  final String content;
  final String negativeText;
  final String positiveText;
  final Function() negativeFunction;
  final Function() positiveFunction;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.negativeText,
    required this.positiveText,
    required this.negativeFunction,
    required this.positiveFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: ColorModel.kWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide(color: ColorModel.kText)
      ),
      child: Container(
        height: 210,
        width: double.infinity - 100,
        padding: EdgeInsets.symmetric(
          vertical: Spacers.l28,
          horizontal: Spacers.l28
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    this.title,
                    style: Font.headingS,
                  ),
                  SizedBox(height: Spacers.s12),
                  Text(
                    this.content,
                    style: Font.textMRegular.copyWith(
                      height: 1.5
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: Spacers.s12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: this.negativeFunction,
                    child: Text(
                      this.negativeText,
                      style: Font.textLRegular.copyWith(
                        color: ColorModel.activeRed
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: this.positiveFunction,
                    child: Text(
                      this.positiveText,
                      style: Font.textLMedium.copyWith(
                        color: ColorModel.kBlue
                      ),
                    ),
                  )
                ]
              )
            ],
          )
        )
      )
    );
  }
}