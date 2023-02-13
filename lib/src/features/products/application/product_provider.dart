import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_practice/src/features/products/model/product.dart';
import 'package:uuid/uuid.dart';

final productListProvider = StateNotifierProvider<ProductList, List<Product>>((ref) {
  return ProductList([
    const Product(
        productId: '0',
        author: '夏目漱石',
        title: '坊ちゃん',
        description:
        '「親譲りの無鉄砲で子供の時から損ばかりしている。小学校に居る時分学校の二階から飛び降りて一週間程腰を抜かした事がある。なぜそんな無闇（むやみ）をしたと聞く人があるかもしれぬ。別段深い理由でもない。新築の二階から首を出していたら，同級生の一人が冗談に，いくら威張っても，そこから飛び降りる事は出来まい。弱虫や－い。と囃（はや）し立てたからである。小使いに負ぶさって帰ってきた時，おやじが大きな眼をして二階位から飛び降りて腰を抜かす奴があるかと云ったから，この次は抜かさずに飛んで見せますと答えた。」'),
    const Product(
        productId: '1',
        author: '鴨長明',
        title: '方丈記',
        description:
        'ゆく河の流れは絶ずして、しかももとの水にあらず。よどみに浮ぶうたかたは、かつ消え、かつ結びて、久しくとどまりたるためしなし。世の中にある人と栖と、またかくのごとし。たましきの都のうちに棟を並べ、甍を争へる高き賤しき人の住ひは、世々を経て尽きせぬものなれど、これをまことかと尋ぬれば、昔ありし家は稀なり。或は去年焼けて、今年作れり。或は大家ほろびて小家となる。住む人もこれに同じ。所も変らず、人も多かれど、いにしへ見し人は、ニ三十人が中にわづかにひとりふたりなり。朝に死に夕に生るるならひ、ただ水の泡にぞ似たりける。知らず、生れ死ぬる人いづかたより来りて、いづかたへか去る。また知らず、仮の宿り、誰がためにか心を悩まし、何によりてか目を喜ばしむる。その主と栖と無常を争ふさま、いはばあさがほの露に異ならず。或は露落ちて、花残れり。残るといへども、朝日に枯れぬ。或は花しぼみて、露なほ消えず。消えずといへども、夕を待つ事なし。')
  ]);
});


class ProductList extends StateNotifier<List<Product>> {
  ProductList(List<Product> state) : super(state);

  void add(String title, String description) {
    state = [
      ...state,
      Product(
        productId: const Uuid().v4(),
        title: title,
        description: description,
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final product in state)
        if (product.productId == id)
          Product(
            productId: product.productId,
            description: product.description,
          )
        else
          product,
    ];
  }

  void editTitle({required String id, required String title}) {
    state = [
      for (final product in state)
        if (product.productId == id)
          Product(
            productId: id,
            title: title,
            author: product.author,
            description: product.description,
          )
        else
          product,
    ];
  }

  void editDescription({required String id, required String description}) {
    state = [
      for (final product in state)
        if (product.productId == id)
          Product(
            productId: id,
            title: product.title,
            author: product.author,
            description: description,
          )
        else
          product,
    ];
  }

  void remove(Product target) {
    state = state
        .where((product) => product.productId != target.productId)
        .toList();
  }
}
