FROM python:2-alpine
RUN pip install redis flask
ADD app /app
EXPOSE 80
CMD [ "python", "/app/app.py" ]
