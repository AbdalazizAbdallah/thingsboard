import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:things_board_app/core/context/tb_context.dart';
import 'package:things_board_app/core/entity/entity_details_page.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class AssetDetailsPage extends EntityDetailsPage<AssetInfo> {
  AssetDetailsPage(TbContext tbContext, String assetId)
      : super(tbContext,
            entityId: assetId,
            defaultTitle: 'Asset',
            subTitle: 'Asset details');

  @override
  Future<AssetInfo?> fetchEntity(String assetId) {
    return tbClient.getAssetService().getAssetInfo(assetId);
  }

  @override
  Widget buildEntityDetails(BuildContext context, AssetInfo asset) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('assetName'.tr, style: labelTextStyle),
              Text(asset.name, style: valueTextStyle),
              SizedBox(height: 16),
              Text('type'.tr, style: labelTextStyle),
              Text(asset.type, style: valueTextStyle),
              SizedBox(height: 16),
              Text('label'.tr, style: labelTextStyle),
              Text(asset.label ?? '', style: valueTextStyle),
              SizedBox(height: 16),
              Text('assignedToCustomer'.tr,
                  style: labelTextStyle),
              Text(asset.customerTitle ?? '', style: valueTextStyle),
            ]));
  }
}
