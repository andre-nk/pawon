part of "pages.dart";

class HistoryPage extends StatelessWidget {
  const HistoryPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget header(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rencana Masak",
                style: Font.headingS,
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                tooltip: "Tambah Rencana",
                padding: EdgeInsets.zero,
                onPressed: (){
                 
                },
                icon: Icon(
                  Ionicons.trash_outline,
                  color: ColorModel.majorText,
                  size: 26
                ),
              ),
            ]
          )
        ],
      );
    }

    Widget todayPlan(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hari ini",
                style: Font.textMRegular.copyWith(
                  color: ColorModel.kText
                )
              ),
              IconButton(
                tooltip: "Mulai sesi",
                padding: EdgeInsets.zero,
                onPressed: (){
                  Navigator.push(context, PageTransition(child: IngredientPage(), type: PageTransitionType.rightToLeftWithFade));
                },
                icon: Icon(
                  Ionicons.play_circle_outline,
                  size: 24,
                  color: ColorModel.primaryRed
                ),
              ),
            ],
          ),
          SizedBox(height: Spacers.s4),
          Container(
            width: double.infinity,
            child: Column(
              children: List.generate(5, (index){
                return Column(
                  children: [
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: ColorModel.kBorder,
                    ),
                    DualListTile(title: "Ayam Cabe Garam", trailing: "${index + 1} porsi")
                  ],
                );
              })
            )
          ),
        ],
      );
    }

    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: ColorModel.kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacers.l28,
              vertical: Spacers.l32
            ),
            child: Column(
              children: [
                header(),
                SizedBox(height: Spacers.m16),
                Column(
                  children: List.generate(3, (index){
                    return todayPlan();
                  }),
                )
              ],
            ),
          )
        ),
      )
    );
  }
}