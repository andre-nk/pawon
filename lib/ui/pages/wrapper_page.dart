part of "pages.dart";

class WrapperPage extends StatelessWidget {
  const WrapperPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int index){
      return PlanPage();
    }

    Widget customNavigationBar(){
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 64,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorModel.kWhite,
            boxShadow: [
              BoxShadow(
                color: ColorModel.kBlack.withOpacity(0.1),
                offset: Offset(0, -10),
                blurRadius: 80,
                spreadRadius: 20
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Ionicons.home,
                  color: ColorModel.primaryRed
                ),
              ),
              IconButton(
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (context){
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
                  );
                },
                icon: Icon(
                  Ionicons.add_circle_outline,
                  size: 28,
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Ionicons.document_text_outline,
                  color: ColorModel.majorText
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 64.0),
            child: buildContent(0),
          ),
          customNavigationBar()
        ],
      )
    );
  }
}