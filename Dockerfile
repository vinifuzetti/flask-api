FROM python:3
ADD app.py /
RUN pip install flask
CMD [ "python", "./app.py" ]