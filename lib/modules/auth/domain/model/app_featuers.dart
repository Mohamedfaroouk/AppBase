import '../../../../core/Router/Router.dart';

enum AppFeatures {
  reports_on,
  copy_rights_visible,
  price_quotation,
  purchase_invoices,
  product_movement,
  refund_purchase,
  refund_order,
  language,
  product_excel,
  product_barcode,
  stocks,
  tax_return,
  categories,
  suppliers,
}

class RouteFeatures {
  final AppFeatures feature;
  final List<String> routes;
  const RouteFeatures({
    required this.routes,
    required this.feature,
  });
}

Map<AppFeatures, List<String>> appFeatures = {
  AppFeatures.reports_on: [
    Routes.reports,
  ],
  AppFeatures.price_quotation: [
    Routes.createQuotation,
    Routes.viewQuotation,
    Routes.quatation,
  ],
  AppFeatures.purchase_invoices: [
    Routes.purchaseInvoice,
    Routes.addPurchaseInvoice,
    Routes.showPurchaseInvoice,
  ],
  AppFeatures.product_movement: [
    Routes.productMovement,
  ],
  AppFeatures.refund_purchase: [
    Routes.refundPurchase,
  ],
  AppFeatures.refund_order: [
    Routes.refundSales,
  ],
  AppFeatures.stocks: [
    Routes.stock,
  ],
  AppFeatures.tax_return: [
    Routes.taxReturn,
  ],
  AppFeatures.categories: [
    Routes.category,
    Routes.editCategory,
    Routes.addCategory,
  ],
  AppFeatures.suppliers: [
    Routes.supplier,
    Routes.addSupplier,
    Routes.editSupplier,
  ],
};
