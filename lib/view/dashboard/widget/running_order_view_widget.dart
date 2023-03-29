import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/order_controller.dart';
import 'package:sixam_mart/data/model/response/order_model.dart';
import 'package:sixam_mart/helper/order_status_type.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/screens/order/order_details_screen.dart';

class RunningOrderViewWidget extends StatelessWidget {
  final List<OrderModel> reversOrder;
  RunningOrderViewWidget({Key key, @required this.reversOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {

     return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius : BorderRadius.only(
                topLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                topRight : Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              ),
              boxShadow: [BoxShadow(color: Colors.grey[200], offset: Offset(0, -5), blurRadius: 10)]),
         child: Column(children: [

           Center(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
              height: 3, width: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
              ),
            ),
           ),

           ListView.builder(
            itemCount: reversOrder.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index){

              bool isFirstOrder =  index == 0;

              String _orderStatus = reversOrder != null ? reversOrder[index].orderStatus : '';
              int _status = 0;

              if(_orderStatus == OrderStatusType.pending.name){
                _status = 1;
              }else if(_orderStatus == OrderStatusType.accepted.name || _orderStatus == OrderStatusType.processing.name || _orderStatus == OrderStatusType.confirmed.name){
                _status = 2;
              }else if(_orderStatus == OrderStatusType.handover.name || _orderStatus == OrderStatusType.picked_up.name){
                _status = 3;
              }

              return InkWell(
                onTap: () async {
                  await Get.toNamed(
                    RouteHelper.getOrderDetailsRoute(reversOrder[index].id),
                    arguments: OrderDetailsScreen(
                      orderId: reversOrder[index].id,
                      orderModel: reversOrder[index],
                    ),
                  );
                  if(orderController.showBottomSheet){
                    orderController.showRunningOrders();
                    print(orderController.showBottomSheet);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL, top: Dimensions.PADDING_SIZE_SMALL),

                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Row( crossAxisAlignment: CrossAxisAlignment.center, children: [

                      Center(
                        child: SizedBox(
                          height: _orderStatus == OrderStatusType.pending.name ? 50 : 60, width: _orderStatus == OrderStatusType.pending.name ? 50 : 60,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset( _status == 2 ? _orderStatus == OrderStatusType.confirmed.name || _orderStatus == OrderStatusType.accepted.name ? Images.confirmed_gif
                                : Images.processing_gif : _status == 3
                                ? _orderStatus == OrderStatusType.handover.name ? Images.handover_gif : Images.on_the_way_gif : Images.pending_gif,
                        height: 60, width: 60, fit: BoxFit.fill),
                          ),
                        ),
                      ),

                      SizedBox(width: isFirstOrder ? 0 : Dimensions.PADDING_SIZE_SMALL),

                      Expanded(
                        child: Column(mainAxisAlignment: isFirstOrder ? MainAxisAlignment.center : MainAxisAlignment.start,
                            crossAxisAlignment: isFirstOrder ? CrossAxisAlignment.center : CrossAxisAlignment.start, children: [
                              Row( mainAxisAlignment: isFirstOrder ? MainAxisAlignment.center : MainAxisAlignment.start, children: [

                                Text('your_order_is'.tr + ' ', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                                Text('${reversOrder[index].orderStatus.tr}', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
                              ]) ,
                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                              Text(
                                '${'order'.tr} #${reversOrder[index].id}',
                                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall), maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),

                              isFirstOrder ? SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                      vertical: Dimensions.PADDING_SIZE_SMALL),
                                  child: Row(children: [
                                    Expanded(child: trackView(context, status: _status >= 1 ? true : false)),
                                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                    Expanded(child: trackView(context, status: _status >= 2 ? true : false)),
                                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                    Expanded(child: trackView(context, status: _status >= 3 ? true : false)),
                                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                    Expanded(child: trackView(context, status: _status >= 4 ? true : false)),
                                  ]),
                                ),
                              ) : SizedBox()

                            ]),
                      ),

                      Container(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), shape: BoxShape.circle),
                        child: isFirstOrder ? !(reversOrder.length < 2) ? InkWell(
                          onTap: () => Get.toNamed(RouteHelper.getOrderRoute()),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text('+${reversOrder.length - 1}', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)),
                                Text('more'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor)),
                              ]),
                            ) : Icon(Icons.arrow_forward, size: 18, color: Theme.of(context).primaryColor)
                            : Icon(Icons.arrow_forward, size: 18, color: Theme.of(context).primaryColor),
                      ),

                    ]),
                  ) ,
                ),
              );
            }),
         ]),
     );
    });
  }

  Widget trackView(BuildContext context, {@required bool status}) {
    return Container(height: 5, decoration: BoxDecoration(color: status ? Theme.of(context).primaryColor
        : Theme.of(context).disabledColor.withOpacity(0.5), borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT)));
  }
}
