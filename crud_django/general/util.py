import json
import random
from datetime import datetime, timezone, timedelta
import time
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from django.db import connection
from django.core.mail import send_mail, EmailMessage
import jwt
from django.conf import settings
from pyfcm import FCMNotification
import uuid


def getClientIp(request):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return str(ip)


def encodeToJWTAdmin(userDatabaseResult):
    jwtToken = jwt.encode(
        {'USER_ID': userDatabaseResult[0][0],
         'USER_EMAIL': userDatabaseResult[0][1],
         'USER_TYPE': userDatabaseResult[0][9],
         'CREATED_TIME': int(time.time())
         }, settings.SECRET_KEY, algorithm=settings.JWT_ALGORITHM)

    return jwtToken



def decodeJson(requestBody):
    bodyUnicode = requestBody.decode('utf-8')
    body = json.loads(bodyUnicode)
    return body


def naValue(data):
    if data:
        return data
    return "N/A"


def getStringFromBinaryDecode(VALUE):
    if VALUE is not None:
        return VALUE.decode()
    else:
        return None


def varifyJWT(jwtToken):
    try:
        verify = jwt.decode(jwtToken, settings.SECRET_KEY, settings.JWT_ALGORITHM)
        return verify
    except Exception as e:
        print(e)
        return False


def generateID(prefix):
    uuID = prefix + "_" + str(uuid.uuid4())
    randomUUID = uuID.replace('-', '_')
    return randomUUID


def generateSecurityPin():
    number = random.randint(100000, 999999)
    return number


def executesql(query, datatuple):
    cursor = getdbconection()
    cursor.execute(query, datatuple)
    databaseResult = cursor.fetchall()
    cursor.close()
    return databaseResult


def getdbconection():
    return connection.cursor()


def getshortId(bigId):
    if bigId == None:
        return "N/A"
    return bigId.split("_")[1].upper()


