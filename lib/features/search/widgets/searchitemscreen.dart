
import 'package:flutter/material.dart';
import 'package:sixam_mart/features/search/controllers/search_controller.dart' as search;
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/item_widget.dart';
import 'package:sixam_mart/features/home/widgets/web/widgets/store_card_widget.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/search/controllers/search_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';

import '../../../common/widgets/no_data_screen.dart';

class SearchItemsView extends StatefulWidget {
  final List<Item?>? items;
  final List<Store?>? stores;
  final bool isStore;
  final String searchQuery;

  const SearchItemsView({
    super.key,
    required this.items,
    required this.stores,
    required this.isStore,
    required this.searchQuery,
  });

  @override
  State<SearchItemsView> createState() => _SearchItemsViewState();
}

class _SearchItemsViewState extends State<SearchItemsView> {
  @override
  Widget build(BuildContext context) {
    // Filter items or stores based on search query
    // List<Item?>? filteredItems = widget.items
    //     ?.where((item) =>
    //         item != null &&
    //         item.name!.toLowerCase().contains(widget.searchQuery.toLowerCase()))
    //     .toList();
    // List<Store?>? filteredStores = widget.stores
    //     ?.where((store) =>
    //         store != null &&
    //         store.name!.toLowerCase().contains(widget.searchQuery.toLowerCase()))
    //     .toList();

    // bool isNull = widget.isStore ? widget.stores == null : widget.items == null;
    // int length = widget.isStore
    //     ? filteredStores?.length ?? 0
    //     : filteredItems?.length ?? 0;

    return GetBuilder<search.SearchController>(builder: (searchController)  {
        return searchController.isLoading
            ? const Center(child: CircularProgressIndicator()) :
          widget.isStore && widget.stores!.isEmpty
              ? NoDataScreen(
                  text: 'no store found'.tr,
                  // isStore: true,
                )
              : !widget.isStore && widget.items!.isEmpty
                  ? NoDataScreen(
                      text: 'no item found'.tr,
                      // isStore: false,
                    )
                  // : isNull
                  //     ? NoDataScreen(text: 'no_data_found'.tr)
                  //     :
            : GridView.builder(
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: ResponsiveHelper.isDesktop(context)
                      ? Dimensions.paddingSizeExtremeLarge
                      : Dimensions.paddingSizeLarge,
                  mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                      ? Dimensions.paddingSizeLarge
                      : Dimensions.paddingSizeSmall,
                  mainAxisExtent: ResponsiveHelper.isDesktop(context) && widget.isStore
                      ? 220
                      : ResponsiveHelper.isMobile(context)
                          ? widget.isStore
                              ? 200
                              : 210
                          : 122,
                  crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 3,
                ),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: searchController.isStore ? widget.stores!.length : widget.items!.length,
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                itemBuilder: (context, index) {
                  if (searchController.isStore) {
                    return Column(
                      children: [
                        StoreCardWidget2(store: widget.stores![index]),
                        const Divider(),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        ItemWidget(
                          isStore: false,
                          item: widget.items![index],
                          isFeatured: false,
                          store: null,
                          index: index,
                          length: widget.items!.length,
                          isCampaign: false,
                          inStore: false,
                        ),
                        const Divider(),
                      ],
                    );
                  }
                },
              );
      }
    );
  }
}