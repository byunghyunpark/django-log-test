import logging
from rest_framework import permissions
from rest_framework.generics import ListCreateAPIView

from .models import Blog
from .serializers import BlogSerializer

logger_blog = logging.getLogger('django.blog')


class BlogListView(ListCreateAPIView):
    serializer_class = BlogSerializer
    permission_classes = (permissions.AllowAny, )

    def get_queryset(self):
        # logging
        logger_blog.info('access blog list')
        return Blog.objects.all()
