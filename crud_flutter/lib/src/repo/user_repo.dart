import 'package:crud_flutter/src/client/user_client.dart';
import 'package:crud_flutter/src/models/feed/feed_item.dart';
import 'package:crud_flutter/src/models/feed/feed_request.dart';
import 'package:crud_flutter/src/models/feed/feed_response.dart';
import 'package:crud_flutter/src/models/general/App_Enum.dart';
import 'package:crud_flutter/src/models/general/Enum_Data.dart';
import 'package:crud_flutter/src/models/user/user.dart';
import 'package:crud_flutter/src/store/store.dart';

import 'package:tuple/tuple.dart';
import 'dart:convert';

class UserRepo {
  static final UserRepo _instance = UserRepo();
  UserClient _authClient;

  UserClient getAuthClient() {
    if (_authClient == null) _authClient = new UserClient();
    return _authClient;
  }

  static UserRepo get instance => _instance;

  Future<Tuple2<User, String>> signIn(
      {String phoneNumber, String authToken}) async {
    int retry = 0;

    while (retry++ < 2) {
      try {
        String signInRequest = jsonEncode(<String, dynamic>{
          'AUTH_TOKEN': authToken,
          'PHONE_NUMBER': phoneNumber,
          'SIGNIN_TYPE': ClientEnum.SIGNIN_PHONE
        });

        final signInResponse =
            await UserRepo.instance.getAuthClient().signIn(signInRequest);

        if (signInResponse['STATUS'] == true) {
          final user = User.fromJson(json.decode(signInResponse['USER']));

          return Tuple2(user, ClientEnum.RESPONSE_SUCCESS);
        }
        if (signInResponse['STATUS'] == false) {
          return Tuple2(null, signInResponse['RESPONSE_MESSAGE']);
        }
      } catch (err) {
        print("Error in signIn() in AuthRepo");
        print(err);
      }
    }
    return Tuple2(null, ClientEnum.RESPONSE_CONNECTION_ERROR);
  }

  Future<Tuple2<FeedResponse, String>> getUserListFeedData(
      FeedRequest feedRequest) async {
    int retry = 0;
    while (retry++ < 2) {
      try {
        final String jwtToken = Store.instance.appState.user.token;
        final int userId = Store.instance.appState.user.id;

        final feedResponse = await UserRepo.instance
            .getAuthClient()
            .getUserListFeed(jwtToken, userId);

        final List<User> allUserList = List<dynamic>.from(feedResponse
                .map((singleRequestOrder) => User.fromJson(singleRequestOrder)))
            .cast<User>();

        final orderFeedResponse = FeedResponse()
          ..status = true
          ..lastFeed = false
          ..feedItems = allUserList
              .map((singleRequestOrder) => FeedItem()
                ..user = singleRequestOrder
                ..viewCardType = AppEnum.FEED_USER)
              .toList()
          ..response = ClientEnum.RESPONSE_SUCCESS
          ..error = false;

        return Tuple2(orderFeedResponse, ClientEnum.RESPONSE_SUCCESS);
      } catch (err) {
        print("Error in getOrderFeedData() in QueryRepo");
        print(err);
      }
    }
    return Tuple2(null, ClientEnum.RESPONSE_CONNECTION_ERROR);
  }

  Future<Tuple2<FeedResponse, String>> getFeed(FeedRequest feedRequest) async {
    if (feedRequest.feedInfo.feedType == AppEnum.FEED_USER)
      return getUserListFeedData(feedRequest);

    return null;
  }
}
