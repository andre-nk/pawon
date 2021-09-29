part of "pages.dart";

class PlanCreatorPage extends StatefulWidget {

  final DateTime planCreatorDate;
  const PlanCreatorPage({ Key? key, required this.planCreatorDate}) : super(key: key);

  @override
  _PlanCreatorPageState createState() => _PlanCreatorPageState();
}

class _PlanCreatorPageState extends State<PlanCreatorPage> {

  TextEditingController _searchController = TextEditingController();
  Map<String, int> planCreatorRecipes = {};

  @override
  Widget build(BuildContext context) {  

    print(planCreatorRecipes);

    Widget recipePicker(){
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: Spacers.m16,
            ).copyWith(
              bottom: 0
            ),
            height: MediaQuery.of(context).size.height * 0.875,
            child: BlocBuilder<RecipeCubit, RecipeState>(
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
                          state is RecipeLoaded
                          ? StreamBuilder<List<RecipeModel>>(
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
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Spacers.s12,
                                          ).copyWith(
                                            top: 12
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      PageTransition(child: RecipePage(recipe: snapshot.data![index]), type: PageTransitionType.rightToLeftWithFade)
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            clipBehavior: Clip.antiAlias,
                                                            height: 52,
                                                            width: 52,
                                                            decoration: BoxDecoration(
                                                              color: ColorModel.disabledRed,
                                                              borderRadius: Spacers.borderRadius
                                                            ),
                                                            child: Image.network(snapshot.data![index].coverURL ?? "", fit: BoxFit.cover)
                                                          ),
                                                          SizedBox(width: 20),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            snapshot.data![index].title,
                                                            style: Font.textLRegular
                                                          ),
                                                          Column(
                                                            children: [
                                                              SizedBox(height: Spacers.s8),
                                                              Text(
                                                                snapshot.data![index].cookTime ?? " Belum ada keterangan",
                                                                style: Font.incLRegular.copyWith(
                                                                  color: ColorModel.majorText
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ]
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children:[
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                    child: InkWell(
                                                      child: Icon(
                                                        Ionicons.remove,
                                                        size: 18,
                                                        color: ColorModel.majorText
                                                      ),
                                                      onTap: (){
                                                        if (planCreatorRecipes[snapshot.data![index].id] == 0){
                                                          setState(() {
                                                            planCreatorRecipes[snapshot.data![index].id] = planCreatorRecipes[snapshot.data![index].id]!;
                                                          });
                                                        } else if (planCreatorRecipes[snapshot.data![index].id] != null){
                                                          setState(() {
                                                            planCreatorRecipes[snapshot.data![index].id] = planCreatorRecipes[snapshot.data![index].id]! - 1;
                                                          });
                                                        } 
                                                      }
                                                    ),
                                                  ),
                                                  Text("${planCreatorRecipes[snapshot.data![index].id] ?? "0"}", style: Font.textLRegular),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20.0),
                                                    child: InkWell(
                                                      child: Icon(
                                                        Ionicons.add,
                                                        size: 18,
                                                        color: ColorModel.majorText
                                                      ),
                                                      onTap: (){
                                                        if(planCreatorRecipes[snapshot.data![index].id] == null){
                                                          setState(() {
                                                            planCreatorRecipes[snapshot.data![index].id] = 1;
                                                          });
                                                        } else if (planCreatorRecipes[snapshot.data![index].id] != null && planCreatorRecipes[snapshot.data![index].id] == 99){
                                                          setState(() {
                                                            planCreatorRecipes[snapshot.data![index].id] = planCreatorRecipes[snapshot.data![index].id]!;
                                                          });
                                                        } else if (planCreatorRecipes[snapshot.data![index].id] != null){
                                                          setState(() {
                                                            planCreatorRecipes[snapshot.data![index].id] = planCreatorRecipes[snapshot.data![index].id]! + 1;
                                                          });
                                                        }
                                                      }
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  );
                                } else {
                                  return SizedBox();
                                }
                              }
                            ) 
                          : SizedBox()
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 350,
                        margin: EdgeInsets.only(bottom: Spacers.l32),
                        child: BlocConsumer<PlanCubit, PlanState>(
                          listener: (context, state){
                            if(state is PlanFailed){
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                  content: state.toString(),
                                  icon: Icon(
                                    Ionicons.information_circle_outline,
                                    color: ColorModel.kBlue,
                                  ),
                                )
                              );
                            }
                          },
                          builder: (context, state) {
                            return PrimaryButton(
                              content: "Tambahkan Rencana Masak",
                              isGoogleButton: false,
                              isMinified: false,
                              isCTA: false,
                              isHovering: true,
                              onPressed: (){
                                context.read<PlanCubit>().createPlan(
                                  recipes: planCreatorRecipes,
                                  dateTime: widget.planCreatorDate
                                );
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar(
                                    content: "Rencana masak berhasil dibuat",
                                    icon: Icon(
                                      Ionicons.information_circle_outline,
                                      color: ColorModel.kBlue,
                                    ),
                                  )
                                );
                              }
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            )
          )
        ]
      );
    }
  
    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                title: "RENCANA",
                leftButton: "Batal",
                leftButtonMethod: (){
                  Navigator.pop(context);
                }
              ),
              SingleChildScrollView(
                child: recipePicker()
              )
            ],
          )
        ),
      ),
    );
  }
}