part of "pages.dart";

class StatusPage extends StatelessWidget {

  final String title;
  final String description;
  final String buttonContent;
  final Function() buttonMethod;

  const StatusPage({ Key? key, required this.title, required this.description, required this.buttonContent, required this.buttonMethod }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      body: Padding(
        padding: EdgeInsets.all(Spacers.l32),
        child: Column(
          children: [
            Spacer(),
            Container(
              height: Spacers.xl108,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/success_illustration.png"),
                  fit: BoxFit.contain
                )
              ),
            ),
            SizedBox(height: 56),
            Text(
              this.title,
              style: Font.headingM,
            ),
            SizedBox(height: Spacers.s12),
            Text(
              this.description,
              style: Font.incLRegular.copyWith(
                height: 1.5
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            PrimaryButton(
              content: this.buttonContent,
              isGoogleButton: false,
              isMinified: false,
              isCTA: false, 
              onPressed: this.buttonMethod
            ),
            SizedBox(height: Spacers.l32),
          ],
        ),
      )
    );
  }
}