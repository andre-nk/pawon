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
        padding: EdgeInsets.fromLTRB(
          Spacers.l28,
          Spacers.l28,
          Spacers.l28,
          12
        ),
        child: Wrap(
          children: [
            Center(
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
                SizedBox(height: Spacers.m16),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: this.negativeFunction,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacers.m16,
                            vertical: Spacers.s8
                          ),
                          child: Text(
                            this.negativeText,
                            style: Font.textLRegular.copyWith(
                              color: ColorModel.primaryRed
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: this.positiveFunction,
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith((states) => ColorModel.kBlue.withOpacity(0.05)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacers.m16,
                            vertical: Spacers.s8
                          ),
                          child: Text(
                            this.positiveText,
                            style: Font.textLRegular.copyWith(
                              color: ColorModel.kBlue
                            ),
                          ),
                        ),
                      )
                    )
                  ]
                )
              ],
            )
          ),]
        )
      )
    );
  }
}