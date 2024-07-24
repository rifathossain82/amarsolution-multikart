import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/env/env.dart';
import 'package:amarsolution_multikart/src/core/errors/messages.dart';
import 'package:amarsolution_multikart/src/core/helpers/helper_methods.dart';
import 'package:amarsolution_multikart/src/core/routes/routes.dart';
import 'package:amarsolution_multikart/src/core/services/connectivity_services.dart';
import 'package:amarsolution_multikart/src/core/services/local_storage.dart';

class Network {
  static String? get _token => LocalStorage.getData(key: LocalStorageKey.token);

  static String? get _publicKey => Env.publicKey;

  static String? get _privateKey => Env.privateKey;

  static Map<String, String> _getRequestHeader({
    bool addContentType = false,
    bool isPrivateRequest = false,
  }) {
    return {
      'Accept': 'application/json',
      if (addContentType) 'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
      if (isPrivateRequest)
        'AmsPrivateKey': '$_privateKey'
      else
        'AmsPublickey': '$_publicKey',
      'lang': 'en',
    };
  }

  static Future<http.Response> getRequest({
    required String api,
    params,
    bool isPrivateRequest = false,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint("\nYou hit: $api");
    kPrint("Request Params: $params");

    http.Response response = await http.get(
      Uri.parse(api).replace(queryParameters: params),
      headers: _getRequestHeader(isPrivateRequest: isPrivateRequest),
    );

    return response;
  }

  static Future<http.Response> postRequest({
    required String api,
    body,
    bool addContentType = false,
    bool isPrivateRequest = false,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    http.Response response = await http.post(
      Uri.parse(api),
      body: body,
      headers: _getRequestHeader(
        addContentType: addContentType,
        isPrivateRequest: isPrivateRequest,
      ),
    );

    return response;
  }

  static Future<http.Response> putRequest({
    required String api,
    body,
    bool addContentType = false,
    bool isPrivateRequest = false,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    http.Response response = await http.put(
      Uri.parse(api),
      body: body,
      headers: _getRequestHeader(
        addContentType: addContentType,
        isPrivateRequest: isPrivateRequest,
      ),
    );

    return response;
  }

  static Future<http.Response> deleteRequest({
    required String api,
    body,
    bool isPrivateRequest = false,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    http.Response response = await http.delete(
      Uri.parse(api),
      body: body,
      headers: _getRequestHeader(isPrivateRequest: isPrivateRequest),
    );

    return response;
  }

  static multipartAddRequest({
    required String api,
    required Map<String, String> body,
    required List<String> fileKeyNames,
    required List<String> filePaths,
    bool isPrivateRequest = false,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint("\nYou hit: $api");
    kPrint("Request body: $body");

    var request = http.MultipartRequest('POST', Uri.parse(api))
      ..fields.addAll(body)
      ..headers.addAll(_getRequestHeader(isPrivateRequest: isPrivateRequest));

    for (var i = 0; i < fileKeyNames.length; i++) {
      if (filePaths[i].isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(fileKeyNames[i], filePaths[i]),
        );
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  static handleResponse(http.Response response) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        kPrint('SuccessCode: ${response.statusCode}');
        kPrint('SuccessResponse: ${response.body}');

        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return response.body;
        }
      } else if (response.statusCode == 401) {
        _logout();
        String msg = Message.error401;
        if (response.body.isNotEmpty) {
          if (json.decode(response.body)['errors'] != null) {
            msg = json.decode(response.body)['errors'];
          }
        }
        throw msg;
      } else if (response.statusCode == 404) {
        throw Message.error404;
      } else if (response.statusCode == 500) {
        throw Message.error500;
      } else {
        kPrint('ErrorCode: ${response.statusCode}');
        kPrint('ErrorResponse: ${response.body}');

        String msg = Message.unknown;
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body)['errors'];
          if (data == null) {
            msg = jsonDecode(response.body)['message'] ?? msg;
          } else if (data is String) {
            msg = data;
          } else if (data is Map) {
            msg = data['email'][0];
          }
        }

        throw msg;
      }
    } on SocketException catch (_) {
      throw Message.noInternet;
    } on FormatException catch (_) {
      throw Message.badResponse;
    } catch (e) {
      throw e.toString();
    }
  }

  static void _logout() {
    LocalStorage.removeData(key: LocalStorageKey.token);

    /// To navigate login page
    Get.offAllNamed(RouteGenerator.login);
  }
}
