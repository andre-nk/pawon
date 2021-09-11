part of 'widgets.dart';

class CustomSimplifiedForm extends StatelessWidget {

  final String title;
  final String hintText;
  final TextEditingController controller;
  const CustomSimplifiedForm({ Key? key, required this.title, required this.hintText, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(this.title, style: Font.incLRegular),
        TextFormField(
          controller: this.controller,
          style: Font.textLMedium,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: this.hintText
          ),
        ),
      ],
    );
  }
}