import json
import time
from django.contrib.auth.hashers import make_password
from django.core.mail import send_mail
from django.views.decorators.csrf import csrf_exempt
from django.db import transaction
from django.http import JsonResponse

from general import util
from general.constants import ServerEnum
from models.user import User


def database_commit():
    create_user_table()
    return JsonResponse({
        'STATUS': True,
        'RESPONSE_MESSAGE': "DATABASE COMMIT SUCCESS"})


def create_user_table():
    try:
        sqlQuery = "CREATE TABLE IF NOT EXISTS USER_TABLE (" \
                   "INSERT_BY_USER_ID VARCHAR(250) NOT NULL," \
                   "USER_ID VARCHAR(250) NOT NULL," \
                   "FIRST_NAME VARCHAR(250)," \
                   "LAST_NAME VARCHAR(250)," \
                   "CHILD_DEPENDENT_ID VARCHAR(250)," \
                   "ADDRESS MEDIUMBLOB," \
                   "USER_TYPE ENUM('PARENT','CHILD')," \
                   "CREATED_TIME BIGINT NOT NULL," \
                   "PRIMARY KEY (USER_ID)) " \
                   "Engine = Innodb DEFAULT CHARSET=utf8;"

        cursor = util.getdbconection()
        cursor.execute(sqlQuery)
        return JsonResponse({
            'STATUS': True,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_SUCCESS
        })
    except Exception as e:
        print("ERROR IN create_user_table() method in crud_code/views.py")
        print(e)
        return JsonResponse({
            'STATUS': False,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_DATABASE_CONNECTION_ERROR
        })


@csrf_exempt
def addEditUser(request):
    try:
        requestBody = util.decodeJson(request.body)

        insertByUserId = requestBody['INSERT_BY_USER_ID']
        firstName = requestBody['FIRST_NAME']
        lastName = requestBody['LAST_NAME']
        childDependentId = requestBody['CHILD_DEPENDENT_ID']
        address = requestBody['ADDRESS']
        userType = requestBody['USER_TYPE']
        method = requestBody['METHOD']

        if method == ServerEnum.DATABASE_INSERT:
            userId = util.generateID(userType)
            util.executesql(query="INSERT INTO USER_TABLE "
                                  "(INSERT_BY_USER_ID, USER_ID, FIRST_NAME, LAST_NAME, "
                                  "CHILD_DEPENDENT_ID, ADDRESS, USER_TYPE, CREATED_TIME)"
                                  "VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
                            datatuple=[insertByUserId, userId, firstName, lastName, childDependentId, address, userType,
                                       int(time.time())])

        if method == ServerEnum.DATABASE_UPDATE:
            userId = requestBody['USER_ID']
            util.executesql(query="UPDATE USER_TABLE SET "
                                  "FIRST_NAME = %s,"
                                  "LAST_NAME = %s, "
                                  "CHILD_DEPENDENT_ID = %s,  "
                                  "ADDRESS = %s "
                                  "WHERE USER_ID = %s",
                            datatuple=[firstName, lastName, childDependentId, address, userId])

        return JsonResponse({
            'STATUS': True,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_SUCCESS
        })


    except Exception as e:
        print("ERROR IN addEditUser() method in crud_code/views.py")
        print(e)
        return JsonResponse({
            'STATUS': False,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_DATABASE_CONNECTION_ERROR
        })


@csrf_exempt
def getUserList(request):
    try:
        requestBody = util.decodeJson(request.body)
        insertByUserId = requestBody['INSERT_BY_USER_ID']

        databaseResultUserListData = util.executesql(
            query="SELECT * FROM USER_TABLE WHERE INSERT_BY_USER_ID = %s", datatuple=[insertByUserId])

        userListData = User.toJsonStringListFromDatabase(databaseResultUserListData)
        return JsonResponse({
            'USER_LIST': userListData,
            'STATUS': True,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_SUCCESS
        })

    except Exception as e:
        print("ERROR IN getUserList() method in crud_code/views.py")
        print(e)
        return JsonResponse({
            'STATUS': False,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_DATABASE_CONNECTION_ERROR
        })


@csrf_exempt
def deleteUser(request):
    try:
        requestBody = util.decodeJson(request.body)

        userId = requestBody['USER_ID']

        with transaction.atomic():
            cursor = util.getdbconection()
            cursor.execute("DELETE FROM USER_TABLE WHERE USER_ID =%s", [userId])
            cursor.execute("DELETE FROM USER_TABLE WHERE CHILD_DEPENDENT_ID =%s", [userId])

        return JsonResponse({
            'STATUS': True,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_SUCCESS
        })

    except Exception as e:
        print("ERROR IN deleteUser() method in crud_code/views.py")
        print(e)
        return JsonResponse({
            'STATUS': False,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_DATABASE_CONNECTION_ERROR
        })


@csrf_exempt
def getParenUserList(request):
    try:
        requestBody = util.decodeJson(request.body)
        insertByUserId = requestBody['INSERT_BY_USER_ID']


        databaseResultUserListData = util.executesql(
            query="SELECT * FROM USER_TABLE WHERE INSERT_BY_USER_ID = %s AND USER_TYPE = %s",
            datatuple=[insertByUserId, ServerEnum.USER_PARENT])

        userListData = User.toJsonStringListFromDatabase(databaseResultUserListData)
        return JsonResponse({
            'USER_LIST': userListData,
            'STATUS': True,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_SUCCESS
        })

    except Exception as e:
        print("ERROR IN getParenUserList() method in crud_code/views.py")
        print(e)
        return JsonResponse({
            'STATUS': False,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_DATABASE_CONNECTION_ERROR
        })

@csrf_exempt
def deleteEverything(request):
    try:
        with transaction.atomic():
            cursor = util.getdbconection()
            cursor.execute("DELETE FROM USER_TABLE")

        return JsonResponse({
            'STATUS': True,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_SUCCESS
        })

    except Exception as e:
        print("ERROR IN deleteEverything() method in crud_code/views.py")
        print(e)
        return JsonResponse({
            'STATUS': False,
            'RESPONSE_MESSAGE': ServerEnum.RESPONSE_DATABASE_CONNECTION_ERROR
        })



@csrf_exempt
def server(request):
    return JsonResponse({
        'STATUS': True,
        'RESPONSE_MESSAGE': ServerEnum.RESPONSE_SUCCESS
    })