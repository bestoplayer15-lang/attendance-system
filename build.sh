#!/usr/bin/env bash
# Build script for Render

set -o errexit

pip install -r requirements.txt

python manage.py collectstatic --noinput
python manage.py migrate

# Create admin teacher if it doesn't exist
python manage.py shell -c "
from attendance.models import Teacher
if not Teacher.objects.filter(teacher_id='admin').exists():
    Teacher.objects.create(name='Admin Teacher', teacher_id='admin', pin='admin123456')
    print('Admin teacher created: teacher_id=admin, pin=admin123456')
else:
    print('Admin teacher already exists')

if not Teacher.objects.filter(teacher_id='123456').exists():
    Teacher.objects.create(name='Teacher', teacher_id='123456', pin='232209')
    print('Teacher created: teacher_id=123456, pin=232209')
else:
    print('Teacher 123456 already exists')
"
