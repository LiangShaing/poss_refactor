import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/widgets/components/my_text_stateless_widget.dart';


class GroupFeatureButtonStatelessWidget<T> extends StatelessWidget {
  final String title;
  final dynamic items;

  const GroupFeatureButtonStatelessWidget({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MyTextStatelessWidget(
          text: title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xFF241f20)),
          padding: const EdgeInsets.symmetric(vertical: SizeStyle.paddingUnit * 2),
        ),
        Row(
          children: [
            ...items.map(
                  (e) => Padding(
                padding: const EdgeInsets.only(right: 24.0, bottom: 12),
                child: SizedBox(
                  width: 130,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: e.disabled
                        ? null
                        : () {
                      e.func();
                      Scaffold.of(context).closeDrawer();
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        backgroundColor: Theme.of(context).primaryColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconData(e.icon, fontFamily: 'MaterialIcons'),
                          color: ColorStyle.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: SizeStyle.paddingUnit),
                          child: Text(
                            e.name,
                            style: const TextStyle(fontSize: 14.0, color: ColorStyle.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
