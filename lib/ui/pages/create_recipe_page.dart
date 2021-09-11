part of "pages.dart";

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({ Key? key }) : super(key: key);

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

  PreferredSize customAppBar(){
    return PreferredSize(
      child: CustomAppBar(
        title: "RESEP",
        leftButton: "Batal",
        rightButton: "Simpan",
        rightButtonCTA: true,
        rightButtonMethod: (){
          
        },
        leftButtonMethod: (){
          Navigator.pop(context);
        }
      ),
      preferredSize: Size.fromHeight(68.0),
    );
  }

  Widget photoBox(){
    return DottedBorder(
      color: ColorModel.kText,
      borderType: BorderType.RRect,
      radius: Radius.circular(15),
      dashPattern: [10,10],
      child: AspectRatio(
        aspectRatio: 16/9,
        child: Container(
          width: double.infinity,
          color: ColorModel.kWhite,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Ionicons.camera_outline,
                  color: ColorModel.majorText
                ),
                SizedBox(height: Spacers.s8),
                Text(
                  "Tambahkan foto masakan",
                  style: Font.textSRegular
                )
              ]
            ),
          )
        ),
      ),
    );
  }

  Widget divider(){
    return Column(
      children: [
        SizedBox(height: Spacers.s8),
        Container(
          width: double.infinity,
          height: 1,
          color: ColorModel.kBorder,
        ),
        SizedBox(height: Spacers.m24),
      ]
    );
  }

  Widget addButton(Icon icon, String content){
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 72
      ),
      alignment: Alignment.center,
      child: TextButton(
        onPressed: (){
          
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
            icon,
            SizedBox(width: Spacers.m16),
            Text(
              content,
              style: Font.textMRegular.copyWith(
                color: ColorModel.majorText
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget instructionSection(){
    return Column(
      children: [
        Text("Instruksi resep (opsional)", style: Font.incLRegular),
        TextFormField(
          controller: instructionCtrl,
          style: Font.textLRegular.copyWith(
            height: 1.75
          ),
          minLines: 3,
          maxLines: 5,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Ayam cabe garam adalah menu masakan yang sederhana namun kaya rasa. Pedas istimewa, gurih garamnya mengundang selera. Selalu mudah mengundang antrian untuk menikmatinya."
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: Spacers.s12
          ),
          child: Column(
            children: List.generate(3, (index){
              return Column(
                children: [
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: ColorModel.kBorder,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Spacers.s4,
                      horizontal: 0
                    ),
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
                          style: Font.textMRegular
                        )
                      )
                    ),
                    title: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: Font.textLMedium,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Ayam Cabai Garam"
                      ),
                    ),
                  )
                ],
              );
            })
          ),
        ),
      ]
    );
  }

  Widget ingredientSection(){
    return Column(
      children: [
        Text("Alat dan bahan", style: Font.incLRegular),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: Spacers.s12
          ),
          child: Column(
            children: List.generate(3, (index){
              return Column(
                children: [
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: ColorModel.kBorder,
                  ),
                  DualListTile(
                    title: "Ayam Segar",
                    trailing: "${(index + 1) * 100} gram"
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
    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      appBar: customAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Spacers.m16,
          vertical: Spacers.s8
        ).copyWith(
          bottom: Spacers.l32
        ),
        children: [
          photoBox(),
          SizedBox(height: Spacers.m24),
          CustomSimplifiedForm(
            title: "Judul resep",
            hintText: "Ayam Cabai Garam",
            controller: titleCtrl
          ),
          divider(),
          CustomSimplifiedForm(
            title: "Deskripsi resep (ops.)",
            hintText: "Ayam cabe garam adalah menu masakan yang sederhana namun kaya rasa. Pedas istimewa, gurih garamnya mengundang selera. Selalu mudah mengundang antrian untuk menikmatinya",
            controller: descriptionCtrl
          ),
          divider(),
          ingredientSection(),
          addButton(
            Icon(
              Ionicons.add_circle_outline,
              color: ColorModel.majorText
            ),
            "Tambahkan alat / bahan"
          ),
          SizedBox(height: Spacers.m16),
          divider(),
          instructionSection(),
          addButton(
            Icon(
              Ionicons.add_circle_outline,
              color: ColorModel.majorText
            ),
            "Tambahkan langkah"
          ),
          SizedBox(height: Spacers.m16),
          Container(
            height: 1,
            width: double.infinity,
            color: ColorModel.kBorder,
          ),
          FormTile(
            title: "Penyajian/Servings",
            hintText: "1 porsi",
            controller: servingsCtrl
          ),
          FormTile(
            title: "Waktu persiapan (ops.)",
            hintText: "5 menit",
            controller: prepTimeCtrl
          ),
          FormTile(
            title: "Waktu masak",
            hintText: "15 menit",
            controller: cookTimeCtrl
          )
        ]
      )
    );
  }
}