
BDModel bdModel = BDModel();
class BDModel {
//  returns division list in bangla
  List<String> getDivisionListBn(){
    List<String> divisionList = ['বরিশাল', 'চট্টগ্রাম', 'ঢাকা', 'খুলনা', 'রাজশাহী', 'রংপুর', 'সিলেট', 'ময়মনসিংহ'];
    return divisionList;
  }

//  returns district list in bangla
  List<String> getDistrictListBn(String division){
    List<String> districtList = [];
    switch(division){
      case 'বরিশাল':
        districtList = getBarisalDistrictListBn();
        break;
      case 'চট্টগ্রাম':
        districtList = getChattogramDistrictListBn();
        break;
      case 'ঢাকা':
        districtList = getDhakaDistrictListBn();
        break;
      case 'খুলনা':
        districtList = getKhulnaDistrictListBn();
        break;
      case 'রাজশাহী':
        districtList = getRajshahiDistrictListBn();
        break;
      case 'রংপুর':
        districtList = getRangpurDistrictListBn();
        break;
      case 'সিলেট':
        districtList = getSylhetDistrictListBn();
        break;
      case 'ময়মনসিংহ':
        districtList = getMymensinghDistrictListBn();
        break;
      default:
        break;
    }
    return districtList;
  }

//  returns sub-district(upazila) list in bangla

