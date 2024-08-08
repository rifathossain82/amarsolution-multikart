import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/extensions/date_time_extension.dart';
import 'package:amarsolution_multikart/src/core/routes/routes.dart';
import 'package:amarsolution_multikart/src/core/services/url_launcher_services.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_divider.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_outlined_button.dart';
import 'package:amarsolution_multikart/src/features/checkout/model/checkout_response_model.dart';
import 'package:amarsolution_multikart/src/features/dashboard/controller/dashboard_controller.dart';

class CheckoutSuccessPage extends StatelessWidget {
  final CheckoutResponseModel checkoutResponse;

  const CheckoutSuccessPage({
    super.key,
    required this.checkoutResponse,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie.asset(
            //   AssetPath.successLottie,
            //   height: context.screenHeight * 0.27,
            //   width: context.screenWidth,
            // ),
            Text(
              'Order Successful!',
              style: context.appTextTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Thank you for ordering',
              style: context.appTextTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            _InvoiceInfoCard(
              checkoutResponse: checkoutResponse,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _DownloadInvoiceButton(
                      onPressed: onDownloadInvoice,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _ContinueShoppingButton(
                      onPressed: onContinueShopping,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDownloadInvoice() {
    UrlLauncherServices.openURL(url: invoiceURL);
  }

  String get invoiceURL =>
      "https://software.akaarserver.xyz/in/${checkoutResponse.sale?.customer?.id}/${checkoutResponse.sale?.id}/sale";

  void onContinueShopping() {
    /// set current index for dashboard homepage
    /// then pop all the pages
    Get.find<DashboardController>().updateCurrentIndex(0);
    Get.offAllNamed(RouteGenerator.dashboard);
  }
}

class _InvoiceInfoCard extends StatelessWidget {
  final CheckoutResponseModel checkoutResponse;

  const _InvoiceInfoCard({
    required this.checkoutResponse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: kWhite,
        boxShadow: [
          KBoxShadow.itemShadow(),
        ],
      ),
      child: Column(
        children: [
          _InvoiceInfoRowWidget(
            title: 'Invoice No',
            value: '#${checkoutResponse.sale?.invoiceNo}',
          ),
          // _InvoiceInfoRowWidget(
          //   title: 'Date',
          //   value: checkoutResponse.sale?.saleDate?.primaryFormat ?? '',
          // ),
          _InvoiceInfoRowWidget(
            title: 'Total Amount',
            value:
                '${AppConstants.currencySymbol} ${checkoutResponse.sale?.totalAmount}',
          ),
          // KDivider(
          //   height: 5,
          //   color: kGreyMedium,
          // ),
          _InvoiceInfoRowWidget(
            title: 'Due',
            value:
                '${AppConstants.currencySymbol} ${checkoutResponse.sale?.dueAmount}',
          ),
        ],
      ),
    );
  }
}

class _InvoiceInfoRowWidget extends StatelessWidget {
  final String title;
  final String value;

  const _InvoiceInfoRowWidget({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.appTextTheme.bodySmall,
          ),
          Text(
            value,
            style: context.appTextTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _DownloadInvoiceButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DownloadInvoiceButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return KOutlinedButton(
      onPressed: onPressed,
      borderColor: kPrimaryColor,
      child: Text(
        'Download Invoice',
        style: context.outlinedButtonTextStyle(),
      ),
    );
  }
}

class _ContinueShoppingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ContinueShoppingButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return KButton(
      onPressed: onPressed,
      child: Text(
        'Continue Shopping',
        style: context.buttonTextStyle(),
      ),
    );
  }
}
