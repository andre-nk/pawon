part of "pages.dart";

class RecipePage extends StatefulWidget {

  final RecipeModel? recipe;
  const RecipePage({Key? key, this.recipe}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController instructionCtrl = TextEditingController();
  TextEditingController servingsCtrl = TextEditingController();
  TextEditingController prepTimeCtrl = TextEditingController();
  TextEditingController cookTimeCtrl = TextEditingController();
  List<Map<String, TextEditingController>> ingredientCtrls = [
    {"title": TextEditingController(), "amount": TextEditingController()},
    {"title": TextEditingController(), "amount": TextEditingController()},
    {"title": TextEditingController(), "amount": TextEditingController()},
  ];
  List<TextEditingController> stepCtrls = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  bool isEditing = false;
  XFile? pickedFile;

  @override
  void initState() {
    super.initState();
    if(widget.recipe != null){
      isEditing = false;
      titleCtrl.text = widget.recipe!.title;
      descriptionCtrl.text = widget.recipe!.description ?? "";
      instructionCtrl.text = widget.recipe!.instructionDescription ?? "";
      servingsCtrl.text = widget.recipe!.servings ?? "";
      prepTimeCtrl.text = widget.recipe!.prepsTime ?? "";
      cookTimeCtrl.text = widget.recipe!.cookTime ?? "";
      ingredientCtrls = widget.recipe!.ingredients.map((ingredient){
        return {
          "title": TextEditingController(text: ingredient["title"]),
          "amount": TextEditingController(text: ingredient["amount"])
        };
      }).cast<Map<String, TextEditingController>>().toList();
      stepCtrls = widget.recipe!.instructionSteps.map((step){
        return TextEditingController(text: step);
      }).cast<TextEditingController>().toList();
    } else {
      isEditing = true;
    }
  }

  PreferredSize customAppBar(){
    return PreferredSize(
      child: CustomAppBar(
        title: "RESEP",
        leftButton: "Batal",
        rightButton: isEditing ? "Simpan" : "Edit",
        rightButtonCTA: isEditing,
        rightButtonMethod: () {
          if(isEditing && widget.recipe == null){
            context.read<RecipeCubit>().createRecipe(
              cover: pickedFile,
              title: titleCtrl.text,
              ingredients: ingredientCtrls.map((ingredient){
                return {
                  "title": ingredient["title"]!.text,
                  "amount": ingredient["amount"]!.text
                };
              }).toList(),
              instructionSteps: stepCtrls.map((step){
                return step.text;
              }).toList(),
              description: descriptionCtrl.text,
              instructionDescription: instructionCtrl.text,
              servings: servingsCtrl.text,
              prepsTime: prepTimeCtrl.text,
              cookTime: cookTimeCtrl.text
            );
          } else if(isEditing && widget.recipe != null){
            context.read<RecipeCubit>().updateRecipe(
              id: widget.recipe!.id,
              cover: pickedFile,
              coverURL: widget.recipe!.coverURL,
              title: titleCtrl.text,
              ingredients: ingredientCtrls.map((ingredient){
                return {
                  "title": ingredient["title"]!.text,
                  "amount": ingredient["amount"]!.text
                };
              }).toList(),
              instructionSteps: stepCtrls.map((step){
                return step.text;
              }).toList(),
              description: descriptionCtrl.text,
              instructionDescription: instructionCtrl.text,
              servings: servingsCtrl.text,
              prepsTime: prepTimeCtrl.text,
              cookTime: cookTimeCtrl.text
            );
          } else {
            setState(() {
              isEditing = true;
            });
          }
        },
        leftButtonMethod: () {
          Navigator.pop(context);
        }
      ),
      preferredSize: Size.fromHeight(68.0),
    );
  }

  Widget photoBox({required Orientation axis}) {
    return GestureDetector(
      onTap: () {
        if(isEditing){
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                  height: 112,
                  margin: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  child: ListView(
                    children: ListTile.divideTiles(context: context, tiles: [
                      ListTile(
                        onTap: () {
                          context
                          .read<RecipeCubit>()
                          .pickRecipeCover(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        contentPadding: EdgeInsets.symmetric(
                          vertical: Spacers.s4,
                          horizontal: Spacers.m24,
                        ),
                        title: Text("Pilih foto dari Galeri",
                            style: Font.textMRegular),
                      ),
                      ListTile(
                        onTap: () {
                          context
                            .read<RecipeCubit>()
                            .pickRecipeCover(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        contentPadding: EdgeInsets.symmetric(
                          vertical: Spacers.s4,
                          horizontal: Spacers.m24,
                        ),
                        title: Text("Ambil foto dari Kamera",
                            style: Font.textMRegular),
                      ),
                    ]).toList(),
                  ));
            });
        }
      },
      child: DottedBorder(
        color: ColorModel.kText,
        borderType: BorderType.RRect,
        radius: Radius.circular(15),
        dashPattern: [10, 10],
        child: AspectRatio(
          aspectRatio: axis == Orientation.landscape ? 16 / 3 : 16 / 9,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: ColorModel.kWhite,
            ),
            width: double.infinity,
            child: isEditing
            ? pickedFile != null 
              ? Image.file(File(pickedFile!.path), fit: BoxFit.fitWidth)
              : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Ionicons.camera_outline, color: ColorModel.majorText),
                    SizedBox(height: Spacers.s8),
                    Text("Tambahkan foto masakan", style: Font.textSRegular)
                  ]
                ),
              ) 
            : widget.recipe!.coverURL != null || widget.recipe!.coverURL != ""
              ? Image.network(widget.recipe!.coverURL ?? "", fit: BoxFit.fitWidth)
              : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Ionicons.camera_outline, color: ColorModel.majorText),
                    SizedBox(height: Spacers.s8),
                    Text("Tambahkan foto masakan", style: Font.textSRegular)
                  ]
                ),
              ) 
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Column(children: [
      SizedBox(height: Spacers.s8),
      Container(
        width: double.infinity,
        height: 1,
        color: ColorModel.kBorder,
      ),
      SizedBox(height: Spacers.m24),
    ]);
  }

  Widget addButton(Icon icon, String content, Orientation axis, Function() onTap) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: axis == Orientation.portrait ? 72 : 200
      ),
      alignment: Alignment.center,
      child: TextButton(
        onPressed: (){
          if(isEditing){
            onTap();
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 12,
          ),
          primary: ColorModel.kWhite,
          shape: RoundedRectangleBorder(
              borderRadius: Spacers.borderRadius,
              side: BorderSide(color: ColorModel.kBorder
            )
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: Spacers.m16),
            Text(
              content,
              style: Font.textMRegular.copyWith(color: ColorModel.majorText),
            ),
          ],
        )
      ),
    );
  }

  Widget instructionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Instruksi resep (opsional)", style: Font.incLRegular),
        TextFormField(
          readOnly: !isEditing,
          controller: instructionCtrl,
          style: Font.textLRegular.copyWith(height: 1.75),
          minLines: isEditing == false && widget.recipe!.instructionDescription == "" ? 1 : 3,
          maxLines: 5,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: isEditing
            ? "Ayam cabe garam adalah menu masakan yang sederhana namun kaya rasa. Pedas istimewa, gurih garamnya mengundang selera. Selalu mudah mengundang antrian untuk menikmatinya."
            : "Tidak ada deskripsi",
            hintStyle: Font.textLMedium.copyWith(color: ColorModel.kText)
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Spacers.s12),
          child: Column(
            children: List.generate(stepCtrls.length, (index) {
            return isEditing
            ? Dismissible(
                key: UniqueKey(),
                onDismissed: (axis){
                  setState(() {
                    stepCtrls.removeAt(index);
                  });
                },
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: ColorModel.kBorder,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: Spacers.s4, horizontal: 0),
                      minLeadingWidth: 28,
                      leading: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: ColorModel.kBorder,
                          borderRadius: Spacers.borderRadius,
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: Font.textMRegular)
                          )
                        ),
                      title: TextFormField(
                        readOnly: !isEditing,
                        controller: stepCtrls[index],
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: Font.textLMedium,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ayam Cabai Garam",
                          hintStyle: Font.textLMedium.copyWith(color: ColorModel.kText)
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: ColorModel.kBorder,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: Spacers.s4, horizontal: 0),
                    minLeadingWidth: 28,
                    leading: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: ColorModel.kBorder,
                        borderRadius: Spacers.borderRadius,
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: Font.textMRegular)
                        )
                      ),
                    title: TextFormField(
                      readOnly: !isEditing,
                      controller: stepCtrls[index],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: Font.textLMedium,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Ayam Cabai Garam",
                        hintStyle: Font.textLMedium.copyWith(color: ColorModel.kText)
                      ),
                    ),
                  )
                ],
              );
          })),
        ),
      ]
    );
  }

  Widget ingredientSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Text("Alat dan bahan", style: Font.incLRegular),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Spacers.s12),
          child: Column(
            children: List.generate(ingredientCtrls.length, (index) {
              return isEditing
              ? Dismissible(
                  key: UniqueKey(),
                  onDismissed: (axis){
                    setState(() {
                      ingredientCtrls.removeAt(index);
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: ColorModel.kBorder,
                      ),
                      FormTile(
                        readOnly: !isEditing,
                        title: "Penyajian/Servings",
                        hintText: "1 porsi",
                        secondaryHintText: "Telur Ayam",
                        isDouble: true,
                        controller: ingredientCtrls[index]["title"]!,
                        secondaryController: ingredientCtrls[index]["amount"]!,
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: ColorModel.kBorder,
                    ),
                    FormTile(
                      readOnly: !isEditing,
                      title: "Penyajian/Servings",
                      hintText: "1 porsi",
                      secondaryHintText: "Telur Ayam",
                      isDouble: true,
                      controller: ingredientCtrls[index]["title"]!,
                      secondaryController: ingredientCtrls[index]["amount"]!,
                    ),
                  ],
                );
            })
          ),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    print(isEditing);
    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      body: BlocConsumer<RecipeCubit, RecipeState>(
        listener: (context, state) {
          if (state is RecipeFailed){
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content: state.error,
                icon: Icon(
                  Ionicons.alert_circle_outline,
                  color: ColorModel.primaryRed,
                ),
              )
            );
          } else if (state is RecipeCoverPicked){
            setState(() {
              pickedFile = state.pickedCover;
            });
          } else if (state is RecipeCreated){
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(child: HomePage(), type: PageTransitionType.rightToLeftWithFade),
              (route) => false
            );
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content: widget.recipe == null
                ? "Resep berhasil dibuat!"
                : "Resep berhasil diedit!",
                icon: Icon(
                  Ionicons.checkmark_circle_outline,
                  color: ColorModel.kGreen,
                ),
              )
            );
          }
        },
        builder: (context, state) {
          if(state is RecipeLoading){
            return CustomLoaderPage();
          } else {
            return OrientationBuilder(builder: (context, axis) {
              return Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: Spacers.m16, vertical: Spacers.s8).copyWith(
                      bottom: Spacers.l32,
                      top: 112,
                    ),
                    children: [
                      photoBox(axis: axis),
                      SizedBox(height: Spacers.m24),
                      CustomSimplifiedForm(
                        title: "Judul resep",
                        hintText: "Ayam Cabai Garam",
                        controller: titleCtrl,
                        axis: axis,
                        readOnly: !isEditing
                      ),
                      divider(),
                      CustomSimplifiedForm(
                        title: "Deskripsi resep (ops.)",
                        hintText: "Ayam cabe garam adalah menu masakan yang sederhana namun kaya rasa. Pedas istimewa, gurih garamnya mengundang selera. Selalu mudah mengundang antrian untuk menikmatinya",
                        controller: descriptionCtrl,
                        axis: axis,
                        isMultiline: true,
                        readOnly: !isEditing
                      ),
                      divider(),
                      ingredientSection(),
                      isEditing
                      ? Column(
                          children: [
                            addButton(
                              Icon(
                                Ionicons.add_circle_outline,
                                color: ColorModel.majorText
                              ),
                              "Tambahkan alat / bahan",
                              axis,
                              (){
                                if(isEditing){
                                  setState(() {
                                    ingredientCtrls.add({"title": TextEditingController(), "amount": TextEditingController()});
                                  });
                                }
                              }
                            ),
                            SizedBox(height: Spacers.m16),
                          ],
                        )
                      : SizedBox(),
                      divider(),
                      instructionSection(),
                      isEditing
                      ? Column(
                          children: [
                            addButton(
                              Icon(
                                Ionicons.add_circle_outline,
                                color: ColorModel.majorText
                              ),
                              "Tambahkan langkah",
                              axis,
                              (){
                                if(isEditing){
                                  setState(() {
                                    stepCtrls.add(TextEditingController());
                                  });
                                }
                              }
                            ),
                            SizedBox(height: Spacers.m16),
                          ],
                        )
                      : SizedBox(),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: ColorModel.kBorder,
                      ),
                      FormTile(
                        title: "Penyajian/Servings",
                        hintText: "1 porsi",
                        isDouble: false,
                        controller: servingsCtrl
                      ),
                      FormTile(
                        title: "Waktu persiapan (ops.)",
                        hintText: "5 menit",
                        isDouble: false,
                        controller: prepTimeCtrl
                      ),
                      FormTile(
                        title: "Waktu masak",
                        hintText: "15 menit",
                        isDouble: false,
                        controller: cookTimeCtrl
                      )
                    ]
                  ),
                  Container(
                    height: 100,
                    child: customAppBar()
                  ),
                ],
              );
            });
          }
        },
      )
    );
  }
}
