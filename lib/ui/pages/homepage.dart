part of "pages.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AnimationMixin {
  late Animation<double> searchOpacity;
  late Animation<double> searchOffset;

  @override
  void initState() {
    context.read<PlanCubit>().fetchSinglePlan(DateTime.now());
    context.read<RecipeCubit>().fetchRecipes();
    searchOpacity = 0.0.tweenTo(1.0).animatedBy(controller);
    searchOffset = (-50.0).tweenTo(0.0).animatedBy(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final TextEditingController _searchController = TextEditingController();

    Widget errorWidget(String content){
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
                content,
                style: Font.incLRegular
              ),
            ],
          )
        ),
      );
    }

    Widget header({required String name, required String profileURL}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Halo, $name!",
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
              tooltip: "Notifikasi",
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Stack(
                children: [
                  Icon(Ionicons.notifications_outline,
                      color: ColorModel.majorText),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        color: ColorModel.activeRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: Spacers.m24),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: ProfilePage(),
                        type: PageTransitionType.rightToLeftWithFade));
              },
              child: Container(
                  clipBehavior: Clip.antiAlias,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: ColorModel.disabledRed,
                    borderRadius: Spacers.borderRadius,
                  ),
                  child: CachedNetworkImage(imageUrl: profileURL)),
            )
          ])
        ],
      );
    }

    Widget todayPlan() {
      return BlocConsumer<PlanCubit, PlanState>(
        listener: (context, state){
          if(state is PlanFailed){
            print(state.error);
          }
        },
        builder: (context, state) {
          if(state is PlanLoaded){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hari ini",
                  style: Font.textMRegular.copyWith(color: ColorModel.kText)
                ),
                SizedBox(height: Spacers.s12),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: ColorModel.kBorder))
                  ),
                  child: StreamBuilder<List<PlanModel>>(
                    stream: state.plan,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        if (snapshot.data!.length == 0) {
                          return errorWidget("Kamu belum membuat rencana masak!");
                        } else {
                          return ListView.separated(
                            itemCount: snapshot.data!.length,
                            separatorBuilder: (context, index) {
                              return Container(
                                height: 1,
                                width: double.infinity,
                                color: ColorModel.kBorder,
                              );
                            },
                            itemBuilder: (context, index) {
                              var recipeEntity = snapshot.data!.first.recipes.entries.toList();
                              context.watch<RecipeCubit>().fetchRecipe(recipeEntity[index].key);
                              return BlocBuilder<RecipeCubit, RecipeState>(
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
                              );
                            },
                          );
                        }
                      } else {
                        return errorWidget("Kamu belum membuat rencana masak!");
                      }
                    }
                  ),
                ),
                SizedBox(height: Spacers.s12),
                Align(
                  alignment: Alignment.center,
                  child: StreamBuilder<List<PlanModel>>(
                    stream: state.plan,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        if(snapshot.data!.length == 0){
                          return PrimaryButton(
                            content: "Buat rencana masak hari ini",
                            isMinified: true,
                            isGoogleButton: false,
                            isCTA: false,
                            onPressed: () {
                              print("wishes");
                              context.read<PageCubit>().setPage(1);
                            }
                          );
                        } else {
                          return PrimaryButton(
                            content: "Mulai masak (est. ±55 menit)",
                            isMinified: true,
                            isGoogleButton: false,
                            isCTA: false,
                            onPressed: () {}
                          );
                        }
                      } else {
                        return PrimaryButton(
                          content: "Buat rencana masak hari ini",
                          isMinified: true,
                          isGoogleButton: false,
                          isCTA: false,
                          onPressed: () {
                            print("wishes");
                            context.read<PageCubit>().setPage(1);
                          }
                        );
                      }
                    } 
                  ),
                )
              ],
            );
          } else if (state is PlanLoading) {
            return Center(
              child: CustomLoaderPage()
            );
          } else {
            return errorWidget("Kamu belum membuat rencana masak!");
          }
        },
      );
    }

    Widget userRecipes() {
      return BlocConsumer<RecipeCubit, RecipeState>(
        listener: (context, state) {
          if(state is RecipeFailed){
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content: state.error,
                icon: Icon(
                  Ionicons.alert_circle_outline,
                  color: ColorModel.primaryRed,
                ),
              )
            );
          }
        },
        builder: (context, state) {
          if(state is RecipeLoaded){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Resep kamu",
                  style: Font.textMRegular.copyWith(color: ColorModel.kText)
                ),
                SizedBox(height: Spacers.s12),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: ColorModel.kBorder))
                  ),
                  child: StreamBuilder<List<RecipeModel>>(
                    stream: state.recipes,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        if(snapshot.data!.length == 0){
                          return errorWidget("Kamu belum membuat resep!");
                        } else {
                          return Column(
                            children: List.generate(snapshot.data!.length, (index) {
                              return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (axis){
                                  showDialog(
                                    context: context,
                                    builder: (context){
                                      return CustomDialog(
                                        title: "Hapus resep ini?", 
                                        content: "Penghapusan resep tidak dapat dikembalikan", 
                                        negativeText: "Batal",
                                        positiveText: "Hapus",
                                        negativeFunction: (){
                                          Navigator.pop(context);
                                        },
                                        positiveFunction: (){
                                          Navigator.pop(context);
                                          setState(() {
                                            context.read<RecipeCubit>().deleteRecipe(snapshot.data![index].id);
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            customSnackBar(
                                              content: "Resep berhasil dihapus",
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
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      PageTransition(child: RecipePage(recipe: snapshot.data![index]), type: PageTransitionType.rightToLeftWithFade)
                                    );
                                  },
                                  child: PhotoListTile(
                                    photoURL: snapshot.data![index].coverURL ?? "",
                                    title: snapshot.data![index].title,
                                    subtitle: "${snapshot.data![index].cookTime}; ${snapshot.data![index].cookedTime}x dimasak",
                                  ),
                                ),
                              );}
                            )
                          );
                        }
                      } else {
                        return SizedBox();
                      }
                    }
                  )
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            print(state.error);
          }
        },
        builder: (context, state) {
          if (state is AuthSuccess) {
            return SafeArea(
              child: NotificationListener(
                onNotification: (t) {
                  if (t is ScrollEndNotification) {
                    if (_scrollController.position.pixels >=
                      MediaQuery.of(context).size.height * 0.15) {
                      controller.play(duration: 250.milliseconds);
                    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
                      controller.playReverse(duration: 250.milliseconds);
                    }
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: EdgeInsets.all(Spacers.l32),
                        child: Column(children: [
                          header(
                            name: state.user.name.split(" ")[0].trim(),
                            profileURL: state.user.profileURL
                          ),
                          SizedBox(height: Spacers.l28),
                          todayPlan(),
                          SizedBox(height: Spacers.m24),
                          userRecipes(),
                        ]),
                      ),
                    ),
                    searchOpacity.value == 0.0
                    ? SizedBox()
                    : Positioned(
                        child: Opacity(
                          opacity: searchOpacity.value,
                          child: Padding(
                            padding: EdgeInsets.all(Spacers.l32),
                            child: CustomForms(
                              isSearchForm: true,
                              placeholder: "Cari resep kamu disini",
                              controller: _searchController,
                              isObscured: false
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                height: 50,
                width: 50,
                child: Image.asset("assets/404_egg.png")
              )
            );
          }
        },
      )
    );
  }
}