  List<String> getSubDistrictListBn(String district){
    List<String> upazilaList = [];
    switch(district){

//    চট্টগ্রাম বিভাগ

      case 'কুমিল্লা':
        upazilaList = ['দেবিদ্বার', 'বরুড়া', 'চান্দিনা', 'দাউদকান্দি', 'হোমনা', 'মুরাদনগর', 'মেঘনা',
          'তিতাস'];
        break;

      case 'ফেনী':
        upazilaList = ['ফেনী সদর', 'সোনাগাজী', 'ফুলগাজী', 'দাগনভূঞা'];
        break;

      case 'ব্রাহ্মণবাড়িয়া':
        upazilaList = ['ব্রাহ্মণবাড়িয়া সদর', 'নাসিরনগর', 'সরাইল', 'নবীনগর'];
        break;

      case 'রাঙ্গামাটি':
        upazilaList = ['বাঘাইছড়ি', 'রাজস্থলী'];
        break;

      case 'নোয়াখালি':
        upazilaList = ['নোয়াখালি', 'কবিরহাট', 'সোনাইমুড়ী'];
        break;

      case 'চাঁদপুর':
        upazilaList = ['কচুয়া', 'চাঁদপুর সদর', 'হাজীগঞ্জ', 'ফরিদগঞ্জ'];
        break;

      case 'লক্ষ্মীপুর':
        upazilaList = ['লক্ষ্মীপুর সদর', 'রামগতি', 'রামগঞ্জ'];
        break;

      case 'চট্টগ্রাম':
        upazilaList = ['পটিয়া', 'বাঁশখালী', 'বোয়ালখালী', 'চন্দনাইশ', 'হাটহাজারী', 'কর্ণফুলী'];
        break;

      case 'কক্সবাজার':
        upazilaList = ['চকরিয়া', 'রামু', 'টেকনাফ'];
        break;

      case 'খাগড়াছড়ি':
        upazilaList = ['পানছড়ি', 'লক্ষীছড়ি', 'রামগড়', 'মাটিরাঙ্গা'];
        break;

      case 'বান্দরবান':
        upazilaList = ['বান্দরবান সদর', 'রুমা'];
        break;

//    রাজশাহী বিভাগ

      case 'সিরাজগঞ্জ':
        upazilaList = [' কাজীপুর'];
        break;

      case 'পাবনা':
        upazilaList = ['সুজানগর', ' বেড়া'];
        break;

      case 'বগুড়া':
        upazilaList = ['শাজাহানপুর', 'আদমদিঘি উপজেলা', 'গাবতলী', 'শেরপুর উপজেলা'];
        break;

      case 'রাজশাহী':
        upazilaList = ['মোহনপুর', 'গোদাগাড়ী'];
        break;

      case 'নাটোর':
        upazilaList = [' সিংড়া', ' বড়াইগ্রাম', ' লালপুর'];
        break;

      case 'জয়পুরহাট':
        upazilaList = ['আক্কেলপুর উপজেলা', ' কালাই উপজেলা', ' ক্ষেতলাল উপজেলা', ' পাঁচবিবি উপজেলা'];
        break;

      case 'চাঁপাইনবাবগঞ্জ':
        upazilaList = ['চাঁপাইনবাবগঞ্জ সদর', ' গোমস্তাপুর', ' নাচোল', ' ভোলাহাট', ' শিবগঞ্জ'];
        break;

      case 'নওগাঁ':
        upazilaList = ['নিয়ামতপুর', 'মান্দা', 'রাণীনগর', 'সাপাহার'];
        break;

//    খুলনা বিভাগ

      case 'যশোর':
        upazilaList = ['অভয়নগর', 'চৌগাছা', 'ঝিকরগাছা', 'কেশবপুর',
          'যশোর সদর', 'শার্শা'];
        break;

      case 'সাতক্ষীরা':
        upazilaList = ['আশাশুনি', 'দেবহাটা', 'কলারোয়া', 'সাতক্ষীরা সদর', 'শ্যামনগর', 'তালা'];
        break;

      case 'মেহেরপুর':
        upazilaList = ['মুজিবনগর', 'মেহেরপুর সদর'];
        break;

      case 'নড়াইল':
        upazilaList = ['নড়াইল সদর', 'কালিয়া'];
        break;

      case 'চুয়াডাঙ্গা':
        upazilaList = ['আলমডাঙ্গা', 'দামুড়হুদা'];
        break;

      case 'কুষ্টিয়া':
        upazilaList = ['কুষ্টিয়া সদর', 'কুমারখালী', 'খোকসা', 'ভেড়ামারা'];
        break;

      case 'মাগুরা':
        upazilaList = ['শালিখা', 'মাগুরা সদর', 'মহম্মদপুর'];
        break;

      case 'খুলনা':
        upazilaList = ['পাইকগাছা', 'ফুলতলা', 'দিঘলিয়া', 'রূপসা', 'তেরখাদা',
          'দাকোপ উপজেলা'];
        break;

      case 'বাগেরহাট':
        upazilaList = ['ফকিরহাট', 'বাগেরহাট সদর', 'মোল্লাহাট', 'শরণখোলা', 'রামপাল', 'মোড়েলগঞ্জ',
          'মোংলা', 'চিতলমারী'];
        break;

      case 'ঝিনাইদহ':
        upazilaList = ['ঝিনাইদহ সদর', 'শৈলকুপা', 'হরিণাকুন্ডু', 'মহেশপুর'];
        break;

//    বরিশাল বিভাগ

      case 'ঝালকাঠি':
        upazilaList = ['রাজাপুর'];
        break;

      case 'পটুয়াখালী':
        upazilaList = ['বাউফল', 'পটুয়াখালী সদর', 'দুমকি', 'দশমিনা', 'কলাপাড়া', 'মির্জাগঞ্জ', 'গলাচিপা'];
        break;

      case 'পিরোজপুর':
        upazilaList = ['নাজিরপুর', 'কাউখালী', 'ভান্ডারিয়া', 'ইন্দুরকানী'];
        break;

      case 'বরিশাল':
        upazilaList = ['বাবুগঞ্জ', 'উজিরপুর ', 'মেহেন্দিগঞ্জ'];
        break;

      case 'ভোলা':
        upazilaList = ['ভোলা সদর', 'চরফ্যাশন', 'দৌলতখান',
          'লালমোহন'];
        break;

      case 'বরগুনা':
        upazilaList = ['আমতলী', 'বরগুনা সদর', 'বামনা'];
        break;

//    সিলেট বিভাগ

      case 'সিলেট':
        upazilaList = ['বালাগঞ্জ', 'ফেঞ্চুগঞ্জ', 'গোলাপগঞ্জ', 'কানাইঘাট'];
        break;

      case 'মৌলভীবাজার':
        upazilaList = ['বড়লেখা', 'কমলগঞ্জ', 'কুলাউড়া', 'রাজনগর', 'শ্রীমঙ্গল',
          'জুড়ী'];
        break;

      case 'হবিগঞ্জ':
        upazilaList = ['নবীগঞ্জ', 'বাহুবল', 'বানিয়াচং', 'মাধবপুর উপজেলা'];
        break;

      case 'সুনামগঞ্জ':
        upazilaList = ['সুনামগঞ্জ সদর', 'ছাতক', 'জগন্নাথপুর', 'জামালগঞ্জ', 'শাল্লা'];
        break;

//    ঢাকা বিভাগ

      case 'নরসিংদী':
        upazilaList = ['বেলাবো', 'মনোহরদী', 'নরসিংদী', 'পলাশ', 'শিবপুর'];
        break;

      case 'গাজীপুর':
        upazilaList = ['কালীগঞ্জ', 'কালিয়াকৈর', 'কাপাসিয়া', 'গাজীপুর সদর', 'শ্রীপুর'];
        break;

      case 'শরীয়তপুর':
        upazilaList = ['নড়িয়া', 'জাজিরা', 'গোসাইরহাট', 'ভেদরগঞ্জ', 'ডামুড্যা'];
        break;

      case 'নারায়ণগঞ্জ':
        upazilaList = ['বন্দর', 'রূপগঞ্জ', 'সোনারগাঁ'];
        break;

      case 'টাঙ্গাইল':
        upazilaList = ['বাসাইল', 'ভুয়াপুর', 'দেলদুয়ার', 'টাঙ্গাইল সদর', 'কালিহাতী',
          'ধনবাড়ী'];
        break;

      case 'কিশোরগঞ্জ':
        upazilaList = ['ইটনা', 'কটিয়াদী', 'ভৈরব', 'তাড়াইল', 'হোসেনপুর', 'পাকুন্দিয়া',
          'কিশোরগঞ্জ সদর', 'করিমগঞ্জ', 'বাজিতপুর', 'অষ্টগ্রাম', 'নিকলী'];
        break;

      case 'মানিকগঞ্জ':
        upazilaList = ['হরিরামপুর', 'সাটুরিয়া', 'মানিকগঞ্জ সদর', 'ঘিওর', 'শিবালয়', 'দৌলতপুর'];
        break;

      case 'ঢাকা':
        upazilaList = ['সাভার', 'ধামরাই', 'কেরাণীগঞ্জ', 'নবাবগঞ্জ', 'দোহার', 'মিরপুর'];
        break;

      case 'মুন্সিগঞ্জ':
        upazilaList = ['মুন্সিগঞ্জ সদর', 'শ্রীনগর', 'সিরাজদিখান', 'লৌহজং', 'গজারিয়া', 'টংগীবাড়ি'];
        break;

      case 'রাজবাড়ী':
        upazilaList = ['রাজবাড়ী সদর', 'পাংশা'];
        break;

      case 'মাদারীপুর':
        upazilaList = ['শিবচর', 'কালকিনি'];
        break;

      case 'গোপালগঞ্জ':
        upazilaList = ['গোপালগঞ্জ সদর', 'কাশিয়ানী', 'মুকসুদপুর'];
        break;

      case 'ফরিদপুর':
        upazilaList = ['ফরিদপুর সদর', 'আলফাডাঙ্গা', 'বোয়ালমারী', 'সদরপুর', 'নগরকান্দা', 'ভাঙ্গা'];
        break;

      case 'জামালপুর':
        upazilaList = [ 'ইসলামপুর', 'দেওয়ানগঞ্জ', 'মাদারগঞ্জ', 'বকশীগঞ্জ'];
        break;

//    রংপুর বিভাগ

      case 'পঞ্চগড়':
        upazilaList = ['পঞ্চগড়', 'দেবীগঞ্জ', 'বোদা', 'আটোয়ারী'];
        break;

      case 'দিনাজপুর':
        upazilaList = ['বীরগঞ্জ উপজেলা', 'ঘোড়াঘাট', 'বিরামপুর', 'পার্বতীপুর উপজেলা', 'বোচাগঞ্জ উপজেলা',
          'ফুলবাড়ী উপজেলা', 'দিনাজপুর সদর', 'হাকিমপুর উপজেলা', 'খানসামা', 'চিরিরবন্দর উপজেলা'];
        break;

      case 'লালমনিরহাট':
        upazilaList = ['লালমনিরহাট সদর', 'হাতীবান্ধা', 'আদিতমারী উপজেলা'];
        break;

      case 'নীলফামারি':
        upazilaList = ['ডিমলা', 'জলঢাকা', 'নীলফামারি সদর'];
        break;

      case 'গাইবান্ধা':
        upazilaList = ['সাদুল্লাপুর', 'গাইবান্ধা সদর', 'পলাশবাড়ী'];
        break;

      case 'ঠাকুরগাঁও':
        upazilaList = ['ঠাকুরগাঁও সদর', 'পীরগঞ্জ উপজেলা', 'রাণীশংকৈল উপজেলা', 'হরিপুর উপজেলা',
          'বালিয়াডাঙ্গী উপজেলা'];
        break;

      case 'রংপুর':
        upazilaList = ['পীরগঞ্জ'];
        break;

      case 'কুড়িগ্রাম':
        upazilaList = ['কুড়িগ্রাম সদর', 'রাজারহাট', 'উলিপুর', 'চিলমারী'];
        break;

//    ময়মনসিংহ বিভাগ

      case 'শেরপুর':
        upazilaList = ['শেরপুর সদর', 'নকলা'];
        break;

      case 'ময়মনসিংহ':
        upazilaList = ['ফুলবাড়ীয়া', 'ত্রিশাল', 'ভালুকা', 'হালুয়াঘাট', 'গফরগাঁও'];
        break;

      case 'নেত্রকোণা':
        upazilaList = ['দুর্গাপুর','কলমাকান্দা', 'মোহনগঞ্জ', 'পূর্বধলা', 'নেত্রকোণা সদর'];
        break;

      default:
        break;
    }
    return upazilaList;
  }

//  _____________________________________________________________________

//  all district list

