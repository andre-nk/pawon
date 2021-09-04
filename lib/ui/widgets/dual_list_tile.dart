part of "widgets.dart";

class DualListTile extends StatelessWidget {

  final String title;
  final String trailing;
  const DualListTile({ Key? key, required this.title, required this.trailing }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: Spacers.s4,
        horizontal: 0
      ),
      title: Text(
        this.title,
        style: Font.textMRegular
      ),
      trailing: Text(
        this.trailing,
        style: Font.textMRegular.copyWith(
          color: ColorModel.majorText
        ),
      ),
    );
  }
}