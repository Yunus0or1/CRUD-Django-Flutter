import json
from general import util


class User:
    def __init__(self, insertByUserId, userId, firstName, lastName, childDependentId, address, userType,
                 createdTime):
        # These variables will act as Json Name entities
        self.INSERT_BY_USER_ID = insertByUserId
        self.USER_ID = userId
        self.FIRST_NAME = firstName
        self.LAST_NAME = lastName
        self.CHILD_DEPENDENT_ID = childDependentId
        self.ADDRESS = address
        self.USER_TYPE = userType
        self.CREATED_TIME = createdTime

    @staticmethod
    def toJsonStringListFromDatabase(databaseResult):
        userList = []
        for i in range(0, len(databaseResult)):
            insertByUserId = databaseResult[i][0]
            userId = databaseResult[i][1]
            firstName = databaseResult[i][2]
            lastName = databaseResult[i][3]
            childDependentId = databaseResult[i][4]
            address = util.getStringFromBinaryDecode(databaseResult[i][5])
            userType = databaseResult[i][6]
            createdTime = databaseResult[i][7]

            userList.append(User(insertByUserId, userId, firstName, lastName, childDependentId, address, userType,
                                 createdTime).__dict__)
        return json.dumps(userList)
