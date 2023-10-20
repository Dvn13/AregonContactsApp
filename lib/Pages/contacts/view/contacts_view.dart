import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:contacts_app/Helpers/constants/text.dart';
import 'package:contacts_app/Pages/contacts/view/sub_view/contact_detail_view.dart';
import 'package:contacts_app/Pages/contacts/view/sub_widget/states_widget.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/city_bloc/city_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/city_bloc/city_states.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contacs_bloc/contacts_events.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contact_detail_bloc/contact_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contact_detail_bloc/contact_event.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/town_bloc/town_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/town_bloc/town_events.dart';
import 'package:contacts_app/Widgets/custom_button.dart';
import 'package:contacts_app/Widgets/custom_icon_button.dart';
import 'package:contacts_app/Widgets/custom_textform.dart';

import 'package:contacts_app/Widgets/dropdown/city_dropdown.dart';
import 'package:contacts_app/Widgets/dropdown/gender_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Helpers/constants/padding.dart';
import '../../../Helpers/exception/widget_not_found.dart';
import '../viewmodel/contacs_bloc/contacts_bloc.dart';
import '../viewmodel/contacs_bloc/contacts_states.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  TextEditingController nameField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return scaffold();
  }

  Scaffold scaffold() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbarWidget(),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              filterWidget(),
              clearFilterWidget(),
              contactsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  /// Appbar

  AppBar appbarWidget() {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: ConstColor.darkgreen,
      centerTitle: true,
      title: Text(
        ConstText.contacts,
        style: TextStyle(color: ConstColor.white),
      ),
      actions: [
        CustomIconButton(
          icon: Icon(
            Icons.add,
            color: ConstColor.white,
          ),
          onPressed: () {
            addVoid();
          },
        )
      ],
    );
  }

  /// Filter

  Column filterWidget() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: ConstPadding.paddingSmall),
          child: nameFilterWidget(),
        ),
        SizedBox(
          height: 100,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ConstPadding.paddingSmall),
                  child: cityWidget(),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: ConstPadding.paddingSmall),
                    child: genderFilterWidget()),
              ),
            ],
          ),
        )
      ],
    );
  }

  Padding genderFilterWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ConstPadding.paddingSmall),
      child: GenderDropDown(
        value: context.read<ContactsListBloc>().genderName,
        onChanged: (p0) {
          genderFilterVoid(p0);
        },
        hintText: ConstText.selectGender,
      ),
    );
  }

  CustomTextField nameFilterWidget() {
    return CustomTextField(
      text: ConstText.nameSurname,
      control: nameField,
      onChanged: (p0) {
        nameFilterVoid(p0);
      },
    );
  }

  /// Contacts

  Widget contactsWidget() {
    return BlocConsumer<ContactsListBloc, ContactsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return buildContacts(state, context);
      },
    );
  }

  Widget buildContacts(ContactsState state, BuildContext context) {
    if (state is ContactsInitial) {
      return Padding(
        padding: const EdgeInsets.only(top: ConstPadding.paddingMedium),
        child: state.buildWidget(),
      );
    } else if (state is ContactsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ContactsListItemState) {
      return state.buildWidget(
        context,
      );
    }
    throw WidgetNotFoundException<ContactsView, ContactsState>(state);
  }

  /// City

  Widget cityWidget() {
    return BlocConsumer<CitysListBloc, CityState>(
      listener: (context, state) {},
      builder: (context, state) {
        return buildCity(state, context);
      },
    );
  }

  Widget buildCity(CityState state, BuildContext context) {
    if (state is CityInitial) {
      return const Padding(
        padding: EdgeInsets.only(top: ConstPadding.paddingMedium),
        child: Text(""),
      );
    } else if (state is CityLoadingState) {
      return Padding(
        padding:
            const EdgeInsets.symmetric(vertical: ConstPadding.paddingSmall),
        child: CityDropDown(
          cities: const [],
          value: "",
          hintText: ConstText.selectCity,
          town: const [],
        ),
      );
    } else if (state is CityListItemState) {
      var city = state.items;

      return Padding(
        padding:
            const EdgeInsets.symmetric(vertical: ConstPadding.paddingSmall),
        child: CityDropDown(
          cities: state is CityLoadingState ? [] : city,
          value: context.read<ContactsListBloc>().cityName,
          onChanged: (p0) {
            if (context.read<ContactsListBloc>().cityName != p0) {
              cityFilterVoid(context, p0);
            }
          },
          hintText: 'Şehir Seçiniz',
          town: const [],
        ),
      );
    }
    throw WidgetNotFoundException<ContactsView, CityState>(state);
  }

  /// Clear Filter Widget

  Widget clearFilterWidget() {
    final contactListBloc = context.read<ContactsListBloc>();
    final name = nameField.text;
    final genderId = contactListBloc.genderId;
    final cityId = contactListBloc.cityId;

    var isFiltered = atLeastOneIsNotNull(name, genderId, cityId);

    return isFiltered
        ? Padding(
            padding: const EdgeInsets.all(ConstPadding.paddingSmall),
            child: CustomButton(
              text: ConstText.clearFilter,
              fontSize: 12,
              height: 40,
              isLoading: false,
              onPressed: () => clearFilterVoid(context),
            ),
          )
        : Container();
  }

  /// Voids

  void addVoid() {
    context.read<ContactBloc>().userModel =
        context.read<ContactsListBloc>().userModel;
    context.read<TownsListBloc>().cityId = -1;
    context.read<TownsListBloc>().townId = -1;
    context.read<TownsListBloc>().add(GetTown());
    context.read<ContactBloc>().add(Add());
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ContactsDetailsView(
        iconState: 0,
      ),
    ));
  }

  void genderFilterVoid(String? p0) {
    if (context.read<ContactsListBloc>().genderName != p0) {
      context.read<ContactsListBloc>().genderId = int.parse(p0!);
      context.read<ContactsListBloc>().setPageNumber(1);
      context.read<ContactsListBloc>().add(PageChanged());
      setState(() {
        context.read<ContactsListBloc>().genderName = p0;
      });
    }
  }

  void nameFilterVoid(String p0) {
    context.read<ContactsListBloc>().name = p0;
    context.read<ContactsListBloc>().setPageNumber(1);
    context.read<ContactsListBloc>().add(PageChanged());
    setState(() {
      context.read<ContactsListBloc>().name = p0;
    });
  }

  void cityFilterVoid(BuildContext context, String? p0) {
    context.read<ContactsListBloc>().cityId = int.parse(p0!);
    context.read<ContactsListBloc>().setPageNumber(1);
    context.read<ContactsListBloc>().add(PageChanged());
    setState(() {
      context.read<ContactsListBloc>().cityName = p0;
    });
  }

  void clearFilterVoid(BuildContext context) {
    nameField.text = "";

    context.read<ContactsListBloc>().genderId = null;
    context.read<ContactsListBloc>().genderName = null;
    context.read<ContactsListBloc>().cityId = null;
    context.read<ContactsListBloc>().cityName = null;

    context.read<ContactsListBloc>().name = null;

    context.read<ContactsListBloc>().setPageNumber(1);
    context.read<ContactsListBloc>().add(PageChanged());
    setState(() {});
  }

  bool atLeastOneIsNotNull(var name, var genderId, var cityId) {
    return name != "" || genderId != null || cityId != null;
  }
}
