import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_practice/src/features/products/application/product_provider.dart';
import 'package:ncdc_practice/src/features/products/presentation/product_list_description_item.dart';
import 'package:ncdc_practice/src/features/products/presentation/product_list_title.dart';

class ProductDrawer extends HookConsumerWidget {
  const ProductDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsList = ref.watch(productListProvider);
    final isIcon = useState<bool>(false);

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  for (var i = 0; i < productsList.length; i++) ...[
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductListDescription(
                                  product: productsList[i],
                                ),
                              ),
                            );
                          },
                          child: ProductListTitle(product: productsList[i]),
                        ),
                        const Spacer(),
                        isIcon.value ? _IconItem(
                          iconPath: 'assets/icons/delete.svg',
                          onTap: () {
                            ref
                                .read(productListProvider.notifier)
                                .remove(productsList[i]);
                          },
                        ) : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isIcon.value
                    ? Expanded(
                        child: Row(
                          children: [
                            _IconItem(
                              iconPath: 'assets/icons/+.svg',
                              onTap: () => ref
                                  .read(productListProvider.notifier)
                                  .add('新しいタイトル', '詳細'),
                            ),
                            const Spacer(),
                            _IconItem(
                              iconPath: 'assets/icons/done.svg',
                              onTap: () => isIcon.value = false,
                            ),
                          ],
                        ),
                      )
                    : _IconItem(
                        iconPath: 'assets/icons/edit.svg',
                        onTap: () => isIcon.value = true,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconItem extends StatelessWidget {
  const _IconItem({required this.iconPath, required this.onTap});

  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 30,
        width: 30,
        child: SvgPicture.asset(
          iconPath,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
