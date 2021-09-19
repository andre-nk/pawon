part of "pages.dart";

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({Key? key}) : super(key: key);

  @override
  _CreateRecipePageState createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController instructionCtrl = TextEditingController();
  TextEditingController servingsCtrl = TextEditingController();
  TextEditingController prepTimeCtrl = TextEditingController();
  TextEditingController cookTimeCtrl = TextEditingController();

  PreferredSize customAppBar({XFile? cover}) {
    return PreferredSize(
      child: CustomAppBar(
        title: "RESEP",
        leftButton: "Batal",
        rightButton: "Simpan",
        rightButtonCTA: true,
        rightButtonMethod: () {
          context.read<RecipeCubit>().createRecipe(
            cover: cover,
            title: titleCtrl.text,
            ingredients: [{
              "Ayam": "1 gram"
            }],
            instructionSteps: ["Beli ayam"],
            description: descriptionCtrl.text,
            instructionDescription: instructionCtrl.text,
            servings: servingsCtrl.text,
            prepsTime: prepTimeCtrl.text,
            cookTime: cookTimeCtrl.text
          );
        },
        leftButtonMethod: () {
          Navigator.pop(context);
        }
      ),
      preferredSize: Size.fromHeight(68.0),
    );
  }

  Widget photoBox({required Orientation axis, XFile? cover}) {
    return GestureDetector(
      onTap: () {
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
      },
      child: DottedBorder(
        color: ColorModel.kText,
        borderType: BorderType.RRect,
        radius: Radius.circular(15),
        dashPattern: [10, 10],
        child: AspectRatio(
          aspectRatio: axis == Orientation.landscape ? 16 / 3 : 16 / 9,
          child: Container(
            width: double.infinity,
            color: ColorModel.kWhite,
            child: cover != null 
            ? Image.file(File(cover.path), fit: BoxFit.fitWidth)
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

  Widget addButton(Icon icon, String content, Orientation axis) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: axis == Orientation.portrait ? 72 : 200),
      alignment: Alignment.center,
      child: TextButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 12,
              ),
              primary: ColorModel.kWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: Spacers.borderRadius,
                  side: BorderSide(color: ColorModel.kBorder))),
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
          )),
    );
  }

  Widget instructionSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Instruksi resep (opsional)", style: Font.incLRegular),
      TextFormField(
        controller: instructionCtrl,
        style: Font.textLRegular.copyWith(height: 1.75),
        minLines: 3,
        maxLines: 5,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText:
                "Ayam cabe garam adalah menu masakan yang sederhana namun kaya rasa. Pedas istimewa, gurih garamnya mengundang selera. Selalu mudah mengundang antrian untuk menikmatinya.",
            hintStyle: Font.textLMedium.copyWith(color: ColorModel.kText)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: Spacers.s12),
        child: Column(
            children: List.generate(3, (index) {
          return Column(
            children: [
              Container(
                height: 1,
                width: double.infinity,
                color: ColorModel.kBorder,
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: Spacers.s4, horizontal: 0),
                minLeadingWidth: 28,
                leading: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: ColorModel.kBorder,
                      borderRadius: Spacers.borderRadius,
                    ),
                    child: Center(
                        child: Text("${index + 1}", style: Font.textMRegular))),
                title: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: Font.textLMedium,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Ayam Cabai Garam",
                      hintStyle:
                          Font.textLMedium.copyWith(color: ColorModel.kText)),
                ),
              )
            ],
          );
        })),
      ),
    ]);
  }

  Widget ingredientSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Alat dan bahan", style: Font.incLRegular),
      Padding(
        padding: EdgeInsets.symmetric(vertical: Spacers.s12),
        child: Column(
            children: List.generate(3, (index) {
          return Column(
            children: [
              Container(
                height: 1,
                width: double.infinity,
                color: ColorModel.kBorder,
              ),
              FormTile(
                  title: "Penyajian/Servings",
                  hintText: "1 porsi",
                  secondaryHintText: "Telur Ayam",
                  isDouble: true,
                  controller: servingsCtrl //TODO: LIST CONTAINING CONTROLLERS
                  ),
            ],
          );
        })),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
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
          }
        },
        builder: (context, state) {
          return OrientationBuilder(builder: (context, axis) {
            return Stack(
              children: [
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: Spacers.m16, vertical: Spacers.s8).copyWith(
                    bottom: Spacers.l32,
                    top: 112,
                  ),
                  children: [
                    state is RecipeCoverPicked
                    ? photoBox(
                        axis: axis,
                        cover: state.pickedCover
                      )
                    : photoBox(axis: axis),
                    SizedBox(height: Spacers.m24),
                    CustomSimplifiedForm(
                      title: "Judul resep",
                      hintText: "Ayam Cabai Garam",
                      controller: titleCtrl,
                      axis: axis,
                    ),
                    divider(),
                    CustomSimplifiedForm(
                      title: "Deskripsi resep (ops.)",
                      hintText:
                          "Ayam cabe garam adalah menu masakan yang sederhana namun kaya rasa. Pedas istimewa, gurih garamnya mengundang selera. Selalu mudah mengundang antrian untuk menikmatinya",
                      controller: descriptionCtrl,
                      axis: axis,
                      isMultiline: true,
                    ),
                    divider(),
                    ingredientSection(),
                    addButton(
                        Icon(Ionicons.add_circle_outline,
                            color: ColorModel.majorText),
                        "Tambahkan alat / bahan",
                        axis),
                    SizedBox(height: Spacers.m16),
                    divider(),
                    instructionSection(),
                    addButton(
                        Icon(Ionicons.add_circle_outline,
                            color: ColorModel.majorText),
                        "Tambahkan langkah",
                        axis),
                    SizedBox(height: Spacers.m16),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: ColorModel.kBorder,
                    ),
                    FormTile(
                        title: "Penyajian/Servings",
                        hintText: "1 porsi",
                        isDouble: false,
                        controller: servingsCtrl),
                    FormTile(
                        title: "Waktu persiapan (ops.)",
                        hintText: "5 menit",
                        isDouble: false,
                        controller: prepTimeCtrl),
                    FormTile(
                        title: "Waktu masak",
                        hintText: "15 menit",
                        isDouble: false,
                        controller: cookTimeCtrl)
                  ]
                ),
                Container(
                  height: 100,
                  child: customAppBar()
                ),
              ],
            );
          });
        },
      )
    );
  }
}
