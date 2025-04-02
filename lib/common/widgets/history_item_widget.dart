import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/models/transaction_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

// class HistoryItemWidget extends StatelessWidget {
//   final int index;
//   final bool fromWallet;
//   final List<Transaction>? data;
//   const HistoryItemWidget({super.key, required this.index, required this.fromWallet, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Row(
//         children: [
//           Flexible(
//             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               fromWallet ? Row(children: [
            
//                 data![index].transactionType == 'order_place' || data![index].transactionType == 'partial_payment'
//                     ? Image.asset(Images.walletDebitIcon, height: 15, width: 15)
//                     : Image.asset(Images.walletCreditIcon, height: 15, width: 15),
//                 const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            
//                 Text(data![index].transactionType == 'order_place' || data![index].transactionType == 'partial_payment'
//                     ? '- ${PriceConverter.convertPrice(data![index].debit! + data![index].adminBonus!)}'
//                     : '+ ${PriceConverter.convertPrice(data![index].credit! + data![index].adminBonus!)}',
//                   style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault), maxLines: 1, overflow: TextOverflow.ellipsis, textDirection: TextDirection.ltr,
//                 ),
//               ]) : Row(children: [
            
//                 data![index].transactionType == 'point_to_wallet'? Image.asset(Images.debitIcon, height: 13, width: 13) : Image.asset(Images.creditIcon, height: 13, width: 13),
//                 const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            
//                 Text(data![index].transactionType == 'point_to_wallet'? '-${data![index].debit!.toStringAsFixed(0)}'
//                     : '+${data![index].credit!.toStringAsFixed(0)}',
//                     style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault), maxLines: 1, overflow: TextOverflow.ellipsis),
//                 const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            
//                 Text('points'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).disabledColor),
//                 )]),
//               const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            
//               Text(
//                 data![index].transactionType == 'add_fund' ? '${'added_via'.tr} ${data![index].reference!.replaceAll('_', ' ')} ${data![index].adminBonus != 0 ? '(${'bonus'.tr} = ${data![index].adminBonus})' : '' }'
//                     : data![index].transactionType == 'partial_payment' ? '${'spend_on_order'.tr} # ${data![index].reference}'
//                     : data![index].transactionType == 'loyalty_point' ? 'converted_from_loyalty_point'.tr
//                     : data![index].transactionType == 'referrer' ? 'earned_by_referral'.tr
//                     : data![index].transactionType == 'order_place' ? '${'order_place'.tr} # ${data![index].reference}'
//                     : data![index].transactionType!.tr,
//                 style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Theme.of(context).hintColor),
//                 maxLines: 2, overflow: TextOverflow.ellipsis,
//               ),
//             ]),
//           ),
//           const SizedBox(width: Dimensions.paddingSizeDefault),

//           Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//             Text(
//               DateConverter.dateToDateAndTimeAm(data![index].createdAt!),
//               style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),
//               maxLines: 1, overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: Dimensions.paddingSizeExtraSmall),

//             Text(
//               fromWallet ? data![index].transactionType == 'order_place' || data![index].transactionType == 'partial_payment' ? 'debit'.tr : 'credit'.tr : data![index].transactionType == 'point_to_wallet' ? 'debit'.tr : 'credit'.tr,
//               style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: fromWallet ? data![index].transactionType == 'order_place' || data![index].transactionType == 'partial_payment'
//                   ? Colors.red : Colors.green : data![index].transactionType == 'point_to_wallet' ? Colors.red : Colors.green),
//               maxLines: 1, overflow: TextOverflow.ellipsis,
//             ),
//           ]),

//         ]),

//       index == data!.length-1 ? const SizedBox() : Padding(
//         padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
//         child: Divider(color: Theme.of(context).disabledColor),
//       ),

//     ]);
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/models/transaction_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

