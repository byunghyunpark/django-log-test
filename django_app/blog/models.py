from django.db import models


class Blog(models.Model):
    title = models.CharField(max_length=20)
    content = models.TextField()
