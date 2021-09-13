part of "widgets.dart";

class InstructionsStepTile extends StatefulWidget {
  
  final String title;
  final Function() onTap;
  const InstructionsStepTile({ Key? key, required this.title, required this.onTap }) : super(key: key);

  @override
  _InstructionsStepTileState createState() => _InstructionsStepTileState();
}

class _InstructionsStepTileState extends State<InstructionsStepTile> with AnimationMixin{
  
  bool checkboxValue = false;
  late Animation<double> checkboxOpacity;

  @override
  void initState() {
    checkboxOpacity = 0.0.tweenTo(1.0).animatedBy(controller);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCheckbox(
          value: checkboxValue,
          onChanged: (value){
            setState(() {
              checkboxValue = value;
            });
          },
        ),
        SizedBox(width: Spacers.m24),
        Expanded(
          flex: 2,
          child: InkWell(
            highlightColor: ColorModel.disabledRed.withOpacity(0.2),
            splashColor: ColorModel.disabledRed.withOpacity(0.2),
            onTap: widget.onTap,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: Spacers.m16,
                top: Spacers.s8
              ),
              child: Text(
                widget.title,
                style: Font.textMRegular.copyWith(
                  height: 1.75,
                  decoration: checkboxValue ? TextDecoration.lineThrough : TextDecoration.none
                )
              ),
            ),
          ),
        ),
      ],
    );
  }
}