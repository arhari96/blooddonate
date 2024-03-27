import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import 'status.dart';

class DataResponse<T> {
  String? status = Status.none.name;
  T? data;
  dynamic message;

  DataResponse({this.status = "", this.data, this.message});

  factory DataResponse.success({T? data, dynamic message}) {
    return DataResponse(
      status: Status.success.name,
      data: data,
      message: message is List ? message.join("\n") : message,
    );
  }

  factory DataResponse.failure({T? data, dynamic message}) {
    return DataResponse(
      status: Status.failure.name,
      data: data,
      message: message is List ? message.join("\n") : message,
    );
  }

  factory DataResponse.fromHttpResponse(
      HttpResponse<DataResponse<T>> httpResponse) {
    return DataResponse(
      status: httpResponse.data.status,
      data: httpResponse.data.data,
      message: httpResponse.data.message is List
          ? (httpResponse.data.message as List).join("\n")
          : httpResponse.data.message,
    );
  }

  factory DataResponse.fromDioException(DioException dioException) {
    return DataResponse(
      status: Status.failure.name,
      data: dioException.response?.data?['data'],
      message: dioException.response == null
          ? dioException.message
          : dioException.response!.data['message'] is List
              ? (dioException.response!.data['message'] as List).join("\n")
              : dioException.response!.data['message'],
    );
  }
}
