import 'package:crud_flutter/src/client/user_client.dart';
import 'package:crud_flutter/src/models/feed/feed_item.dart';
import 'package:crud_flutter/src/models/feed/feed_request.dart';
import 'package:crud_flutter/src/models/feed/feed_response.dart';
import 'package:crud_flutter/src/models/general/App_Enum.dart';
import 'package:crud_flutter/src/models/general/Enum_Data.dart';
import 'package:crud_flutter/src/models/user/address_details.dart';
import 'package:crud_flutter/src/models/user/user.dart';
import 'package:crud_flutter/src/store/store.dart';

import 'package:tuple/tuple.dart';
import 'dart:convert';

class UserRepo {
  static final UserRepo _instance = UserRepo();
  UserClient _userClient;

  UserClient getUserClient() {
    if (_userClient == null) _userClient = new UserClient();
    return _userClient;
  }

  static UserRepo get instance => _instance;

  Future<Tuple2<FeedResponse, String>> getUserListFeedData(
      FeedRequest feedRequest) async {
    int retry = 0;
    while (retry++ < 2) {
      try {
        final String jwtToken = Store.instance.appState.jwtToken;
        final String userId = Store.instance.appState.userUUID;

        final feedResponse = await UserRepo.instance
            .getUserClient()
            .getUserListFeed(jwtToken, userId);

        final List<User> allUserList = List<dynamic>.from(
                feedResponse.map((singleUser) => User.fromJson(singleUser)))
            .cast<User>();

        final userFeedResponse = FeedResponse()
          ..status = true
          ..lastFeed = false
          ..feedItems = allUserList
              .map((singleUser) => FeedItem()
                ..user = singleUser
                ..viewCardType = AppEnum.FEED_USER)
              .toList()
          ..response = ClientEnum.RESPONSE_SUCCESS
          ..error = false;

        return Tuple2(userFeedResponse, ClientEnum.RESPONSE_SUCCESS);
      } catch (err) {
        print("Error in getUserListFeedData() in UserRepo");
        print(err);
      }
    }
    return Tuple2(null, ClientEnum.RESPONSE_CONNECTION_ERROR);
  }

  Future<Tuple2<List<User>, String>> getParentList() async {
    int retry = 0;
    while (retry++ < 2) {
      try {
        final String jwtToken = Store.instance.appState.jwtToken;
        final String userId = Store.instance.appState.userUUID;

        final parentListResponse = await UserRepo.instance
            .getUserClient()
            .getParentList(jwtToken, userId);

        final List<User> allUserList = List<dynamic>.from(parentListResponse
            .map((singleUser) => User.fromJson(singleUser))).cast<User>();

        return Tuple2(allUserList, ClientEnum.RESPONSE_SUCCESS);
      } catch (err) {
        print("Error in getParentList() in UserRepo");
        print(err);
      }
    }
    return Tuple2(null, ClientEnum.RESPONSE_CONNECTION_ERROR);
  }

  Future<Tuple2<FeedResponse, String>> getFeed(FeedRequest feedRequest) async {
    if (feedRequest.feedInfo.feedType == AppEnum.FEED_USER)
      return Tuple2(
          FeedResponse(status: true, feedItems: [
            FeedItem(
                viewCardType: AppEnum.USER_LIST_CARD,
                user: User()
                  ..id = '1'
                  ..firstName = "Abc"
                  ..lastName = "Xyz"
                  ..userType = AppEnum.USER_TYPE_PARENT
                  ..addressDetails = (AddressDetails()
                    ..street = '1/A Harlington'
                    ..city = "New York"
                    ..state = "Ozone"
                    ..zip = '3138Za')),
            FeedItem(
                viewCardType: AppEnum.USER_LIST_CARD,
                user: User()
                  ..id = '2'
                  ..firstName = "Qwe"
                  ..lastName = "Tyu"
                  ..userType = AppEnum.USER_TYPE_CHILD
                  ..addressDetails = null)
          ]),
          ClientEnum.RESPONSE_SUCCESS);
    if (feedRequest.feedInfo.feedType == AppEnum.FEED_USER)
      return getUserListFeedData(feedRequest);

    return null;
  }
}
