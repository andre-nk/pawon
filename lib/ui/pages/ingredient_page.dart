part of "pages.dart";

class IngredientPage extends StatefulWidget {
  const IngredientPage({ Key? key }) : super(key: key);

  @override
  _IngredientPageState createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      appBar: PreferredSize(
        child: CustomAppBar(
          title: "BAHAN",
          leftButton: "Batal",
          rightButton: "Lanjut",
          rightButtonMethod: (){

          },
          leftButtonMethod: (){
            Navigator.pop(context);
          }
        ),
        preferredSize: Size.fromHeight(68.0),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Spacers.m24),
        child: ListView(
          children: [
            Text(
              "Bahan - bahan untuk memasak resep:",
              style: Font.incLRegular,
            ),
            SizedBox(height: Spacers.m16),
            Column(
              children: List.generate(3, (index){
                return Column(
                  children: [
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: ColorModel.kBorder,
                    ),
                    DualListTile(
                      title: "Ayam Cabe Garam",
                      trailing: "${index + 1} porsi"
                    ),
                  ],
                );
              })
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: ColorModel.kBorder,
            ),
            SizedBox(height: Spacers.m16),
            Column(
              children: List.generate(3, (index){
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Spacers.s4,
                      ),
                      child: CheckBoxListTile(
                        title: "Ayam Cabe Garam",
                        subtitle: "200 gram",
                        isTrailed: true
                      ),
                    )
                  ],
                );
              })
            ),
          ]
        )
      )
    );
  }
}