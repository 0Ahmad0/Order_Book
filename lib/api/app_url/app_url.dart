

class AppUrl{
  static const String baseUrl ="http://order-book.chi-team.com/api/";
  static const String baseUrlImage ="http://order-book.chi-team.com";
  static const String baseUrl1 ="http://order-book.chi-team.com/api";
  static const String register =baseUrl+"user/register";
  static const String login =baseUrl+"user/login";
  static const String logout =baseUrl+"user/logout";
  static const String checkNumber =baseUrl+"user/checkNumber";
  static const String updateProfile =baseUrl+"user/update";
  static const String deleteProfile =baseUrl+"user/deleteMyAccount";

  static const String trendingItems =baseUrl+"item/trendingItems";
  static const String trendingOffers =baseUrl+"offer/availableOffers";
  static const String ratingRestaurant =baseUrl+"vendor/getVendorsByRating";
  static const String locationRestaurant =baseUrl+"vendor/getVendorsByLocation";// /33.7/36.7
  static const String searchRestaurant =baseUrl+"vendor/searchByName/";// /a
  static const String trendingRestaurant =baseUrl+"vendor/getTrendingVendors";
  static const String addFavourite =baseUrl+"vendor/favourite/";
  static const String deleteFavourite =baseUrl+"vendor/favourite/";
  static const String tables =baseUrl+"vendor/map/";
  static const String addReservations =baseUrl+"reservation/import";
  static const String menuVendor =baseUrl+"vendor/menu/getByVendorId/";
  static const String myPendingReservations =baseUrl+"reservation/getMyPendingReservations";
  static const String myCancelledReservations =baseUrl+"reservation/getMyCancelledReservations";
  static const String acceptedReservations =baseUrl+"reservation/getMyAcceptedReservations";
  static const String myRejectedReservations =baseUrl+"reservation/getMyRejectedReservations";

  static const String myPendingOrders=baseUrl+"order/getMyPendingOrders";
  static const String myCancelledOrders =baseUrl+"order/getMyCancelledOrders";
  static const String myServedOrders =baseUrl+"order/getMyServedOrders";
  static const String myRejectedOrders =baseUrl+"order/getMyRejectedOrders";

}