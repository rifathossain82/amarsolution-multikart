import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_text_form_field_builder.dart';
import 'package:amarsolution_multikart/src/features/checkout/controller/checkout_controller.dart';

class CheckoutNoteWidget extends StatelessWidget {
  final CheckoutController checkoutController;

  const CheckoutNoteWidget({
    Key? key,
    required this.checkoutController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteTextController = TextEditingController();
    noteTextController.text = checkoutController.note.value;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          KBoxShadow.itemShadow(),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Note',
            style: context.appTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          KTextFormFieldBuilder(
            controller: noteTextController,
            hintText: 'Tap to add a note',
            inputAction: TextInputAction.done,
            inputType: TextInputType.text,
            isBorder: false,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            onChanged: (value){
              checkoutController.updateNote(value);
            },
          ),
        ],
      ),
    );
  }
}