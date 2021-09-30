part of 'pages.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  DateTime planCreatorDate = DateTime.now();
  Map<String, int> planCreatorRecipes = {};

  @override
  void initState() {
    super.initState();
    context.read<PlanCubit>().fetchPlans();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    Widget calendarPicker(String source) {
      return Container(
        color: ColorModel.kWhite,
        height: 500,
        child: Column(
          children: [
            CustomAppBar(
                title: "TANGGAL",
                leftButton: "Batal",
                rightButton: source == "Plan Creator" ? "Lanjut" : "Pilih",
                rightButtonMethod: () {
                  if (source == "Plan Creator") {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageTransition(
                            child: PlanCreatorPage(
                                planCreatorDate: planCreatorDate),
                            type: PageTransitionType.rightToLeftWithFade));
                  }
                },
                leftButtonMethod: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: Font.incXLRegular),
                ),
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (date) {
                      if (source == "Plan Creator") {
                        print(date);
                        setState(() {
                          planCreatorDate = date;
                        });
                      } else {
                        print(date);
                      }
                    }),
              ),
            ),
          ],
        ),
      );
    }

    Widget header() {
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
              SizedBox(
                height: Spacers.s4,
              ),
              Text(
                "mau masak apa hari ini?",
                style: Font.incLMedium,
              )
            ],
          ),
          Row(children: [
            IconButton(
              tooltip: "Kalendar",
              padding: EdgeInsets.zero,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return calendarPicker("");
                    });
              },
              icon: Icon(Ionicons.calendar_clear_outline,
                  color: ColorModel.majorText),
            ),
            SizedBox(width: Spacers.s12),
            IconButton(
              tooltip: "Tambah Rencana",
              padding: EdgeInsets.zero,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return calendarPicker("Plan Creator");
                    });
              },
              icon: Icon(Ionicons.add_circle_outline,
                  color: ColorModel.majorText, size: 26),
            ),
          ])
        ],
      );
    }

    Widget todayPlan(PlanModel planModel) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                planModel.dateTime.day == DateTime.now().day
                ? "Hari ini"
                : planModel.dateTime.day == DateTime.now().subtract(1.days).day
                  ? "Kemarin"
                  : DateFormat.yMMMMd('id').format(planModel.dateTime),
                style: Font.textMRegular.copyWith(color: ColorModel.kText)
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: "Mulai sesi",
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: IngredientPage(),
                          type: PageTransitionType.rightToLeftWithFade
                        )
                      );
                    },
                    icon: Icon(
                      Ionicons.play_circle_outline,
                      size: 24, color: ColorModel.primaryRed
                    ),
                  ),
                  IconButton(
                    tooltip: "Hapus rencana",
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context){
                          return CustomDialog(
                            title: "Hapus rencana masak?", 
                            content: "Penghapusan rencana masak tidak dapat dikembalikan", 
                            negativeText: "Batal",
                            positiveText: "Hapus",
                            negativeFunction: (){
                              Navigator.pop(context);
                            },
                            positiveFunction: (){
                              Navigator.pop(context);
                              context.read<PlanCubit>().deletePlan(planModel.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                  content: "Rencana masak berhasil dihapus!",
                                  icon: Icon(
                                    Ionicons.information_circle_outline,
                                    color: ColorModel.kBlue,
                                  ),
                                )
                              );
                            }
                          );
                        }
                      );
                    },
                    icon: Icon(
                      Ionicons.trash_bin_outline,
                      size: 22, color: ColorModel.primaryRed
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Spacers.s4),
          Container(
            width: double.infinity,
            child: Column(
              children: List.generate(planModel.recipes.length, (index) {
                var recipeEntity = planModel.recipes.entries.toList();
                context.watch<RecipeCubit>().fetchRecipe(recipeEntity[index].key);
                return Column(
                  children: [
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: ColorModel.kBorder,
                    ),
                    BlocBuilder<RecipeCubit, RecipeState>(
                      builder: (context, state) {
                        if(state is SingleRecipeLoaded){
                          return StreamBuilder<RecipeModel>(
                            stream: state.recipe,
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return InkWell(
                                  onTap: (){
                                     Navigator.push(
                                      context,
                                      PageTransition(
                                        child: RecipePage(recipe: snapshot.data),
                                        type: PageTransitionType.rightToLeftWithFade
                                      )
                                    ); 
                                  },
                                  child: DualListTile(
                                    title: snapshot.data!.title,
                                    trailing: "${recipeEntity[index].value} porsi"
                                  ),
                                ); 
                              } else {
                                return SizedBox();
                              }
                            }
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    )
                  ],
                );
              })
            )
          ),
        ],
      );
    }

    Widget errorWidget(){
      return Container(  
        child: Center(
          heightFactor: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 125,
                width: 125,
                child: Image.asset("assets/404_egg.png")
              ),
              SizedBox(height: Spacers.s8),
              Text(
                "Kamu belum membuat rencana masak,",
                style: Font.incLRegular
              ),
              SizedBox(height: Spacers.s8),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "tekan tombol",
                    style: Font.incLRegular
                  ),
                  SizedBox(width: Spacers.s8),
                  Icon(
                    Ionicons.add_circle_outline,
                    color: ColorModel.majorText,
                    size: 24
                  ),
                  SizedBox(width: Spacers.s8),
                  Text(
                    "untuk membuat!",
                    style: Font.incLRegular
                  ),
                ],
              )
            ],
          )
        ),
      );
    }

    return Scaffold(
      key: scaffoldState,
      drawerEnableOpenDragGesture: false,
      backgroundColor: ColorModel.kWhite,
      endDrawer: Drawer(
          child: Padding(
              padding: EdgeInsets.all(Spacers.m24),
              child: Column(children: [Text("abc")]))),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Spacers.l28, vertical: Spacers.l32),
          child: Column(
            children: [
              header(),
              SizedBox(height: Spacers.l32),
              BlocConsumer<PlanCubit, PlanState>(
                listener: (context, state){
                  if(state is PlanFailed){
                    print(state.error);
                  }
                },
                builder: (context, state) {
                  if(state is PlanLoaded){
                    return StreamBuilder<List<PlanModel>>(
                      stream: state.plan,
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          if (snapshot.data!.length == 0) {
                            return errorWidget();
                          } else {
                            return Column(
                              children: List.generate(snapshot.data!.length, (index) {
                                return todayPlan(snapshot.data![index]);
                              }
                            ));
                          }
                        } else {
                          return errorWidget();
                        }
                      }
                    );
                  } else if (state is PlanLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: ColorModel.primaryRed)
                    );
                  } else {
                    return errorWidget();
                  }
                },
              )
            ],
          ),
        )),
      )
    );
  }
}
