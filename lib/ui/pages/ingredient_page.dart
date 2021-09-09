part of "pages.dart";

class IngredientPage extends StatefulWidget {
  const IngredientPage({ Key? key }) : super(key: key);

  @override
  _IngredientPageState createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  Widget build(BuildContext context) {

    Widget planRecipes(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
        ]
      );
    }

    Widget planIngredients(){
      return Column(
        children: List.generate(100, (index){
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
      );
    }

    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      appBar: PreferredSize(
        child: CustomAppBar(
          title: "BAHAN",
          leftButton: "Batal",
          rightButton: "Lanjut",
          rightButtonMethod: (){
            Navigator.push(context, PageTransition(child: InstructionPage(), type: PageTransitionType.rightToLeftWithFade));
          },
          leftButtonMethod: (){
            Navigator.pop(context);
          }
        ),
        preferredSize: Size.fromHeight(68.0),
      ),
      body: OrientationBuilder(
        builder: (context, axis) {
          print(axis);
          return axis == Orientation.portrait
          ? Container(
              width: double.infinity,
              padding: EdgeInsets.all(Spacers.m24),
              child: ListView(
                children: [
                  planRecipes(),
                  SizedBox(height: Spacers.m16),
                  planIngredients(),
                ]
              ),
            )
          : Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: Spacers.m16,
                horizontal: Spacers.m24
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 9,
                    child: ListView(
                      children: [
                        planRecipes(),
                      ],
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 9,
                    child: ListView(
                      children: [
                        planIngredients(),
                      ],
                    ),
                  )
                ],
              ),
          );
        }
      )
    );
  }
}