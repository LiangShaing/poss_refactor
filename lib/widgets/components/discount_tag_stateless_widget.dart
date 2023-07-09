import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/widgets/components/my_text_stateless_widget.dart';

class DiscountTagStatelessWidget extends StatelessWidget {
  final String? discountName;

  const DiscountTagStatelessWidget({
    super.key,
    required this.discountName,
  });

  @override
  Widget build(BuildContext context) {
    if (discountName == null) return Container();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit, vertical: SizeStyle.paddingUnit * 0.5),
      margin: const EdgeInsets.only(bottom: SizeStyle.paddingUnit),
      decoration: BoxDecoration(color: ColorStyle.lightBlue2, borderRadius: SizeStyle.borderRadius),
      child: Wrap(
        children: [
          const Icon(
            Icons.sell,
            color: ColorStyle.white,
            size: 16,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 28, maxWidth: 100),
            child: MyTextStatelessWidget(
                text: discountName,
                padding: const EdgeInsets.only(left: SizeStyle.paddingUnit * 0.5),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorStyle.white)),
          )
        ],
      ),
    );
  }
}
