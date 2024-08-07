class ShopInfoModel {
  String? name;
  List<String>? email;
  List<String>? phone;
  String? motto;
  int? guestCheckout;
  String? address;
  int? cartAutoOpen;
  String? logo;
  String? favicon;
  String? footerLogo;
  List<Page>? footerPage;
  List<Page>? headerPage;
  List<Page>? helpPage;
  Colors? colors;
  Seo? seo;
  Cookies? cookies;
  Popup? popup;
  CustomScript? customScript;
  String? facebookLink;
  String? linkedinLink;
  String? twitterLink;
  String? youtubeLink;
  String? whatsappLink;
  String? instagramLink;
  String? tiktokLink;
  String? pinterestLink;
  String? googleMapLink;
  String? fbPixelId;
  dynamic gtmId;
  int? isDeliveryChargeRequired;
  int? insideDhakaDeliveryCharges;
  int? outsideDhakaDeliveryCharges;
  int? freeDeliveryChargesLimit;
  String? homeReviewBanner;
  String? reviewVideoLink;
  String? allProductBanner;
  String? flashSaleBanner;
  String? profileBannerImage;
  String? categoryBannerImage;
  String? productDetailsBannerImage;
  int? sliderSection;
  int? sliderBottomSection;
  int? categorySection;
  int? bestSellingSection;
  int? bannerSection;
  int? shopSection;
  int? reviewSection;
  int? brandSection;

  ShopInfoModel({
    this.name,
    this.email,
    this.phone,
    this.motto,
    this.guestCheckout,
    this.address,
    this.cartAutoOpen,
    this.logo,
    this.favicon,
    this.footerLogo,
    this.footerPage,
    this.headerPage,
    this.helpPage,
    this.colors,
    this.seo,
    this.cookies,
    this.popup,
    this.customScript,
    this.facebookLink,
    this.linkedinLink,
    this.twitterLink,
    this.youtubeLink,
    this.whatsappLink,
    this.instagramLink,
    this.tiktokLink,
    this.pinterestLink,
    this.googleMapLink,
    this.fbPixelId,
    this.gtmId,
    this.isDeliveryChargeRequired,
    this.insideDhakaDeliveryCharges,
    this.outsideDhakaDeliveryCharges,
    this.freeDeliveryChargesLimit,
    this.homeReviewBanner,
    this.reviewVideoLink,
    this.allProductBanner,
    this.flashSaleBanner,
    this.profileBannerImage,
    this.categoryBannerImage,
    this.productDetailsBannerImage,
    this.sliderSection,
    this.sliderBottomSection,
    this.categorySection,
    this.bestSellingSection,
    this.bannerSection,
    this.shopSection,
    this.reviewSection,
    this.brandSection,
  });

  factory ShopInfoModel.fromJson(Map<String, dynamic> json) => ShopInfoModel(
    name: json["name"],
    email: json["email"] == null ? [] : List<String>.from(json["email"]!.map((x) => x)),
    phone: json["phone"] == null ? [] : List<String>.from(json["phone"]!.map((x) => x)),
    motto: json["motto"],
    guestCheckout: json["guest_checkout"],
    address: json["address"],
    cartAutoOpen: json["cart_auto_open"],
    logo: json["logo"],
    favicon: json["favicon"],
    footerLogo: json["footer_logo"],
    footerPage: json["footer_page"] == null ? [] : List<Page>.from(json["footer_page"]!.map((x) => Page.fromJson(x))),
    headerPage: json["header_page"] == null ? [] : List<Page>.from(json["header_page"]!.map((x) => Page.fromJson(x))),
    helpPage: json["help_page"] == null ? [] : List<Page>.from(json["help_page"]!.map((x) => Page.fromJson(x))),
    colors: json["colors"] == null ? null : Colors.fromJson(json["colors"]),
    seo: json["seo"] == null ? null : Seo.fromJson(json["seo"]),
    cookies: json["cookies"] == null ? null : Cookies.fromJson(json["cookies"]),
    popup: json["popup"] == null ? null : Popup.fromJson(json["popup"]),
    customScript: json["custom_script"] == null ? null : CustomScript.fromJson(json["custom_script"]),
    facebookLink: json["facebook_link"],
    linkedinLink: json["linkedin_link"],
    twitterLink: json["twitter_link"],
    youtubeLink: json["youtube_link"],
    whatsappLink: json["whatsapp_link"],
    instagramLink: json["instagram_link"],
    tiktokLink: json["tiktok_link"],
    pinterestLink: json["pinterest_link"],
    googleMapLink: json["google_map_link"],
    fbPixelId: json["fb_pixel_id"],
    gtmId: json["gtm_id"],
    isDeliveryChargeRequired: json["is_delivery_charge_required"],
    insideDhakaDeliveryCharges: json["inside_dhaka_delivery_charges"],
    outsideDhakaDeliveryCharges: json["outside_dhaka_delivery_charges"],
    freeDeliveryChargesLimit: json["free_delivery_charges_limit"],
    homeReviewBanner: json["home_review_banner"],
    reviewVideoLink: json["review_video_link"],
    allProductBanner: json["all_product_banner"],
    flashSaleBanner: json["flash_sale_banner"],
    profileBannerImage: json["profile_banner_image"],
    categoryBannerImage: json["category_banner_image"],
    productDetailsBannerImage: json["product_details_banner_image"],
    sliderSection: json["slider_section"],
    sliderBottomSection: json["slider_bottom_section"],
    categorySection: json["category_section"],
    bestSellingSection: json["best_selling_section"],
    bannerSection: json["banner_section"],
    shopSection: json["shop_section"],
    reviewSection: json["review_section"],
    brandSection: json["brand_section"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
    "phone": phone == null ? [] : List<dynamic>.from(phone!.map((x) => x)),
    "motto": motto,
    "guest_checkout": guestCheckout,
    "address": address,
    "cart_auto_open": cartAutoOpen,
    "logo": logo,
    "favicon": favicon,
    "footer_logo": footerLogo,
    "footer_page": footerPage == null ? [] : List<dynamic>.from(footerPage!.map((x) => x.toJson())),
    "header_page": headerPage == null ? [] : List<dynamic>.from(headerPage!.map((x) => x.toJson())),
    "help_page": helpPage == null ? [] : List<dynamic>.from(helpPage!.map((x) => x.toJson())),
    "colors": colors?.toJson(),
    "seo": seo?.toJson(),
    "cookies": cookies?.toJson(),
    "popup": popup?.toJson(),
    "custom_script": customScript?.toJson(),
    "facebook_link": facebookLink,
    "linkedin_link": linkedinLink,
    "twitter_link": twitterLink,
    "youtube_link": youtubeLink,
    "whatsapp_link": whatsappLink,
    "instagram_link": instagramLink,
    "tiktok_link": tiktokLink,
    "pinterest_link": pinterestLink,
    "google_map_link": googleMapLink,
    "fb_pixel_id": fbPixelId,
    "gtm_id": gtmId,
    "is_delivery_charge_required": isDeliveryChargeRequired,
    "inside_dhaka_delivery_charges": insideDhakaDeliveryCharges,
    "outside_dhaka_delivery_charges": outsideDhakaDeliveryCharges,
    "free_delivery_charges_limit": freeDeliveryChargesLimit,
    "home_review_banner": homeReviewBanner,
    "review_video_link": reviewVideoLink,
    "all_product_banner": allProductBanner,
    "flash_sale_banner": flashSaleBanner,
    "profile_banner_image": profileBannerImage,
    "category_banner_image": categoryBannerImage,
    "product_details_banner_image": productDetailsBannerImage,
    "slider_section": sliderSection,
    "slider_bottom_section": sliderBottomSection,
    "category_section": categorySection,
    "best_selling_section": bestSellingSection,
    "banner_section": bannerSection,
    "shop_section": shopSection,
    "review_section": reviewSection,
    "brand_section": brandSection,
  };
}

class Colors {
  String? primary;
  String? primaryText;
  String? primaryHover;
  String? secondary;
  String? secondaryText;
  String? secondaryHover;
  String? defaultText;

  Colors({
    this.primary,
    this.primaryText,
    this.primaryHover,
    this.secondary,
    this.secondaryText,
    this.secondaryHover,
    this.defaultText,
  });

  factory Colors.fromJson(Map<String, dynamic> json) => Colors(
    primary: json["primary"],
    primaryText: json["primary_text"],
    primaryHover: json["primary_hover"],
    secondary: json["secondary"],
    secondaryText: json["secondary_text"],
    secondaryHover: json["secondary_hover"],
    defaultText: json["default_text"],
  );

  Map<String, dynamic> toJson() => {
    "primary": primary,
    "primary_text": primaryText,
    "primary_hover": primaryHover,
    "secondary": secondary,
    "secondary_text": secondaryText,
    "secondary_hover": secondaryHover,
    "default_text": defaultText,
  };
}

class Cookies {
  dynamic cookiesAgreementText;
  int? showCookiesAgreement;

  Cookies({
    this.cookiesAgreementText,
    this.showCookiesAgreement,
  });

  factory Cookies.fromJson(Map<String, dynamic> json) => Cookies(
    cookiesAgreementText: json["cookies_agreement_text"],
    showCookiesAgreement: json["show_cookies_agreement"],
  );

  Map<String, dynamic> toJson() => {
    "cookies_agreement_text": cookiesAgreementText,
    "show_cookies_agreement": showCookiesAgreement,
  };
}

class CustomScript {
  String? headerCustomScript;
  dynamic footerCustomScript;

  CustomScript({
    this.headerCustomScript,
    this.footerCustomScript,
  });

  factory CustomScript.fromJson(Map<String, dynamic> json) => CustomScript(
    headerCustomScript: json["header_custom_script"],
    footerCustomScript: json["footer_custom_script"],
  );

  Map<String, dynamic> toJson() => {
    "header_custom_script": headerCustomScript,
    "footer_custom_script": footerCustomScript,
  };
}

class Page {
  String? name;
  String? path;

  Page({
    this.name,
    this.path,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
    name: json["name"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "path": path,
  };
}

class Popup {
  dynamic popupContent;
  int? showWebsitePopup;
  int? showSubscriberForm;

  Popup({
    this.popupContent,
    this.showWebsitePopup,
    this.showSubscriberForm,
  });

  factory Popup.fromJson(Map<String, dynamic> json) => Popup(
    popupContent: json["popup_content"],
    showWebsitePopup: json["show_website_popup"],
    showSubscriberForm: json["show_subscriber_form"],
  );

  Map<String, dynamic> toJson() => {
    "popup_content": popupContent,
    "show_website_popup": showWebsitePopup,
    "show_subscriber_form": showSubscriberForm,
  };
}

class Seo {
  String? metaTitle;
  String? metaDescription;
  dynamic metaKeyword;
  dynamic metaImage;

  Seo({
    this.metaTitle,
    this.metaDescription,
    this.metaKeyword,
    this.metaImage,
  });

  factory Seo.fromJson(Map<String, dynamic> json) => Seo(
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaKeyword: json["meta_keyword"],
    metaImage: json["meta_image"],
  );

  Map<String, dynamic> toJson() => {
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_keyword": metaKeyword,
    "meta_image": metaImage,
  };
}
