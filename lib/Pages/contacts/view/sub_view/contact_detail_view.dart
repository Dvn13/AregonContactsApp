import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:contacts_app/Helpers/constants/padding.dart';
import 'package:contacts_app/Helpers/constants/text.dart';
import 'package:contacts_app/Helpers/exception/widget_not_found.dart';
import 'package:contacts_app/Pages/contacts/view/sub_widget/states_widget.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/city_bloc/city_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contacs_bloc/contacts_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contacs_bloc/contacts_events.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contact_detail_bloc/contact_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contact_detail_bloc/contact_event.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contact_detail_bloc/contact_states.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/town_bloc/town_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/town_bloc/town_events.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/town_bloc/town_states.dart';
import 'package:contacts_app/Widgets/bottom_sheet.dart';
import 'package:contacts_app/Widgets/circleavatar_widget.dart';
import 'package:contacts_app/Widgets/custom_icon_button.dart';
import 'package:contacts_app/Widgets/custom_textform.dart';
import 'package:contacts_app/Widgets/dropdown/city_dropdown.dart';
import 'package:contacts_app/Widgets/dropdown/gender_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsDetailsView extends StatefulWidget {
  final int iconState;
  const ContactsDetailsView({super.key, required this.iconState});

  @override
  State<ContactsDetailsView> createState() => _ContactsDetailsViewState();
}

