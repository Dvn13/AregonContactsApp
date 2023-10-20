import 'package:contacts_app/Helpers/alert_dialog.dart';
import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:contacts_app/Helpers/constants/padding.dart';
import 'package:contacts_app/Helpers/constants/text.dart';
import 'package:contacts_app/Pages/contacts/model/contacts_data.dart';
import 'package:contacts_app/Pages/contacts/view/sub_view/contact_detail_view.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contact_detail_bloc/contact_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contact_detail_bloc/contact_event.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contact_detail_bloc/contact_states.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/town_bloc/town_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/town_bloc/town_events.dart';
import 'package:contacts_app/Widgets/circleavatar_widget.dart';
import 'package:contacts_app/Widgets/custom_icon_button.dart';
import 'package:contacts_app/Widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../viewmodel/contacs_bloc/contacts_bloc.dart';
import '../../viewmodel/contacs_bloc/contacts_events.dart';
import '../../viewmodel/contacs_bloc/contacts_states.dart';

extension ContactsInitialWidget on ContactsInitial {
  void navigate() {}
  Widget buildWidget() {
    return const Text('');
  }
}

extension ContactInitialWidget on ContactInitial {
  void navigate() {}
  Widget buildWidget() {
    return const Text('');
  }
}

extension ContactsListItemWidget on ContactsListItemState {
  Widget buildWidget(BuildContext context) {
    return Column(
      children: [
        pagination(context),
        totalTextWidget(),
        contactsList(context),
      ],
    );
  }

