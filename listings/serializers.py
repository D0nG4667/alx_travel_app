from rest_framework import serializers
from .models import Listing


class ListingSerializer(serializers.ModelSerializer):
    host_username = serializers.CharField(source='host.username', read_only=True)

    class Meta:
        model = Listing
        fields = [
            'id',
            'host',
            'host_username',
            'title',
            'description',
            'location',
            'price_per_night',
            'created_at',
            'updated_at',
        ]
        read_only_fields = ['id', 'host_username', 'created_at', 'updated_at']
