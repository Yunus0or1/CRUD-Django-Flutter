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

  Future<Tuple2<void, String>> addEditUser(
      {User user, String addEditMethod}) async {
    int retry = 0;
    while (retry++ < 2) {
      try {
        final String jwtToken = Store.instance.appState.jwtToken;
        final String userUUID = Store.instance.appState.userUUID;

        final String addEditUserRequest = jsonEncode(<String, dynamic>{
          'INSERT_BY_USER_ID': user.insertByUserId,
          'USER_ID': user.userId,
          'FIRST_NAME': user.firstName,
          'LAST_NAME': user.lastName,
          'CHILD_DEPENDENT_ID': user.childDependentId,
          'ADDRESS': user.address.toJsonEncodedString(),
          'USER_TYPE': user.userType,
          'METHOD': addEditMethod,
        });

        final addEditUserResponse = await UserRepo.instance
            .getUserClient()
            .addEditUser(jwtToken, addEditUserRequest);

        if (addEditUserResponse['STATUS'] == true) {
          return Tuple2(null, ClientEnum.RESPONSE_SUCCESS);
        } else {
          return Tuple2(null, addEditUserResponse['RESPONSE_MESSAGE']);
        }
      } catch (err) {
        print("Error in addEditUser() in UserRepo");
        print(err);
      }
    }
    return Tuple2(null, ClientEnum.RESPONSE_CONNECTION_ERROR);
  }

  Future<Tuple2<void, String>> deleteUser({String userId}) async {
    int retry = 0;
    while (retry++ < 2) {
      try {
        final String jwtToken = Store.instance.appState.jwtToken;

        final String deleteUserRequest = jsonEncode(<String, dynamic>{
          'USER_ID': userId,
        });

        final deleteUserResponse = await UserRepo.instance
            .getUserClient()
            .deleteUser(jwtToken, deleteUserRequest);

        if (deleteUserResponse['STATUS'] == true) {
          return Tuple2(null, ClientEnum.RESPONSE_SUCCESS);
        } else {
          return Tuple2(null, deleteUserResponse['RESPONSE_MESSAGE']);
        }

        return Tuple2(null, ClientEnum.RESPONSE_SUCCESS);
      } catch (err) {
        print("Error in addEditUser() in UserRepo");
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
        final String jwtToken = Store.instance.appState.jwtToken;
        final String userId = Store.instance.appState.userUUID;

        final String getUserListFeedDataRequest = jsonEncode(<String, dynamic>{
          'INSERT_BY_USER_ID': userId,
        });

        final feedResponse = await UserRepo.instance
            .getUserClient()
            .getUserListFeed(jwtToken, getUserListFeedDataRequest);

        if (feedResponse['STATUS'] == true) {
          final List<User> allUserList = List<dynamic>.from(json
              .decode(feedResponse['USER_LIST'])
              .map((singleUser) => User.fromJson(singleUser))).cast<User>();

          final userFeedResponse = FeedResponse()
            ..status = true
            ..lastFeed = false
            ..feedItems = allUserList
                .map((singleUser) => FeedItem()
                  ..user = singleUser
                  ..viewCardType = AppEnum.USER_LIST_CARD)
                .toList()
            ..response = ClientEnum.RESPONSE_SUCCESS
            ..error = false;

          return Tuple2(userFeedResponse, ClientEnum.RESPONSE_SUCCESS);
        } else {
          return Tuple2(null, feedResponse['RESPONSE_MESSAGE']);
        }
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
        final String userUUID = Store.instance.appState.userUUID;

        final String getParentListRequest = jsonEncode(<String, dynamic>{
          'INSERT_BY_USER_ID': userUUID,
        });

        final parentListResponse = await UserRepo.instance
            .getUserClient()
            .getParentList(jwtToken, getParentListRequest);

        if (parentListResponse['STATUS'] == true) {
          final List<User> allUserList = List<dynamic>.from(json
              .decode(parentListResponse['USER_LIST'])
              .map((singleUser) => User.fromJson(singleUser))).cast<User>();

          return Tuple2(allUserList, ClientEnum.RESPONSE_SUCCESS);
        } else {
          return Tuple2([], parentListResponse['RESPONSE_MESSAGE']);
        }
      } catch (err) {
        print("Error in getParentList() in UserRepo");
        print(err);
      }
    }
    return Tuple2(null, ClientEnum.RESPONSE_CONNECTION_ERROR);
  }

  Future<Tuple2<FeedResponse, String>> getFeed(FeedRequest feedRequest) async {
    if (feedRequest.feedInfo.feedType == AppEnum.FEED_USER)
      return getUserListFeedData(feedRequest);
    // Dummy Response Send
    else if (feedRequest.feedInfo.feedType == AppEnum.FEED_USER)
      return Tuple2(
          FeedResponse(status: true, feedItems: [
            FeedItem(
                viewCardType: AppEnum.USER_LIST_CARD,
                user: User()
                  ..userId = '1'
                  ..firstName = "Abc"
                  ..lastName = "Xyz"
                  ..userType = AppEnum.USER_TYPE_PARENT
                  ..address = (AddressDetails()
                    ..street = '1/A Harlington'
                    ..city = "New York"
                    ..state = "Ozone"
                    ..zip = '3138Za')),
            FeedItem(
                viewCardType: AppEnum.USER_LIST_CARD,
                user: User()
                  ..userId = '2'
                  ..firstName = "Qwe"
                  ..lastName = "Tyu"
                  ..userType = AppEnum.USER_TYPE_CHILD
                  ..address = null)
          ]),
          ClientEnum.RESPONSE_SUCCESS);

    return null;
  }
}
