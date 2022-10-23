

class AppUrl{
  static const  baseUrl ="http://order-book.chi-team.com/api/";
  static const  baseUrlImage ="http://order-book.chi-team.com";
  static const  baseUrl1 ="http://order-book.chi-team.com/api";
  static const  register ="${baseUrl}user/register";
  static const  login ="${baseUrl}user/login";
  static const  logout ="${baseUrl}user/logout";
  static const  checkNumber ="${baseUrl}user/checkNumber";
  static const  updateProfile ="${baseUrl}user/update";
  static const  deleteProfile ="${baseUrl}user/deleteMyAccount";

  static const  trendingItems ="${baseUrl}item/trendingItems";
  static const  trendingOffers ="${baseUrl}offer/availableOffers";
  static const  ratingRestaurant ="${baseUrl}vendor/getVendorsByRating";
  static const  locationRestaurant ="${baseUrl}vendor/getVendorsByLocation";// /33.7/36.7
  static const  searchRestaurant ="${baseUrl}vendor/searchByName/";// /a
  static const  trendingRestaurant ="${baseUrl}vendor/getTrendingVendors";
  static const  addFavourite ="${baseUrl}vendor/favourite/";
  static const  deleteFavourite ="${baseUrl}vendor/favourite/";
  static const  tables ="${baseUrl}vendor/map/";
  static const  addReservations ="${baseUrl}reservation/import";
  static const  menuVendor ="${baseUrl}vendor/menu/getByVendorId/";
  static const  menuQr ="${baseUrl}vendor/menu/";
  static const  myPendingReservations ="${baseUrl}reservation/getMyPendingReservations";
  static const  myCancelledReservations ="${baseUrl}reservation/getMyCancelledReservations";
  static const  acceptedReservations ="${baseUrl}reservation/getMyAcceptedReservations";
  static const  myRejectedReservations ="${baseUrl}reservation/getMyRejectedReservations";

  static const  addOrder ="${baseUrl}order/create";

  static const  myPendingOrders="${baseUrl}order/getMyPendingOrders";
  static const  myCancelledOrders ="${baseUrl}order/getMyCancelledOrders";
  static const  myServedOrders ="${baseUrl}order/getMyServedOrders";
  static const  myRejectedOrders ="${baseUrl}order/getMyRejectedOrders";
  static const  myAcceptedOrders ="${baseUrl}order/getMyAcceptedOrders";
  static const  FCM_Token ="${baseUrl}user/FCM_Token";
  static const  Language ="${baseUrl}user/updateLanguage";
  static const  cancelledReservation ="${baseUrl}reservation/cancel/";

}