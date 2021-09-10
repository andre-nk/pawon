part of "pages.dart";

class StepPage extends StatefulWidget {
  const StepPage({ Key? key }) : super(key: key);

  @override
  _StepPageState createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> {
  @override
  Widget build(BuildContext context) {

    PreferredSize customAppBar(String title){
      return PreferredSize(
        child: CustomAppBar(
          title: title,
          leftButton: "Kembali",
          rightButton: "Lanjut",
          rightButtonMethod: (){
            Navigator.push(context, PageTransition(child: InstructionPage(), type: PageTransitionType.rightToLeftWithFade));
          },
          leftButtonMethod: (){
            Navigator.pop(context);
          }
        ),
        preferredSize: Size.fromHeight(68.0),
      );
    }

    Widget content(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Resep untuk Ayam Cabe Garam:",
            style: Font.incLMedium
          ),
          SizedBox(height: Spacers.s8),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            style: Font.textMRegular.copyWith(
              height: 1.75
            )
          ),
          SizedBox(height: 36),
        ]
      );
    }

    Widget calendarPicker(){
      return Container(
        color: ColorModel.kWhite,
        height: 350,
        child: Column(
          children: [
            CustomAppBar(
              title: "TIMER",
              leftButton: "Batal",
              rightButton: "Pilih",
              rightButtonMethod: (){},
              leftButtonMethod: (){
                Navigator.pop(context);
              }
            ),
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    pickerTextStyle: Font.incXLMedium.copyWith(
                      color: ColorModel.majorText
                    )
                  ),
                ),
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hms,
                  onTimerDurationChanged: (val){

                  },
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget timerButton(){
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 72
        ),
        alignment: Alignment.center,
        child: TextButton(
          onPressed: (){
            showModalBottomSheet(
              context: context,
              builder: (context){
                return calendarPicker();
              }
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 12,
            ),
            primary: ColorModel.kWhite,
            shape: RoundedRectangleBorder(
              borderRadius: Spacers.borderRadius,
              side: BorderSide(color: ColorModel.kBorder)
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Ionicons.timer_outline,
                color: ColorModel.majorText,
              ),
              SizedBox(width: Spacers.m16),
              Text(
                "Aktifkan timer",
                style: Font.textMRegular.copyWith(
                  color: ColorModel.majorText
                ),
              ),
            ],
          )
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      appBar: customAppBar("STEP-1"),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Spacers.m24,
          vertical: Spacers.s8
        ),
        children: [
          content(),
          timerButton()
        ]
      ),
    );
  }
}