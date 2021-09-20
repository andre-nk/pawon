part of "widgets.dart";

class PhotoListTile extends StatelessWidget {
  
  final String photoURL;
  final String title;
  final String subtitle;
  const PhotoListTile({ Key? key, required this.photoURL, required this.title, required this.subtitle }) : super(key: key);

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
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: ColorModel.disabledRed,
          borderRadius: Spacers.borderRadius
        ),
        child: CachedNetworkImage(
          imageUrl: this.photoURL,
          fit: BoxFit.cover
        )
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: Spacers.s8),
        child: Text(
          this.title,
          style: Font.textLRegular
        ),
      ),
      subtitle: Text(
        this.subtitle,
        style: Font.incMRegular.copyWith(
          color: ColorModel.majorText
        ),
      ),
    );
  }
}