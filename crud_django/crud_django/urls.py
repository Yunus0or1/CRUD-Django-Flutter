from django.urls import path
from django.conf import settings
from django.conf.urls import url, include
from crud_code import views as user_views

urlpatterns = [
    url(r'^add_edit_user/', user_views.addEditUser, name="add_edit_user"),
    url(r'^get_user_list/', user_views.getUserList, name="get_user_list"),
    url(r'^delete_user/', user_views.deleteUser, name="delete_user"),
    url(r'^get_parent_user_list/', user_views.getParenUserList, name="get_parent_user_list"),
]

# First execution of Database commit. With Printing the response
print(user_views.database_commit())