#!/usr/bin/env bash
# Build script for Render

set -o errexit

pip install -r requirements.txt

python manage.py collectstatic --noinput
python manage.py migrate

# Create superuser if it doesn't exist
python manage.py shell -c "
from django.contrib.auth.models import User
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@school.com', 'admin123456')
    print('Superuser created: admin / admin123456')
else:
    print('Superuser already exists')
"
