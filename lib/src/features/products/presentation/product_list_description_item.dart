import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_practice/src/features/products/application/product_provider.dart';
import 'package:ncdc_practice/src/features/products/model/product.dart';

final _currentProduct = Provider<Product>((ref) => throw UnimplementedError());

class ProductListDescription extends HookConsumerWidget {
  const ProductListDescription({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        _currentProduct.overrideWithValue(product),
      ],
      child: ProductListDescriptionItem(
        product: product,
      ),
    );
  }
}

class ProductListDescriptionItem extends HookConsumerWidget {
  const ProductListDescriptionItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAppFocusNode = useFocusNode();
    final itemTitleFocusNode = useFocusNode();
    final appIsFocused = useIsFocused(itemAppFocusNode);
    final titleIsFocused = useIsFocused(itemTitleFocusNode);

    final textAppEditingController = useTextEditingController();
    final textTitleEditingController = useTextEditingController();
    final textFieldAppFocusNode = useFocusNode();
    final textFieldFocusNode = useFocusNode();

    final currentProduct = ref.watch(_currentProduct);

    return Scaffold(
      appBar: AppBar(
        title: Focus(
          focusNode: itemAppFocusNode,
          onFocusChange: (focused) {
            if (focused) {
              textAppEditingController.text = currentProduct.title ?? '';
            } else {
              ref.read(productListProvider.notifier).editTitle(
                  id: currentProduct.productId ?? '',
                  title: textAppEditingController.text);
              Navigator.pop(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appIsFocused
                  ? SizedBox(
                      width: 200,
                      child: TextField(
                        autofocus: true,
                        focusNode: textFieldAppFocusNode,
                        controller: textAppEditingController,
                      ),
                    )
                  // プロダクトのタイトル
                  : Text(currentProduct.title ?? ''),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                itemAppFocusNode.requestFocus();
                textFieldAppFocusNode.requestFocus();
              },
              child: SvgPicture.asset(
                'assets/icons/edit.svg',
              ),
            ),
          ),
        ],
      ),
      body: Focus(
        focusNode: itemTitleFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textTitleEditingController.text = currentProduct.description ?? '';
          } else {
            ref.read(productListProvider.notifier).editDescription(
                id: currentProduct.productId ?? '',
                description: textTitleEditingController.text);
            Navigator.pop(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  itemTitleFocusNode.requestFocus();
                  textFieldFocusNode.requestFocus();
                },
                child: SvgPicture.asset(
                  'assets/icons/edit.svg',
                  color: Colors.blueAccent,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                itemTitleFocusNode.requestFocus();
                textFieldFocusNode.requestFocus();
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: titleIsFocused
                    ? TextField(
                        autofocus: true,
                        focusNode: textFieldFocusNode,
                        controller: textTitleEditingController,
                      )
                    // プロダクトの詳細
                    : Text(currentProduct.description ?? ''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool useIsFocused(FocusNode node) {
  final isFocused = useState(node.hasFocus);

  useEffect(
    () {
      void listener() {
        isFocused.value = node.hasFocus;
      }

      node.addListener(listener);
      return () => node.removeListener(listener);
    },
    [node],
  );
  return isFocused.value;
}
