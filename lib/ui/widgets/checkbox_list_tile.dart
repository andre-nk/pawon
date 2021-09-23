part of "widgets.dart";

class CheckBoxListTile extends StatefulWidget {

  final String title;
  final String subtitle;
  final String? imageURL;
  final bool? isTrailed;
  final RecipeModel? recipeModel;
  const CheckBoxListTile({ Key? key, this.recipeModel, required this.title, required this.subtitle, this.imageURL, this.isTrailed }) : super(key: key);

  @override
  State<CheckBoxListTile> createState() => _CheckBoxListTileState();
}
class _CheckBoxListTileState extends State<CheckBoxListTile> {  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Spacers.m16
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCheckbox(
                value: context.watch<RecipePickerCubit>().isSelected(widget.recipeModel!),
                onChanged: (value){
                  context.read<RecipePickerCubit>().selectRecipe(widget.recipeModel!);
                },
              ),
              SizedBox(width: 20),
              Container(
                child: InkWell(
                  onTap: (){
                    if(widget.recipeModel != null){
                      Navigator.push(
                        context,
                        PageTransition(child: RecipePage(recipe: widget.recipeModel), type: PageTransitionType.rightToLeftWithFade)
                      );
                    }
                  },
                  child: Row(
                    children: [
                      if(widget.recipeModel != null)
                      widget.imageURL != null && widget.imageURL != ""
                      ? Row(
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color: ColorModel.disabledRed,
                                borderRadius: Spacers.borderRadius
                              ),
                              child: Image.network(widget.imageURL ?? "", fit: BoxFit.cover)
                            ),
                            SizedBox(width: 20),
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color: ColorModel.disabledRed,
                                borderRadius: Spacers.borderRadius
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: Font.textLRegular
                          ),
                          widget.isTrailed == null || widget.isTrailed == false
                          ? Column(
                              children: [
                                SizedBox(height: Spacers.s8),
                                Text(
                                    widget.subtitle,
                                    style: Font.incLRegular.copyWith(
                                      color: ColorModel.majorText
                                    ),
                                  ),
                              ],
                            )
                          : SizedBox()
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          widget.isTrailed != null || widget.isTrailed == true 
          ? Text(
              widget.subtitle,
              style: Font.incLRegular.copyWith(
                color: ColorModel.majorText
              ),
            )
          : SizedBox()
        ],
      ),
    );
  }
}