from rest_framework import serializers
from review.models import Comment


################### REVIEW ###################
class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = ['id', 'title', 'content']
