# without staging


#FROM python:3.10
#WORKDIR /app-first
#COPY requirements.txt .
#RUN pip install -r requirements.txt
#COPY . .
#EXPOSE 8000
#CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]



# with Staging


FROM python:3.10 AS build

WORKDIR /pyapp

COPY requirements.txt req.txt

RUN pip install -r req.txt

FROM python:3.10-slim

WORKDIR /pyapp

COPY requirements.txt req.txt

RUN pip install -r req.txt

COPY --from=build /pyapp /pyapp

COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]




