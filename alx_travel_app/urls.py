from django.urls import path
from rest_framework import routers
from .views import ListingViewSet
from django.urls import include, path

# Register view sets
router = routers.DefaultRouter()
router.register(r'listings', ListingViewSet, basename='listing')


urlpatterns = [
    path('', include(router.urls)),
]
