import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/store_product.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:mobile_poss_gp01/events/product_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/repositories/product_repository.dart';
import 'package:mobile_poss_gp01/resources/static_values.dart';
import 'package:mobile_poss_gp01/states/product_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';

class ProductBloc extends AbstractBloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final AuthenticationRepository authenticationRepository;
  final CustomerSessionRepository customerSessionRepository;

  ProductBloc(
      {required this.authenticationRepository,
      required this.productRepository,
      required this.customerSessionRepository})
      : super(ProductLoadInitial()) {
    on<ProductItemFetched>(_itemFetched);
  }

  Future<void> _itemFetched(ProductItemFetched event, Emitter<ProductState> emit) async {
    emit(ProductLoadInProgress());
    String searchText = event.value;
    bool isCatalogItemCode = StaticValues.catalogItemCodeRegexp.hasMatch(event.value);
    String catalogItemCode;
    Earmark? earmark;

    StoreProduct storeProduct;
    Employee employee = await authenticationRepository.getEmployee();
    ;
    /* 如果小於8碼不搜尋*/
    if (searchText.length < 8) {
      Logger.debug(message: "ProductBloc _itemFetched searchText.length < 8");
      emit(const ProductLoadFailure("輸入內容不得小於8碼"));
      return;
    }

    if (customerSessionRepository.currentCustomerSession(employee) == null) {
      Logger.debug(message: "ProductBloc currentCustomerSession is empty");
      emit(ProductLoadFailure("widget.showAddToCartDialog.message.createdCustomerSession".tr));
      return;
    }

    if (isCatalogItemCode) {
      catalogItemCode = searchText;
      /* catalogItem */
      Logger.info(
          className: "ProductBloc", event: "_itemFetched", message: "search text $searchText is catalogItemCode");
      earmark = productRepository.findEarmarkByCatalogItem(searchText);

      if (earmark == null) {
        emit(const ProductLoadFailure("查無此商品"));
        return;
      } else {
        Logger.info(message: "found productItem in earmark $earmark");
        storeProduct = StoreProduct(earmark: earmark);
      }
    } else {
      /* inventoryId or itemNumber */
      Logger.info(message: "search text $searchText is inventoryId or itemNumber");
      storeProduct = productRepository.getProductItemByItemNumberOrInventoryId(searchText, employee);

      if (!storeProduct.isInStore && storeProduct.earmark == null) {
        /* 不在本店也不在earmark */
        emit(const ProductLoadFailure("查無此商品"));
        return;
      }
      catalogItemCode = storeProduct.inventory!.catalogItem!;
    }

    /* 本店catalogItem商品 */
    List<StoreProduct> storeCatalogItems =
        productRepository.getProductItemFromStoreByCatalogItem(catalogItemCode, employee);
    storeProduct.storeCatalogItems = storeCatalogItems;

    if (storeProduct.isInStore) {
      Logger.debug(message: "ProductStoreLoadSuccess");
      emit(ProductStoreLoadSuccess(storeProduct));
    } else {
      Logger.debug(message: "ProductRemotedLoadSuccess");
      emit(ProductRemotedLoadSuccess());
    }
  }
}