  Widget contactsList(BuildContext context) {
    var isLoading = context.watch<ContactsListBloc>().contactsLoading;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Data item = items[index];
              String imageUrl = item.resim != null ? (item.resim!) : "";
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: ConstPadding.paddingSmall / 2,
                ),
                child: listItem(item, imageUrl, context),
              );
            },
          );
  }

  /// ListTile Item Widget

  ListTile listItem(Data item, String imageUrl, BuildContext context) {
    return ListTile(
      leading: listTileImage(imageUrl, item.kisiAd ?? ""),
      title: listTileTitle(item.kisiAd ?? ""),
      trailing: Wrap(
        children: [
          editIconButton(context, item),
          deleteIconButton(context, item),
        ],
      ),
      onTap: () => showDetailVoid(context, item),
    );
  }

  /// Pagination Widget

  Container pagination(BuildContext context) {
    return Container(
      color: ConstColor.darkgreen,
      height: 50,
      child: Row(
        children: [
          buildFirstIcon(context),
          buildBackIcon(context),
          buildPageNumber(context),
          buildForwadIcon(context),
          buildLastIcon(context)
        ],
      ),
    );
  }

  /// Total Text Widget

  Padding totalTextWidget() {
    return Padding(
      padding: const EdgeInsets.all(ConstPadding.paddingSmall),
      child: Row(
        children: [
          Text("${ConstText.total} ${contacts.total} ${ConstText.fromPerson} "),
          Text(
              "${contacts.from ?? "0"}-${contacts.to ?? "0"} ${ConstText.showingBeetwen}"),
        ],
      ),
    );
  }

  /// Page Number Widget

  Expanded buildPageNumber(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: List<Widget>.generate(contacts.links!.length, (int index) {
          String label = contacts.links![index].label ?? "";
          bool active = contacts.links![index].active!;
          String url = contacts.links![index].url ?? "";
          if (index != 0 && index != contacts.links!.length - 1) {
            return Padding(
              padding: const EdgeInsets.all(0),
              child: CustomTextButton(
                url: url,
                label: label,
                active: active,
                onPressed: () => changePageVoid(context, url),
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }

  /// Page Icons Widget

  CustomIconButton buildForwadIcon(BuildContext context) {
    return CustomIconButton(
        onPressed: () => forwardPageVoid(context),
        icon: const Icon(Icons.keyboard_arrow_right));
  }

  CustomIconButton buildLastIcon(BuildContext context) {
    return CustomIconButton(
        onPressed: () => lastPageVoid(context),
        icon: const Icon(Icons.keyboard_double_arrow_right));
  }

  CustomIconButton buildBackIcon(BuildContext context) {
    return CustomIconButton(
        onPressed: () => backPageVoid(context),
        icon: const Icon(Icons.keyboard_arrow_left));
  }

  CustomIconButton buildFirstIcon(BuildContext context) {
    return CustomIconButton(
        onPressed: () => firstPageVoid(context),
        icon: const Icon(Icons.keyboard_double_arrow_left));
  }

  /// ListTile Widgets

  Text listTileTitle(String name) => Text(name);

  Widget listTileImage(String imageUrl, String name) {
    return CustomCircleAvatar(
      imgUrl: imageUrl,
      radius: 25,
      isNetwork: true,
      name: name,
    );
  }

  CustomIconButton deleteIconButton(BuildContext context, Data item) {
    return CustomIconButton(
        onPressed: () => deleteContactVoid(context, item),
        icon: Icon(
          Icons.delete,
          color: ConstColor.red,
        ));
  }

  CustomIconButton editIconButton(BuildContext context, Data item) {
    return CustomIconButton(
        onPressed: () async => editContactVoid(context, item),
        icon: Icon(
          Icons.edit,
          color: ConstColor.darkgreen,
        ));
  }

  /// Voids

  void showDetailVoid(BuildContext context, Data item) {
    context.read<ContactBloc>().currentId = item.kisiId!;

    context.read<ContactBloc>().userModel =
        context.read<ContactsListBloc>().userModel;

    context.read<ContactBloc>().add(GetContact());

    context.read<TownsListBloc>().cityId = item.cityId;
    context.read<TownsListBloc>().townId = item.townId;
    context.read<TownsListBloc>().add(GetTown());
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ContactsDetailsView(
        iconState: 2,
      ),
    ));
  }

  void changePageVoid(BuildContext context, String url) {
    var pageNumber = context.read<ContactsListBloc>().parsePage(url);
    if (pageNumber != null) {
      context.read<ContactsListBloc>().setPageNumber(pageNumber);
      context.read<ContactsListBloc>().add(PageChanged());
    }
  }

  void forwardPageVoid(BuildContext context) {
    String url = contacts.links!.last.url ?? "";
    var pageNumber = context.read<ContactsListBloc>().parsePage(url);
    if (pageNumber != null) {
      context.read<ContactsListBloc>().setPageNumber(pageNumber);
      context.read<ContactsListBloc>().add(PageChanged());
    }
  }

  void editContactVoid(BuildContext context, Data item) {
    context.read<ContactBloc>().currentId = item.kisiId!;

    context.read<ContactBloc>().userModel =
        context.read<ContactsListBloc>().userModel;

    context.read<ContactBloc>().add(GetContact());

    context.read<TownsListBloc>().cityId = item.cityId;
    context.read<TownsListBloc>().townId = item.townId;
    context.read<TownsListBloc>().add(GetTown());
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ContactsDetailsView(
        iconState: 1,
      ),
    ));
  }

  void deleteContactVoid(BuildContext context, Data item) {
    CustomAlertDialog.showAlertDialog(context, ConstText.delete,
        "${item.kisiAd} ${ConstText.deleteMessageContent}", () {
      context.read<ContactsListBloc>().currentId = item.kisiId!;
      context.read<ContactsListBloc>().add(DeleteContact());
      context.read<ContactsListBloc>().add(PageChanged());
      Navigator.of(context).pop();
    }, () {
      Navigator.of(context).pop();
    });
  }

  void firstPageVoid(BuildContext context) {
    String url = contacts.firstPageUrl ?? "";
    var pageNumber = context.read<ContactsListBloc>().parsePage(url);
    if (pageNumber != null) {
      context.read<ContactsListBloc>().setPageNumber(pageNumber);
      context.read<ContactsListBloc>().add(PageChanged());
    }
  }

  void backPageVoid(BuildContext context) {
    String url = contacts.links!.first.url ?? "";
    var pageNumber = context.read<ContactsListBloc>().parsePage(url);
    if (pageNumber != null) {
      context.read<ContactsListBloc>().setPageNumber(pageNumber);
      context.read<ContactsListBloc>().add(PageChanged());
    }
  }

  void lastPageVoid(BuildContext context) {
    String url = contacts.lastPageUrl ?? "";
    var pageNumber = context.read<ContactsListBloc>().parsePage(url);
    if (pageNumber != null) {
      context.read<ContactsListBloc>().setPageNumber(pageNumber);
      context.read<ContactsListBloc>().add(PageChanged());
    }
  }
}
