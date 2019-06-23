class CartInfoEntity {
	String images;
	String goodsId;
	double price;
	int count;
	String goodsName;
	bool isCheck;

	CartInfoEntity({this.images, this.goodsId, this.price, this.count, this.goodsName,this.isCheck});

	CartInfoEntity.fromJson(Map<String, dynamic> json) {
		images = json['images'];
		goodsId = json['goodsId'];
		price = json['price'];
		count = json['count'];
		goodsName = json['goodsName'];
		isCheck = json['isCheck'];

	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['images'] = this.images;
		data['goodsId'] = this.goodsId;
		data['price'] = this.price;
		data['count'] = this.count;
		data['goodsName'] = this.goodsName;
		data['isCheck'] = this.isCheck;

		return data;
	}
}
