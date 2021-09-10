part of "pages.dart";

  class InstructionPage extends StatefulWidget {
  const InstructionPage({ Key? key }) : super(key: key);

  @override
  _InstructionPageState createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage>{

  List<int> activePanel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      appBar: PreferredSize(
        child: CustomAppBar(
          title: "INSTRUKSI",
          leftButton: "Batal",
          leftButtonMethod: (){
            Navigator.pop(context);
          }
        ),
        preferredSize: Size.fromHeight(68.0),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: Spacers.s8,
          horizontal: Spacers.m16
        ),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index){
            return ExpansionTile(
              textColor: ColorModel.primaryRed,
              title: Text(
                "Ayam Cabe Garam",
                style: Font.textLMedium.copyWith(
                  color: activePanel.indexOf(index) > -1 ? ColorModel.primaryRed : ColorModel.kBlack
                )
              ),
              childrenPadding: EdgeInsets.all(Spacers.m16).copyWith(top: 0, bottom: Spacers.m16),
              expandedCrossAxisAlignment: CrossAxisAlignment.center,
              expandedAlignment: Alignment.topLeft,
              children: [
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  style: Font.textMRegular.copyWith(
                    height: 1.75
                  )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Spacers.s4,
                  ),
                  child: InstructionsStepTile(
                    title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                    onTap: (){
                      Navigator.push(context, PageTransition(child: StepPage(), type: PageTransitionType.rightToLeftWithFade));
                    },
                  ),
                )
              ],
              onExpansionChanged: (value){
                if(value){
                  setState(() {
                    activePanel.add(index);
                  });
                } else {
                  setState(() {
                    activePanel.remove(index);
                  });
                }
              },
              trailing: activePanel.indexOf(index) > -1
              ? FadeIn(
                  child: Icon(
                    Ionicons.chevron_up,
                    color: ColorModel.primaryRed,
                    size: 20
                  ),
                )
              : FadeIn(
                  child: Icon(
                    Ionicons.chevron_down,
                    color: ColorModel.majorText,
                    size: 20
                  ),
                )
            );
          },
        )
      )
    );
  }
}