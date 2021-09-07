part of "widgets.dart";

class CheckBoxListTile extends StatefulWidget {

  final String title;
  final String subtitle;
  final String? imageURL;
  final bool? isTrailed;
  const CheckBoxListTile({ Key? key, required this.title, required this.subtitle, this.imageURL, this.isTrailed }) : super(key: key);

  @override
  State<CheckBoxListTile> createState() => _CheckBoxListTileState();
}
class _CheckBoxListTileState extends State<CheckBoxListTile> {

  bool checkboxValue = false;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Spacers.m16
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
              SizedBox(width: 20),
              widget.imageURL != null && widget.imageURL != ""
              ? Row(
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: ColorModel.disabledRed,
                        borderRadius: Spacers.borderRadius
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                )
              : SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Font.textLRegular
                  ),
                  widget.isTrailed == null || widget.isTrailed == false
                  ? Column(
                      children: [
                        SizedBox(height: Spacers.s8),
                        Text(
                            widget.subtitle,
                            style: Font.incMRegular.copyWith(
                              color: ColorModel.majorText
                            ),
                          ),
                      ],
                    )
                  : SizedBox()
                ]
              ),
            ],
          ),
          widget.isTrailed != null || widget.isTrailed == true 
          ? Text(
              widget.subtitle,
              style: Font.incMRegular.copyWith(
                color: ColorModel.majorText
              ),
            )
          : SizedBox()
        ],
      ),
    );
  }
}