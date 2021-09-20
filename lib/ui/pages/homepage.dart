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
    context.read<RecipeCubit>().fetchRecipes();
    searchOpacity = 0.0.tweenTo(1.0).animatedBy(controller);
    searchOffset = (-50.0).tweenTo(0.0).animatedBy(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final TextEditingController _searchController = TextEditingController();

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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hari ini",
              style: Font.textMRegular.copyWith(color: ColorModel.kText)),
          SizedBox(height: Spacers.s12),
          Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: ColorModel.kBorder))),
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) {
                  return Container(
                    height: 1,
                    width: double.infinity,
                    color: ColorModel.kBorder,
                  );
                },
                itemBuilder: (context, index) {
                  return DualListTile(
                      title: "Ayam Cabe Garam", trailing: "${index + 1} porsi");
                },
              )),
          SizedBox(height: Spacers.s12),
          Align(
            alignment: Alignment.center,
            child: PrimaryButton(
                content: "Mulai masak (est. ±55 menit)",
                isMinified: true,
                isGoogleButton: false,
                isCTA: false,
                onPressed: () {}),
          )
        ],
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
                        return Column(
                          children: List.generate(snapshot.data!.length, (index) {
                              return PhotoListTile(
                                photoURL: snapshot.data![index].coverURL ?? "",
                                title: snapshot.data![index].title,
                                subtitle: "${snapshot.data![index].cookTime}; ${snapshot.data![index].cookedTime}x dimasak",
                              );
                            }
                          )
                        );
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
                              isObscured: false),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      )
    );
  }
}
