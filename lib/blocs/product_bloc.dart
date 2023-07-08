import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/store_product_info.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:mobile_poss_gp01/events/product_event.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/repositories/product_repository.dart';
import 'package:mobile_poss_gp01/resources/static_values.dart';
import 'package:mobile_poss_gp01/states/product_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:realm/realm.dart';

class ProductBloc extends AbstractBloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final AuthenticationRepository authenticationRepository;

  ProductBloc({required this.authenticationRepository, required this.productRepository}) : super(ProductLoadInitial()) {
    on<ProductItemFetched>(_itemFetched);
  }

  Future<void> _itemFetched(ProductItemFetched event, Emitter<ProductState> emit) async {
    emit(ProductLoadInProgress());
    String searchText = event.value;
    bool isCatalogItemCode = StaticValues.catalogItemCodeRegexp.hasMatch(event.value);
    String catalogItemCode;
    Earmark? earmark;

    StoreProductInfo storeProductInfo;
    Map<String, dynamic> userInfo = await authenticationRepository.getTokenInfo();
    List<String> displayName = userInfo['displayName'].toString().split(" ");
    Employee employee = Employee(displayName.elementAt(1), userInfo['uid'][0], displayName.elementAt(0), []);
    /* 如果小於8碼不搜尋*/
    if (searchText.length < 8) {
      Logger.debug(message: "ProductBloc _itemFetched searchText.length < 8");
      emit(const ProductLoadFailure("輸入內容不得小於8碼"));
    }

    if (isCatalogItemCode) {
      catalogItemCode = searchText;
      /* catalogItem */
      Logger.info(
          className: "ProductBloc", event: "_itemFetched", message: "search text $searchText is catalogItemCode");
      earmark = productRepository.findEarmarkByCatalogItem(searchText);

      if (earmark == null) {
        throw RealmException("findProductBySearchText productItem not found in earmark");
      } else {
        Logger.info(message: "found productItem in earmark $earmark");
        storeProductInfo = StoreProductInfo(earmark: earmark);
      }
    } else {
      /* inventoryId or itemNumber */
      Logger.info(message: "search text $searchText is inventoryId or itemNumber");
      storeProductInfo = productRepository.getProductItemByItemNumberOrInventoryId(searchText, employee);

      if (!storeProductInfo.isInStore && storeProductInfo.earmark == null) {
        /* 不在本店也不在earmark */
        throw RealmException("findProductBySearchText productItem not found");
      }
      catalogItemCode = storeProductInfo.inventory!.catalogItem!;
    }

    /* 本店catalogItem商品 */
    List<StoreProductInfo> storeCatalogItems =
        productRepository.getProductItemFromStoreByCatalogItem(catalogItemCode, employee);
    storeProductInfo.storeCatalogItems = storeCatalogItems;

    if (storeProductInfo.isInStore) {
      Logger.debug(message: "ProductStoreLoadSuccess");
      emit(ProductStoreLoadSuccess());
    } else {
      Logger.debug(message: "ProductRemotedLoadSuccess");
      emit(ProductRemotedLoadSuccess());
    }
  }

// Earmark? _getEarmarkByCatalogItem(String catalogItem) {
//   try {
//     Earmark? earmark = realmService.realm.query<Earmark>(r'catalogItem ==[c] $0', [catalogItem]).firstOrNull;
//     realmService.loggerNewRelicInfo("getEarmarkByCatalogItem", "catalogItem [$catalogItem]");
//     return earmark;
//   } catch (e) {
//     realmService.loggerNewRelicError("getEarmarkByCatalogItem", "catalogItem [$catalogItem]");
//     rethrow;
//   }
// }
}
