part of "pages.dart";

class ChangeNamePage extends StatelessWidget {
  const ChangeNamePage({ Key? key }) : super(key: key);
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    PreferredSize customAppBar() {
      return PreferredSize(
        child: CustomAppBar(
        title: "",
        leftButton: "Kembali",
        leftButtonMethod: () {
          Navigator.pop(context);
        }),
        preferredSize: Size.fromHeight(68.0),
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
          Text("Ubah nama pengguna kamu?", style: Font.incXLMedium)
        ],
      );
    }

    Widget forms() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomForms(
              isSearchForm: false,
              placeholder: "Nama pengguna baru",
              controller: nameController,
              isObscured: false),
          SizedBox(height: Spacers.l28),
          Container(
            width: double.infinity,
            child: PrimaryButton(
              content: "Ubah nama pengguna",
              isMinified: false,
              isGoogleButton: false,
              isCTA: false,
              onPressed: () {
                context.read<AuthCubit>().changeDisplayName(nameController.text);
              }
            )
          ),
          SizedBox(height: Spacers.m16),
        ],
      );
    }

    return Scaffold(
      appBar: customAppBar(),
      backgroundColor: ColorModel.kWhite,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state){
          if(state is AuthSuccess){
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content: "Nama pengguna berhasil diubah",
                icon: Icon(
                  Ionicons.information_circle_outline,
                  color: ColorModel.kBlue,
                ),
              )
            );
            Navigator.pop(context);
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