class HistoryItemWidget extends StatelessWidget {
  final int index;
  final bool fromWallet;
  final List<Transaction>? data;
  const HistoryItemWidget({super.key, required this.index, required this.fromWallet, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                  color: _getIconBackgroundColor(context),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  _getIcon(),
                  height: 20,
                  width: 20,
                  color: _getIconColor(context),
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeDefault),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTransactionTypeText(),
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Text(
                      _getTransactionDescription(),
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _getAmountText(),
                    style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: _getAmountColor(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(
                    DateConverter.dateToDateAndTimeAm(data![index].createdAt!),
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          // const SizedBox(height: Dimensions.paddingSizeDefault),
          // Divider(color: Theme.of(context).disabledColor.withOpacity(0.5)),
        ],
      ),
    );
  }

  String _getIcon() {
    if (fromWallet) {
      return data![index].transactionType == 'order_place' || data![index].transactionType == 'partial_payment'
          ? Images.walletDebitIcon
          : Images.walletCreditIcon;
    } else {
      return data![index].transactionType == 'point_to_wallet'
          ? Images.debitIcon
          : Images.creditIcon;
    }
  }

  Color _getIconBackgroundColor(BuildContext context) {
    if (fromWallet) {
      return data![index].transactionType == 'order_place' || data![index].transactionType == 'partial_payment'
          ? Colors.red.withOpacity(0.1)
          : Colors.green.withOpacity(0.1);
    } else {
      return data![index].transactionType == 'point_to_wallet'
          ? Colors.red.withOpacity(0.1)
          : Colors.green.withOpacity(0.1);
    }
  }

  Color _getIconColor(BuildContext context) {
    if (fromWallet) {
      return data![index].transactionType == 'order_place' || data![index].transactionType == 'partial_payment'
          ? Colors.red
          : Colors.green;
    } else {
      return data![index].transactionType == 'point_to_wallet'
          ? Colors.red
          : Colors.green;
    }
  }

  String _getAmountText() {
    if (fromWallet) {
      return data![index].transactionType == 'order_place' || data![index].transactionType == 'partial_payment'
          ? '- ${PriceConverter.convertPrice(data![index].debit! + data![index].adminBonus!)}'
          : '+ ${PriceConverter.convertPrice(data![index].credit! + data![index].adminBonus!)}';
    } else {
      return data![index].transactionType == 'point_to_wallet'
          ? '-${data![index].debit!.toStringAsFixed(0)}'
          : '+${data![index].credit!.toStringAsFixed(0)}';
    }
  }

  Color _getAmountColor(BuildContext context) {
    if (fromWallet) {
      return data![index].transactionType == 'order_place' || data![index].transactionType == 'partial_payment'
          ? Colors.red
          : Colors.green;
    } else {
      return data![index].transactionType == 'point_to_wallet'
          ? Colors.red
          : Colors.green;
    }
  }

  String _getTransactionTypeText() {
    if (fromWallet) {
      return data![index].transactionType == 'order_place' || data![index].transactionType == 'partial_payment'
          ? 'debit'.tr
          : 'credit'.tr;
    } else {
      return data![index].transactionType == 'point_to_wallet'
          ? 'debit'.tr
          : 'credit'.tr;
    }
  }

  String _getTransactionDescription() {
    return data![index].transactionType == 'add_fund'
        ? '${'added_via'.tr} ${data![index].reference!.replaceAll('_', ' ')} ${data![index].adminBonus != 0 ? '(${'bonus'.tr} = ${data![index].adminBonus})' : ''}'
        : data![index].transactionType == 'partial_payment'
        ? '${'spend_on_order'.tr} # ${data![index].reference}'
        : data![index].transactionType == 'loyalty_point'
        ? 'converted_from_loyalty_point'.tr
        : data![index].transactionType == 'referrer'
        ? 'earned_by_referral'.tr
        : data![index].transactionType == 'order_place'
        ? '${'order_place'.tr} # ${data![index].reference}'
        : data![index].transactionType!.tr;
  }
}