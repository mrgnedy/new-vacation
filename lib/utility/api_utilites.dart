class ApiUtilities {
  static String baseApi = "http://vacatiion.net";

  static String loginApi = "/api/auth/login";
  static String registerUserApi = "/api/auth/registerUser";
  static String registerAdvertiserApi = "/api/auth/registerAdvert";

  //---------- Check Stauts --------------------------//
  static String checkStatus = '/api/auth/reservations/checkstatus?token=';
  //---------code verification for Pin Code -----------//
  static String codeVerificationApi = "/api/auth/code";

  //--------------------Password----------------------------//
  static String forgotPassword = "/api/auth/passwordReminder";

  //-----------------update User using Token-------------------//
  static String updateInformationUser = "/api/auth/updateUser?token=";
  static String addOfficer = "/api/auth/shalehat/addreservationofficer?token=";

  //------------------- get All Chalets for Advertiser -------------------//
  static String advertiserChalets = "/api/auth/chalets?token=";

  //------------------- get All Offers for Advertiser -----------------//
  static String advertiserOffers = "/api/auth/offers?token=";

  //--------------------------- Add Chalets -------------------------------//
  static String advertiserADDChalets = "/api/auth/shalehat/chalets?token=";

  //----------------------------Add Offers ---------------------------------//
  static String advertiserADDOffers = "/api/auth/shalehat/chalets";

  //------------------------ get All Chalets for User ---------------------------------//
  static String userChalets = "/api/auth/shalehat/chalets?token=";

  //------------------- get All Offers for Advertiser -----------------//
  static String userOffers = "/api/auth/shalehat/chalets/offers?token=";

  //---------------------------Show Chalet----------------------------//
  static String showChalet = "/api/auth/shalehat/chalets/";

  //--------------------------- ADD Favorites ------------------------//
  static String addFavorites = "/api/auth/favourites/new?token=";

  //---------------------------Check Chalet Available--------------------------//
  static String checkChaletAvailable = "/api/auth/reservations/check?token=";

  //---------------------add Reating----------------------//
  static String allRating = "/api/auth/favourites/new?token=";

  //--------------------Api All Favorites------------------------//
  static String allFavorites = "/api/auth/favourites/all?token=";

  //-------------------Remove Favorites---------------------------//
  static String removeFavorites = "/api/auth/favourites/delete?token=";

  //--------------------  Search ----------------------//
  static String searchByName = "/api/auth/shalehat/searchchalet?token=";
  static String searchByLocation = "/api/auth/search/location?token=";
  static String searchByCity = "/api/auth/shalehat/searchcity?token=";
  static String listCities = "/api/auth/shalehat/cities?token=";
  static String searchByDate = "/api/auth/shalehat/searchdate?token=";
  //-----------------------Filter-----------------------//
  static String searchByFilter = "/api/auth/search/filter?token=";

  //------------------------------ coupon Reservations ---------------------------//
  static String couponReservations = "/api/auth/reservations/new?token=";
  static String checkCoupon = "/api/auth/shalehat/checkcopon?token=";

  //-----------------------
  static String reservationsBill = "/api/auth/reservations/bill?token=";
  static String paymentInfo = "/api/auth/reservations/before?token=";

  //----------------------Banner------------------//
  static String bannerApi = '/api/auth/images';

  //--------------Top5-----------------------//
  static String topFiveApi = "/api/auth/shalehat/chalets/top?token=";

  //--------------------------Add Rating and Comment--------------------------//
  static String addRatingComment = "/api/auth/rates/store?token=";
  static String getRates = '';
  //-------------------------Add Chalet to Offers------------------------------//
  static String addChaletToOffers = "/api/auth/shalehat/chalets/";

  //------------------------Remove Offers---------------------------//
  static String removeOffer = "/api/auth/shalehat/chalets/";

  //---------------------Remove Chalets----------------------------//
  static String removeChalet = "/api/auth/shalehat/chalets/delete/";

  //----------------Terms and Conditions-------------------//
  static String termsApi = "/api/auth/terms";

  //------------------------ Use Policy Api -----------------------//
  static String apiUsePolicy = "/api/auth/privacy_policy";

  //------------------------about us----------------------------//
  static String apiAboutUs = "/api/auth/about_us";

  //-------------------------------Contact us----------------------//
  static String apiContact = "/api/auth/contact?token=";

  //------------------------------Notifications-----------------------------//
  static String apiNotifications = "/api/auth/notifications?token=";

  //---------------------------Reservations User-------------------------------------//
  //---------------------------الحاليه-------------------------------
  static String apiReservationsRecent = "/api/auth/reservations/now?token=";
  //---------------------------قادمه-------------------------------
  static String apiReservationsFuture = "/api/auth/reservations/future?token=";
  //---------------------------سابقه-------------------------------
  static String apiReservationsPast = "/api/auth/reservations/past?token=";

  //------------------------Skip Shalehat----------------------------------//
  static String skipShalehat = "/api/auth/shalehat/skip?";
  //----------------------------skip Offers-------------------------------//
  static String skipOffers = "/api/auth/shalehat/skipOffers";
  //---------------------------skip Show-------------------------------
  static String skipShowhalehat = "/api/auth/shalehat/skipShow/";

  //--------------------------Cancel Reservations-----------------------------------//
  static String cancelReservations = "/api/auth/reservations/delete/";

  //-----------------------send Report---------------------------------------//
  static String reportReservations = "/api/auth/shalehat/chalets/report/";

  //------------------Rereservations month-------------------------//

  static String monthReservations = "/api/auth/reservations/month?token=";
  static String yearReservations = "/api/auth/reservations/year?token=";
  //--------------------------------------------------------------//
  static String payWithVisa = "/api/auth/reservations/payment?token=";

}
