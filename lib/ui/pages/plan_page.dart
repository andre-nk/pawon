part of 'pages.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({ Key? key }) : super(key: key);

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {

  final scaffoldState = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  DateTime planCreatorDate = DateTime.now();
  List<RecipeModel> pickedRecipes = [];

  @override
  Widget build(BuildContext context) {

    print(pickedRecipes);

    Widget recipePicker(){
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Spacers.l28,
              vertical: Spacers.l32,
            ).copyWith(
              bottom: 0
            ),
            height: MediaQuery.of(context).size.height * 0.8,
            child: BlocConsumer<RecipeCubit, RecipeState>(
              builder: (context, state){
                return Stack(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 8,
                                child: CustomForms(
                                  isSearchForm: false,
                                  placeholder: "Cari resep kamu disini",
                                  controller: _searchController,
                                  isObscured: false
                                ),
                              ),
                              SizedBox(width: Spacers.m16),
                              IconButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context){
                                      return CreateRecipeBottomsheet();
                                    }
                                  );
                                },
                                icon: Icon(
                                  Ionicons.add_circle_outline,
                                  size: 28,
                                  color: ColorModel.majorText
                                )
                              )
                            ],
                          ),
                          SizedBox(height: Spacers.m16),
                          if(state is RecipeLoaded)
                          StreamBuilder<List<RecipeModel>>(
                            stream: state.recipes,
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return Expanded(
                                  flex: 8,
                                  child: ListView.separated(
                                    itemCount: snapshot.data!.length,
                                    separatorBuilder: (context, index){
                                      return Container(
                                        height: 1,
                                        width: double.infinity,
                                        color: ColorModel.kBorder,
                                      ); 
                                    },
                                    itemBuilder: (context, index){
                                      return CheckBoxListTile(
                                        imageURL: snapshot.data![index].coverURL,
                                        recipeModel: snapshot.data![index],
                                        title: snapshot.data![index].title,
                                        subtitle: "${snapshot.data![index].cookTime}; ${snapshot.data![index].cookedTime}x dimasak",
                                      );
                                    },
                                  )
                                );
                              } else {
                                return SizedBox();
                              }
                            }
                          ) else 
                          SizedBox()
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 350,
                        margin: EdgeInsets.only(bottom: Spacers.l32),
                        child: PrimaryButton(
                          content: context.watch<RecipePickerCubit>().state.length == 0
                          ? "Tambahkan Rencana"
                          : "Tambahkan Rencana (${context.watch<RecipePickerCubit>().state.length} resep) ",
                          isGoogleButton: false,
                          isMinified: false,
                          isCTA: false,
                          isHovering: true,
                          onPressed: (){}
                        ),
                      ),
                    )
                  ],
                );
              },
              listener: (context, state){

              }
            )
          )
        ]
      );
    }

    Widget calendarPicker(String source){
      return Container(
        color: ColorModel.kWhite,
        height: 500,
        child: Column(
          children: [
            CustomAppBar(
              title: "TANGGAL",
              leftButton: "Batal",
              rightButton: source == "Plan Creator" ? "Lanjut" : "Pilih",
              rightButtonMethod: (){
                if(source == "Plan Creator"){
                  Navigator.pop(context);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context){
                      return recipePicker();
                    }
                  );
                }
              },
              leftButtonMethod: (){
                Navigator.pop(context);
              }
            ),
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: Font.incXLRegular
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (date){
                    if(source == "Plan Creator"){
                      print(date);
                      setState(() {
                        planCreatorDate = date;
                      });
                    } else {
                      print(date);
                    }
                  }
                ),
              ),
            ),
          ],
        ),
      );
    }

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
                      return calendarPicker("");
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
                  showModalBottomSheet(
                    context: context,
                    builder: (context){
                      return calendarPicker("Plan Creator");
                    }
                  );
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