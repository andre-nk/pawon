part of "widgets.dart";

class CustomForms extends StatelessWidget {

  final String placeholder;
  final TextEditingController controller;
  final bool isObscured;
  const CustomForms({ Key? key, required this.placeholder, required this.controller, required this.isObscured }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Spacers.l28),
      child: TextFormField(
        cursorColor: ColorModel.majorText,
        obscureText: this.isObscured,
        controller: this.controller,
        style: Font.textMRegular,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: this.placeholder,
          hintStyle: Font.textMRegular,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorModel.kText),
            borderRadius: Spacers.borderRadius
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: Spacers.borderRadius,
            borderSide: BorderSide(
              color: ColorModel.primaryRed,
            ),
          ),
        ),
      ),
    );
  }
}