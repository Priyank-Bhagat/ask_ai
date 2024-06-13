class EdanAiModel {
  Openai? openai;
  Openai? cohere;

  EdanAiModel({this.openai, this.cohere});

  EdanAiModel.fromJson(Map<String, dynamic> json) {
    openai =
        json['openai'] != null ? new Openai.fromJson(json['openai']) : null;
    cohere =
        json['cohere'] != null ? new Openai.fromJson(json['cohere']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.openai != null) {
      data['openai'] = this.openai!.toJson();
    }
    if (this.cohere != null) {
      data['cohere'] = this.cohere!.toJson();
    }
    return data;
  }
}

class Openai {
  String? status;
  String? generatedText;
  double? cost;

  Openai({this.status, this.generatedText, this.cost});

  Openai.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    generatedText = json['generated_text'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['generated_text'] = this.generatedText;
    data['cost'] = this.cost;
    return data;
  }
}