class _ContactsDetailsViewState extends State<ContactsDetailsView> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  int? genderId;
  int? cityId;
  int? townId;
  String? cityName;
  String imgUrl = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ContactBloc>().isNetwork = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactInitial) {
            return Padding(
              padding: const EdgeInsets.only(top: ConstPadding.paddingMedium),
              child: state.buildWidget(),
            );
          } else if (state is ContactLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactItemState) {
            return buildWidget(state, context);
          }
          throw WidgetNotFoundException<ContactsDetailsView, ContactState>(
              state);
        },
      ),
    );
  }

  AppBar appbarWidget(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: ConstColor.white, //change your color here
      ),
      backgroundColor: ConstColor.darkgreen,
      title: Text(
        ConstText.contactsDetail,
        style: TextStyle(color: ConstColor.white),
      ),
      centerTitle: true,
      actions: [
        widget.iconState == 2
            ? Container()
            : CustomIconButton(
                icon: Icon(
                  widget.iconState == 0 ? Icons.add : Icons.save,
                  color: ConstColor.white,
                ),
                onPressed: () => crudVoid(context),
              )
      ],
    );
  }

  Widget buildWidget(ContactItemState contactsState, BuildContext context) {
    genderId = contactsState.data.cinsiyet ?? 0;
    cityId = contactsState.data.cityId ?? -1;
    townId = contactsState.data.townId ?? -1;

    name.text = contactsState.data.kisiAd ?? "";
    phone.text = contactsState.data.kisiTel ?? "";

    imgUrl =
        contactsState.data.resim != null ? (contactsState.data.resim!) : "";

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ConstPadding.paddingMedium,
            vertical: ConstPadding.paddingLarge),
        child: Column(
          children: [
            userImage(context, contactsState, name.text),
            widget.iconState != 2
                ? addOrDisplay(context, contactsState)
                : infoDisplay(contactsState),
          ],
        ),
      ),
    );
  }

  Widget infoDisplay(ContactItemState contactsState) {
    return Padding(
      padding: const EdgeInsets.only(top: ConstPadding.paddingLarge),
      child: Column(
        children: [
          buildInfoDisplay(
              ConstText.nameSurname, contactsState.data.kisiAd ?? ""),
          buildInfoDisplay(
              ConstText.phoneNumber, contactsState.data.kisiTel ?? ""),
          buildInfoDisplay(
              ConstText.gender,
              (contactsState.data.cinsiyet == 1
                  ? ConstText.male
                  : contactsState.data.cinsiyet == 2
                      ? ConstText.female
                      : ConstText.nullGender)),
          buildInfoDisplay(ConstText.city, contactsState.data.cityName ?? "-"),
          buildInfoDisplay(ConstText.city, contactsState.data.townName ?? "-"),
        ],
      ),
    );
  }

  Widget addOrDisplay(BuildContext context, ContactItemState contactsState) {
    return Column(
      children: [
        nameField(contactsState, name),
        phoneField(contactsState, phone),
        genderDropDown(contactsState, context),
        cityDropdown(contactsState, context),
        townWidget(contactsState),
      ],
    );
  }

  Widget userImage(
      BuildContext context, ContactItemState contactsState, String name) {
    bool isNetwork = context.read<ContactBloc>().isNetwork;
    return Padding(
      padding: const EdgeInsets.only(top: ConstPadding.paddingSmall * 2),
      child: Column(
        children: [
          CustomCircleAvatar(
            imgUrl: imgUrl,
            radius: 80,
            isNetwork: isNetwork,
            name: name,
          ),
          widget.iconState != 2
              ? selectImageWidget(context, contactsState)
              : Container(),
        ],
      ),
    );
  }

  Widget selectImageWidget(
      BuildContext context, ContactItemState contactsState) {
    return CustomTextIconButton(
      text: ConstText.image,
      onPressed: () => CustomBottomSheet().showBottomSheet(context, [
        BottomSheetOption(
          icon: Icons.camera_alt_sharp,
          text: ConstText.openCamera,
          onTap: () async {
            var contactBloc = context.read<ContactBloc>();
            await contactBloc.imagePicker();
            if (contactBloc.photo != null) {
              if (!mounted) return;

              contactsState.data.resim = contactBloc.photo!.path;
              contactBloc.add(DataUpdate());
            }
          },
        )
      ]),
    );
  }

  Widget cityDropdown(ContactItemState contactsState, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: ConstPadding.paddingSmall * 2),
      child: CityDropDown(
        onChanged: widget.iconState == 2
            ? null
            : (p0) => selectCityVoid(contactsState, p0, context),
        hintText: ConstText.selectCity,
        cities: context.read<CitysListBloc>().dataItems,
        value: cityId != -1 ? cityId.toString() : null,
        town: const [],
      ),
    );
  }

  Widget genderDropDown(ContactItemState contactsState, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: ConstPadding.paddingSmall),
      child: GenderDropDown(
        hintText: ConstText.selectGender,
        onChanged: widget.iconState == 2
            ? null
            : (p0) => selectGenderVoid(contactsState, p0, context),
        value: genderId != 0 ? genderId.toString() : null,
      ),
    );
  }

  BlocConsumer<TownsListBloc, TownState> townWidget(
      ContactItemState contactItemState) {
    return BlocConsumer<TownsListBloc, TownState>(
      listener: (context, state) {},
      builder: (context, state) {
        return buildTown(state, context, contactItemState);
      },
    );
  }

  Widget buildTown(TownState townState, BuildContext context,
      ContactItemState contactItemState) {
    if (townState is TownInitial) {
      return const Padding(
        padding: EdgeInsets.only(top: ConstPadding.paddingMedium),
        child: Text(""),
      );
    } else if (townState is TownLoadingState) {
      return Padding(
        padding:
            const EdgeInsets.symmetric(vertical: ConstPadding.paddingSmall),
        child: CityDropDown(
          cities: const [],
          value: "",
          hintText: ConstText.selectTown,
          town: const [],
        ),
      );
    } else if (townState is TownListItemState) {
      var town = townState.items;
      // context.read<TownsListBloc>().cityName;
      return Padding(
        padding:
            const EdgeInsets.symmetric(vertical: ConstPadding.paddingSmall),
        child: CityDropDown(
          hintText: ConstText.selectTown,
          cities: const [],
          value: townId != -1 ? townId.toString() : null,
          onChanged: widget.iconState == 2
              ? null
              : (p0) => selectTownVoid(contactItemState, p0, context),
          town: townState is TownLoadingState ? [] : town,
        ),
      );
    }
    throw WidgetNotFoundException<ContactsDetailsView, TownState>(townState);
  }

  Widget phoneField(
      ContactItemState contactsState, TextEditingController phone) {
    return CustomTextField(
      text: ConstText.phoneNumber,
      control: phone,
      readOnly: widget.iconState == 2 ? true : false,
      keyboardType: TextInputType.number,
      onChanged: (p0) => phoneChangeVoid(contactsState, phone),
    );
  }

  Widget nameField(ContactItemState contactsState, TextEditingController name) {
    return Padding(
      padding: const EdgeInsets.only(top: ConstPadding.paddingSmall),
      child: CustomTextField(
        text: ConstText.nameSurname,
        control: name,
        readOnly: widget.iconState == 2 ? true : false,
        onChanged: (p0) => nameChangeVoid(contactsState, name),
      ),
    );
  }

  Padding buildInfoDisplay(String text, String value) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: ConstColor.darkgreen,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
                width: 350,
                height: 40,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ))),
                child: Row(children: [
                  Expanded(
                      child: Text(
                    value,
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  )),
                ]))
          ],
        ));
  }

  /// Void

  Future<void> crudVoid(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    var stateResponse = await context.read<ContactBloc>().addOrUpdateContact();
    if (stateResponse.basari == 1) {
      if (!mounted) return;
      context.read<ContactsListBloc>().add(PageChanged());
      Navigator.pop(context);
    }
  }

  void selectCityVoid(
      ContactItemState contactsState, String? p0, BuildContext context) {
    contactsState.data.cityId = int.parse(p0!);
    contactsState.data.townId = -1;
    context.read<ContactBloc>().add(DataUpdate());

    context.read<TownsListBloc>().cityId = int.parse(p0);
    context.read<TownsListBloc>().townId = -1;
    context.read<TownsListBloc>().add(GetTown());
  }

  void selectGenderVoid(
      ContactItemState contactsState, String? p0, BuildContext context) {
    contactsState.data.cinsiyet = int.parse(p0!);
    context.read<ContactBloc>().add(DataUpdate());
  }

  void selectTownVoid(
      ContactItemState contactItemState, String? p0, BuildContext context) {
    contactItemState.data.townId = int.parse(p0!);
    context.read<ContactBloc>().add(DataUpdate());
    context.read<TownsListBloc>().townId = int.parse(p0);
  }

  void phoneChangeVoid(
      ContactItemState contactsState, TextEditingController phone) {
    contactsState.data.kisiTel = phone.text;
  }

  void nameChangeVoid(
      ContactItemState contactsState, TextEditingController name) {
    contactsState.data.kisiAd = name.text;
  }
}
