part of 'widgets.dart';

class CustomSimplifiedForm extends StatelessWidget {

  final String title;
  final String hintText;
  final Orientation axis;
  final bool? isMultiline;
  final TextEditingController controller;
  const CustomSimplifiedForm({ Key? key, required this.title, required this.hintText, required this.controller, required this.axis, this.isMultiline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return axis == Orientation.portrait 
    ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.title, style: Font.incLRegular),
          TextFormField(
            controller: this.controller,
            style: Font.textLMedium,
            maxLines: this.isMultiline != null && this.isMultiline == true ? null : 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: this.hintText,
              hintStyle: Font.textLMedium.copyWith(
                color: ColorModel.kText
              )
            ),
          ),
        ],
      )
    : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(this.title, style: Font.incLRegular),
          Spacer(),
          Expanded(
            flex: 16,
            child: TextFormField(
              controller: this.controller,
              style: Font.textLMedium,
              maxLines: this.isMultiline != null && this.isMultiline == true ? null : 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: this.hintText,
                hintStyle: Font.textLMedium.copyWith(
                  color: ColorModel.kText
                )
              ),
            ),
          ),
        ],
      );
  }
}