part of 'pages.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({ Key? key }) : super(key: key);

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {

  final scaffoldState = GlobalKey<ScaffoldState>();

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
              SizedBox(height: Spacers.s4,),
              Text(
                "mau masak apa hari ini?",
                style: Font.incLMedium,
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                tooltip: "Kalendar",
                padding: EdgeInsets.zero,
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (context){
                      return Container(
                        color: ColorModel.kWhite,
                        height: Device.size.width > 768 ? 500 : 400,
                        child: Column(
                          children: [
                            CustomAppBar(
                              title: "TANGGAL",
                              leftButton: "Batal",
                              rightButton: "Pilih",
                              rightButtonMethod: (){},
                              leftButtonMethod: (){
                                Navigator.pop(context);
                              }
                            ),
                            Expanded(
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (date){
                                  print(date);
                                }
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  );
                },
                icon: Icon(
                  Ionicons.calendar_clear_outline,
                  color: ColorModel.majorText
                ),
              ),
              SizedBox(width: Spacers.s12),
              IconButton(
                tooltip: "Tambah Rencana",
                padding: EdgeInsets.zero,
                onPressed: (){
                  print(Device.size.width);
                  if(Device.size.width > 1440){
                    scaffoldState.currentState!.openEndDrawer();
                  } else {
                    showModalBottomSheet(
                      constraints: BoxConstraints(
                        minHeight: 900,
                      ),
                      context: context, 
                      builder: (context){
                        return Container(
                          
                        );
                      }
                    );
                  }
                },
                icon: Icon(
                  Ionicons.add_circle_outline,
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
                tooltip: "Kalendar",
                padding: EdgeInsets.zero,
                onPressed: (){},
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
            height: 3 * 65,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: ColorModel.kBorder)
              )
            ),
            child: ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index){
                return Container(
                  height: 1,
                  width: double.infinity,
                  color: ColorModel.kBorder,
                );
              },
              itemBuilder: (context, index){
                return DualListTile(title: "Ayam Cabe Garam", trailing: "${index + 1} porsi");
              },
            )
          ),
        ],
      );
    }

    return Scaffold(
      key: scaffoldState,
      drawerEnableOpenDragGesture: false,
      backgroundColor: ColorModel.kWhite,
      endDrawer: Drawer(
        child: Padding(
          padding: EdgeInsets.all(Spacers.m24),
          child: Column(
            children: [
              Text("abc")
            ]
          )
        )
      ),
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
                SizedBox(height: Spacers.l32),
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