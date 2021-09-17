part of "pages.dart";

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({ Key? key }) : super(key: key);

  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    Widget title() {
      return Column(
        children: [
          Text(
            "Pawon.",
            style: Font.headingL,
          ),
          SizedBox(height: Spacers.s8),
          Text("Lupa kata sandi kamu?", style: Font.incXLMedium)
        ],
      );
    }

    Widget forms() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomForms(
              isSearchForm: false,
              placeholder: "E-mail kamu",
              controller: emailController,
              isObscured: false),
          SizedBox(height: Spacers.l28),
          Container(
            width: double.infinity,
            child: PrimaryButton(
              content: "Setel ulang kata sandi",
              isMinified: false,
              isGoogleButton: false,
              isCTA: false,
              onPressed: () {
                context.read<AuthCubit>().resetPassword(emailController.text);
              }
            )
          ),
          SizedBox(height: Spacers.m16),
        ],
      );
    }

    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state){
          if(state is PasswordResetSent){
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content: "Link kata sandi telah dikirim ke email kamu",
                icon: Icon(
                  Ionicons.information_circle_outline,
                  color: ColorModel.kBlue,
                ),
              )
            );
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                child: SignInPage(),
                type: PageTransitionType.rightToLeftWithFade
              ),
              (route) => false
            );
          } else if (state is AuthFailed){
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content: state.error,
                icon: Icon(
                  Ionicons.alert_circle_outline,
                  color: ColorModel.primaryRed,
                ),
              )
            );
          }
        },
        builder: (context, state) {
          if(state is AuthLoading){
            return CustomLoaderPage();
          } else {
            return SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  vertical: 120,
                  horizontal: 40,
                ),
                children: [title(), SizedBox(height: 52), forms()],
              ),
            );
          }
        },
      )
    );
  }
}