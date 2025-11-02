from django.shortcuts import render
from rest_framework import viewsets, permissions
from .models import Listing
from .serializers import ListingSerializer


class IsHostOrReadOnly(permissions.BasePermission):
    """Allow modifications only to the host (owner)."""

    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
        return obj.host == request.user


class ListingViewSet(viewsets.ModelViewSet):
    queryset = Listing.objects.select_related('host').all()
    serializer_class = ListingSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly, IsHostOrReadOnly]

    def perform_create(self, serializer):
        # set host to current user
        serializer.save(host=self.request.user)
