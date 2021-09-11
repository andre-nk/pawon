part of "widgets.dart";

class FormTile extends StatelessWidget {

  final String title;
  final String hintText;
  final TextEditingController controller;
  const FormTile({ Key? key, required this.title, required this.hintText, required this.controller }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            this.title,
            style: Font.incLRegular
          ),
          trailing: Container(
            width: 150,
            child: TextFormField(
              controller: this.controller,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              textAlign: TextAlign.end,
              style: Font.textLMedium,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: this.hintText
              ),
            ),
          ),
        ),
      ],
    );
  }
}