  List<String> getBarisalDistrictListBn(){
    List<String> districtList = ['বরিশাল সিটি কর্পোরেশন', 'বরিশাল', 'ভোলা', 'বরগুনা',
      'পিরোজপুর', 'পটুয়াখালী', 'ঝালকাঠি'];
    return districtList;
  }

  List<String> getChattogramDistrictListBn(){
    List<String> districtList = ['চট্টগ্রাম সিটি কর্পোরেশন', 'কুমিল্লা সিটি কর্পোরেশন', 'লক্ষ্মীপুর',
      'রাঙ্গামাটি', 'ব্রাহ্মণবাড়িয়া', 'বান্দরবান', 'ফেনী', 'নোয়াখালি', 'চাঁদপুর', 'চট্টগ্রাম', 'খাগড়াছড়ি',
      'কুমিল্লা', 'কক্সবাজার'];
    return districtList;
  }

  List<String> getDhakaDistrictListBn(){
    List<String> districtList = ['ঢাকা উত্তর সিটি কর্পোরেশন', 'ঢাকা দক্ষিণ সিটি কর্পোরেশন',
      'গাজীপুর সিটি কর্পোরেশন', 'নারায়ণগঞ্জ সিটি কর্পোরেশন', 'ঢাকা', 'শরিয়তপুর', 'রাজবাড়ি', 'মুন্সিগঞ্জ',
      'মানিকগঞ্জ', 'মাদারিপুর', 'ফরিদপুর', 'নারায়ণগঞ্জ', 'নরসিংদি', 'টাঙ্গাইল', 'গোপালগঞ্জ', 'গাজীপুর', 'কিশোরগঞ্জ'];
    return districtList;
  }

