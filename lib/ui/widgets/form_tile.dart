part of "widgets.dart";

class FormTile extends StatelessWidget {

  final String title;
  final String hintText;
  final String? secondaryHintText;
  final bool isDouble;
  final bool? readOnly;
  final TextEditingController controller;
  final TextEditingController? secondaryController;
  const FormTile({ Key? key, required this.title, required this.isDouble, required this.hintText, required this.controller, this.secondaryController, this.secondaryHintText, this.readOnly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!isDouble)
    ? Column(
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
            title: Text(
              this.title,
              style: Font.incLRegular
            ),
            trailing: Container(
              width: 150,
              child: TextFormField(
                readOnly: this.readOnly ?? false,
                controller: this.controller,
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: Font.textLMedium,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: this.hintText,
                  hintStyle: Font.textLMedium.copyWith(
                    color: ColorModel.kText
                  )
                ),
              ),
            ),
          ),
        ],
      )
    : Column(
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
          title: TextFormField(
            readOnly: this.readOnly ?? false,
            controller: this.controller,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
            textAlign: TextAlign.start,
            style: Font.textLMedium,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: this.secondaryHintText != null ? this.secondaryHintText : "Daging Ayam",
              hintStyle: Font.textLMedium.copyWith(
                color: ColorModel.kText
              )
            ),
          ),
          trailing: Container(
            width: 150,
            child: TextFormField(
              readOnly: this.readOnly ?? false,
              controller: this.secondaryController,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              textAlign: TextAlign.end,
              style: Font.textLRegular,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: this.hintText,
                hintStyle: Font.textLRegular.copyWith(
                  color: ColorModel.kText
                )
              ),
            ),
          ),
        ),
      ],
    );
  }
}