class DetailModelEntity {
	String code;
	DetailModelData data;
	String message;

	DetailModelEntity({this.code, this.data, this.message});

	DetailModelEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		data = json['data'] != null ? new DetailModelData.fromJson(json['data']) : null;
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['message'] = this.message;
		return data;
	}
}

class DetailModelData {
	DetailModelDataGoodinfo goodInfo;
	List<Null> goodComments;
	DetailModelDataAdvertespicture advertesPicture;

	DetailModelData({this.goodInfo, this.goodComments, this.advertesPicture});

	DetailModelData.fromJson(Map<String, dynamic> json) {
		goodInfo = json['goodInfo'] != null ? new DetailModelDataGoodinfo.fromJson(json['goodInfo']) : null;
		if (json['goodComments'] != null) {
			goodComments = new List<Null>();
		}
		advertesPicture = json['advertesPicture'] != null ? new DetailModelDataAdvertespicture.fromJson(json['advertesPicture']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.goodInfo != null) {
      data['goodInfo'] = this.goodInfo.toJson();
    }
		if (this.goodComments != null) {
      data['goodComments'] =  [];
    }
		if (this.advertesPicture != null) {
      data['advertesPicture'] = this.advertesPicture.toJson();
    }
		return data;
	}
}

class DetailModelDataGoodinfo {
	String image5;
	int amount;
	String image3;
	String image4;
	String goodsId;
	String isOnline;
	String image1;
	String image2;
	String goodsSerialNumber;
	double oriPrice;
	double presentPrice;
	String comPic;
	int state;
	String shopId;
	String goodsName;
	String goodsDetail;

	DetailModelDataGoodinfo({this.image5, this.amount, this.image3, this.image4, this.goodsId, this.isOnline, this.image1, this.image2, this.goodsSerialNumber, this.oriPrice, this.presentPrice, this.comPic, this.state, this.shopId, this.goodsName, this.goodsDetail});

	DetailModelDataGoodinfo.fromJson(Map<String, dynamic> json) {
		image5 = json['image5'];
		amount = json['amount'];
		image3 = json['image3'];
		image4 = json['image4'];
		goodsId = json['goodsId'];
		isOnline = json['isOnline'];
		image1 = json['image1'];
		image2 = json['image2'];
		goodsSerialNumber = json['goodsSerialNumber'];
		oriPrice = json['oriPrice'];
		presentPrice = json['presentPrice'];
		comPic = json['comPic'];
		state = json['state'];
		shopId = json['shopId'];
		goodsName = json['goodsName'];
		goodsDetail = json['goodsDetail'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image5'] = this.image5;
		data['amount'] = this.amount;
		data['image3'] = this.image3;
		data['image4'] = this.image4;
		data['goodsId'] = this.goodsId;
		data['isOnline'] = this.isOnline;
		data['image1'] = this.image1;
		data['image2'] = this.image2;
		data['goodsSerialNumber'] = this.goodsSerialNumber;
		data['oriPrice'] = this.oriPrice;
		data['presentPrice'] = this.presentPrice;
		data['comPic'] = this.comPic;
		data['state'] = this.state;
		data['shopId'] = this.shopId;
		data['goodsName'] = this.goodsName;
		data['goodsDetail'] = this.goodsDetail;
		return data;
	}
}

class DetailModelDataAdvertespicture {
	String toPlace;
	String pictureAddress;

	DetailModelDataAdvertespicture({this.toPlace, this.pictureAddress});

	DetailModelDataAdvertespicture.fromJson(Map<String, dynamic> json) {
		toPlace = json['TO_PLACE'];
		pictureAddress = json['PICTURE_ADDRESS'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['TO_PLACE'] = this.toPlace;
		data['PICTURE_ADDRESS'] = this.pictureAddress;
		return data;
	}
}