  List<String> getKhulnaDistrictListBn(){
    List<String> districtList = ['খুলনা সিটি কর্পোরেশন', 'সাতক্ষীরা', 'যশোর', 'মেহেরপুর',
      'মাগুরা', 'বাগেরহাট', 'নড়াইল', 'ঝিনাইদহ', 'চুয়াডাঙ্গা', 'খুলনা', 'কুষ্টিয়া'];
    return districtList;
  }

  List<String> getMymensinghDistrictListBn(){
    List<String> districtList = ['ময়মনসিংহ সিটি কর্পোরেশন', 'শেরপুর', 'ময়মনসিংহ', 'নেত্রকোনা', 'জামালপুর'];
    return districtList;
  }

  List<String> getRajshahiDistrictListBn(){
    List<String> districtList = ['রাজশাহী সিটি কর্পোরেশন', 'সিরাজগঞ্জ', 'রাজশাহী', 'বগুড়া',
        'পাবনা', 'নাটোর', 'নওগাঁ', 'জয়পুরহাট', 'চাঁপাইনবাবগঞ্জ'];
    return districtList;
  }

  List<String> getRangpurDistrictListBn(){
    List<String> districtList = ['রংপুর সিটি কর্পোরেশন', 'লালমনিরহাট', 'রংপুর', 'পঞ্চগড়',
      'নীলফামারি', 'দিনাজপুর', 'ঠাকুরগাঁও', 'গাইবান্ধা', 'কুড়িগ্রাম'];
    return districtList;
  }

  List<String> getSylhetDistrictListBn(){
    List<String> districtList = ['সিলেট সিটি কর্পোরেশন', 'হবিগঞ্জ', 'সুনামগঞ্জ', 'সিলেট', 'মৌলভীবাজার'];
    return districtList;
  }

}