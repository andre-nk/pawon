part of "widgets.dart";

class CreateRecipeBottomsheet extends StatelessWidget {
  const CreateRecipeBottomsheet({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      margin: EdgeInsets.only(
        bottom: 20
      ),
      width: double.infinity,
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, PageTransition(child: CreateRecipePage(), type: PageTransitionType.rightToLeftWithFade));
              },
              contentPadding: EdgeInsets.symmetric(
                vertical: Spacers.s4,
                horizontal: Spacers.m24,
              ),
              title: Text(
                "Buat resep manual",
                style: Font.textMRegular
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: Spacers.s4,
                horizontal: Spacers.m24,
              ),
              title: Text(
                "Buat resep otomatis (Instagram / foto)",
                style: Font.textMRegular
              ),
            ),
          ]
        ).toList(),
      )
    );
  }
}