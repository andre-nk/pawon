part of "widgets.dart";

class CheckBoxListTile extends StatelessWidget {

  final String title;
  final String subtitle;
  const CheckBoxListTile({ Key? key, required this.title, required this.subtitle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Spacers.m16
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: ColorModel.kGreen,
              borderRadius: Spacers.borderRadius,
            ),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Icon(
                Ionicons.checkmark_outline,
                size: 16,
                color: ColorModel.kWhite
              ),
            ) 
          ),
          SizedBox(width: 20),
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: ColorModel.disabledRed,
              borderRadius: Spacers.borderRadius
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: Spacers.s8),
                child: Text(
                  "Ayam Cabe Garam",
                  style: Font.textLRegular
                ),
              ),
              Text(
                "25 menit; 233x dimasak",
                style: Font.incMRegular.copyWith(
                  color: ColorModel.majorText
                ),
              ), 
            ]
          )
        ],
      ),
    );
  }
}