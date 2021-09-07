part of "widgets.dart";

class CustomCheckbox extends StatefulWidget {

  final bool value;
  final Function(bool) onChanged;
  const CustomCheckbox({ Key? key, required this.value, required this.onChanged }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {

  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _isSelected = !_isSelected;
          widget.onChanged(_isSelected);
        });
      },
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: widget.value ? ColorModel.kGreen : ColorModel.kBorder,
          borderRadius: Spacers.borderRadius,
        ),
        child: Padding(
          padding: EdgeInsets.all(2),
          child: widget.value 
          ? Icon(
              Ionicons.checkmark_outline,
              size: 16,
              color: ColorModel.kWhite
            )
          : SizedBox()
        ) 
      ),
    );
  }
}