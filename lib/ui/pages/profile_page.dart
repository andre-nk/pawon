part of "pages.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget settingsTile(){
      return Container(
        height: 300,
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: Spacers.s4,
                horizontal: 0
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Nama",
                    style: Font.textLRegular
                  ),
                  SizedBox(width: Spacers.m16),
                  Text(
                    "Dewi Rosdiana",
                    overflow: TextOverflow.ellipsis,
                    style: Font.incLRegular.copyWith(
                      color: ColorModel.kText
                    )
                  ),
                ],
              ),
              trailing: Icon(
                Ionicons.chevron_forward,
                color: ColorModel.kText,
                size: 20,
              )
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: Spacers.s4,
                horizontal: 0
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "E-mail",
                    style: Font.textLRegular
                  ),
                  SizedBox(width: Spacers.m16),
                  Text(
                    "elisabeth.d.rosdiana10@gmail.com",
                    overflow: TextOverflow.ellipsis,
                    style: Font.incLRegular.copyWith(
                      color: ColorModel.kText
                    )
                  ),
                ],
              ),
              trailing: Icon(
                Ionicons.chevron_forward,
                color: ColorModel.kText,
                size: 20,
              )
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: Spacers.s4,
                horizontal: 0
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Kata sandi",
                    style: Font.textLRegular
                  ),
                  SizedBox(width: Spacers.m16),
                  Text(
                    "*************",
                    overflow: TextOverflow.ellipsis,
                    style: Font.incLRegular.copyWith(
                      color: ColorModel.kText
                    )
                  ),
                ],
              ),
              trailing: Icon(
                Ionicons.chevron_forward,
                color: ColorModel.kText,
                size: 20,
              )
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: Spacers.s4,
                horizontal: 0
              ),
              title: Text(
                "Hapus akun",
                style: Font.textLRegular.copyWith(
                  color: ColorModel.primaryRed
                )
              ),
            ),
          ],
        )
      );
    }

    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      appBar: PreferredSize(
        child: CustomAppBar(
          title: "PROFIL",
          leftButton: "Kembali",
          leftButtonMethod: (){
            Navigator.pop(context);
          }
        ),
        preferredSize: Size.fromHeight(68.0),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Spacers.m24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 56),
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: ColorModel.disabledRed,
                borderRadius: Spacers.borderRadius
              ),
            ),
            SizedBox(height: 56),
            settingsTile(),
            Spacer(),
            Container(
              width: double.infinity,
              child: PrimaryButton(
                content: "Keluar dari akun",
                isGoogleButton: false,
                isMinified: false,
                isCTA: false,
                onPressed: (){
                  Navigator.push(
                    context,
                    PageTransition(
                      child: StatusPage(
                      buttonContent: "Kembali ke Homepage",
                      title: "Keren!",
                      description: "Resepnya berhasil dimasak! Jangan lupa sajikan lalu di foto ya!",
                      buttonMethod: (){
                        Navigator.pushAndRemoveUntil(context, PageTransition(child: HomePage(), type: PageTransitionType.rightToLeftWithFade), (route) => false);
                      },
                    ), type: PageTransitionType.rightToLeftWithFade)
                  );
                }
              ),
            ),
            SizedBox(height: Spacers.m24),
            Text(
              "Pawon v.1.0",
              style: Font.incLRegular,
            ),
            SizedBox(height: Spacers.m24),
          ],
        )
      )
    );
  }
}