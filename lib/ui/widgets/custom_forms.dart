part of "widgets.dart";

class CustomForms extends StatelessWidget {

  final String placeholder;
  final bool isObscured;
  final bool isSearchForm;
  final TextEditingController controller;
  const CustomForms({ Key? key, required this.placeholder, required this.isSearchForm, required this.controller, required this.isObscured }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSearchForm ? ColorModel.kWhite : Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: HexColor("323232").withOpacity(isSearchForm ? 0.3 : 0),
            offset: Offset(0,0),
            blurRadius: 50,
            spreadRadius: 0
          )
        ]
      ),
      margin: EdgeInsets.only(bottom: Spacers.l28),
      child: TextFormField(
        cursorColor: ColorModel.majorText,
        obscureText: this.isObscured,
        controller: this.controller,
        style: Font.textMRegular,
        decoration: InputDecoration(
          suffixIcon: isSearchForm
          ? Padding(
              padding: EdgeInsets.only(right: Spacers.s8),
              child: Icon(
                Ionicons.search_outline,
                size: 20,
              ),
            )
          : SizedBox(),
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