from django.db import models

# Create your models here.

class Post(models.Model):

    class Meta:
        db_table = 'posts'

    title = models.CharField(max_length=255)
    description = models.TextField()
