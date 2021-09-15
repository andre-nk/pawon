part of "pages.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Widget googleButton() {
      return Column(
        children: [
          SizedBox(height: Spacers.l32),
          Container(
            height: 1,
            width: double.infinity,
            color: ColorModel.kBorder,
          ),
          SizedBox(height: Spacers.l32),
          PrimaryButton(
              content: "Daftar dengan Google",
              isMinified: false,
              isGoogleButton: true,
              isCTA: true,
              onPressed: () {})
        ],
      );
    }

    Widget title() {
      return Column(
        children: [
          Text(
            "Pawon.",
            style: Font.headingL,
          ),
          SizedBox(height: Spacers.s8),
          Text("Daftar akun kamu dulu ya!", style: Font.incXLMedium)
        ],
      );
    }

    Widget forms() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomForms(
              isSearchForm: false,
              placeholder: "Nama kamu",
              controller: nameController,
              isObscured: false),
          SizedBox(height: Spacers.l28),
          CustomForms(
              isSearchForm: false,
              placeholder: "E-mail kamu",
              controller: emailController,
              isObscured: false),
          SizedBox(height: Spacers.l28),
          CustomForms(
              isSearchForm: false,
              placeholder: "Kata sandi kamu",
              controller: passwordController,
              isObscured: true),
          SizedBox(height: Spacers.l28),
          Container(
            width: double.infinity,
            child: PrimaryButton(
              content: "Daftarkan akun kamu",
              isMinified: false,
              isGoogleButton: false,
              isCTA: false,
              onPressed: () {
                context.read<AuthCubit>().signUp(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text
                );
              }
            ),
          ),
          googleButton(),
          SizedBox(height: Spacers.l32),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: SignInPage(),
                      type: PageTransitionType.rightToLeftWithFade));
            },
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  style: Font.incLRegular.copyWith(color: ColorModel.majorText),
                  children: <TextSpan>[
                    TextSpan(text: 'Udah punya akun? '),
                    TextSpan(
                        text: 'Masuk saja!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorModel.majorText)),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: ColorModel.kWhite,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is AuthSuccess){
            Navigator.pushAndRemoveUntil(context, PageTransition(child: WrapperPage(), type: PageTransitionType.rightToLeftWithFade) , (route) => false);
          } else if (state is AuthFailed){
            print(state.error);
          }
        },
        builder: (context, state) {
          if(state is AuthLoading){
            return SafeArea(
              child: Center(
                child: CircularProgressIndicator()
              )
            );
          } else {
            return SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  vertical: 100,
                  horizontal: 40,
                ),
                children: [
                  title(),
                  SizedBox(height: 52),
                  forms()
                ],
              ),
            );
          }
        },
      )
    );
  }
}
