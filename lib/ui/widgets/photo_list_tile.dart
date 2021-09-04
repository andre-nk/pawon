part of "widgets.dart";

class PhotoListTile extends StatelessWidget {
  
  // final String photoURL;
  final String title;
  final String subtitle;
  const PhotoListTile({ Key? key, required this.title, required this.subtitle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: Spacers.s4,
        horizontal: 0
      ),
      leading: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          color: ColorModel.disabledRed,
          borderRadius: Spacers.borderRadius
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: Spacers.s8),
        child: Text(
          "Ayam Cabe Garam",
          style: Font.textLRegular
        ),
      ),
      subtitle: Text(
        "25 menit; 233x dimasak",
        style: Font.incMRegular.copyWith(
          color: ColorModel.majorText
        ),
      ),
    );
  }
}