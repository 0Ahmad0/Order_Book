

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

}