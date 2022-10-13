// To parse this JSON data, do
//
//     final dbData = dbDataFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';
  part 'data_model.g.dart';

DbData dbDataFromJson(String str) => DbData.fromJson(json.decode(str));

String dbDataToJson(DbData data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class DbData {
    DbData({
        this.totalRows,
        this.offset,
        this.rows,
    });
    
    @HiveField(0)
    int? totalRows;
    @HiveField(1)
    int? offset;
    @HiveField(2)
    List<Row>? rows;

    factory DbData.fromJson(Map<String, dynamic> json) => DbData(
        totalRows: json["total_rows"],
        offset: json["offset"],
        rows: List<Row>.from(json["rows"].map((x) => Row.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_rows": totalRows,
        "offset": offset,
        "rows": List<dynamic>.from(rows!.map((x) => x.toJson())),
    };

     
}

class Row {
    Row({
        this.id,
        this.key,
        this.value,
        this.doc,
    });
    String? id;
    String? key;
    Value? value;
    Doc? doc;

    factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json["id"],
        key: json["key"],
        value: Value.fromJson(json["value"]),
        doc: Doc.fromJson(json["doc"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value!.toJson(),
        "doc": doc!.toJson(),
    };
}

class Doc {
    Doc({
        this.id,
        this.rev,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.country,
    });

    String? id;
    String? rev;
    String? name;
    String? email;
    int? phone;
    Address? address;
    String? country;

    factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        rev: json["_rev"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"] ?? 98611,
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        country: json["country"] ?? 'Nepal',
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "_rev": rev,
        "name": name,
        "email": email,
        "phone": phone ,
        "address": address == null ? null : address!.toJson(),
        "country": country ,
    };
}

class Address {
    Address({
        this.country,
        this.zone,
        this.city,
    });

    String? country;
    String? zone;
    String? city;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"],
        zone: json["zone"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "zone": zone,
        "city": city,
    };
}

class Value {
    Value({
        this.name,
        this.email,
    });

    String? name;
    String? email;

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
    };

   
}
