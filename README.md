# NOTAS DE USO

Luego de correr el servidor, puede crear un nuevo usuario dar en el boton "Ingresar", o ingresando a la url http://localhost:3000/users/sign_in

En la url http://localhost:3000/campaign se puede crear una nueva donacion publicamente

En la url http://localhost:3000/donations se pueden gestionar las donaciones

En la url http://localhost:3000/api_tokens se pueden generar los TOKENs para el uso de la api

## Imporante tener instalado REDIS y correr un servidor con el comando 'redis-server' para el uso de la web app

# API EXAMPLES

## Index

### With no date limits
curl -X GET "localhost:3000/api/v1/donations" -H "Authorization: Bearer TOKEN"

### With date limits
curl -X GET "localhost:3000/api/v1/donations?start_date=AAAA-MM-DD&end_date=AAAA-MM-DD" -H "Authorization: Bearer TOKEN"

## Show

curl -X GET "localhost:3000/api/v1/donations/:id" -H "Authorization: Bearer TOKEN"

## Create

curl -X POST "localhost:3000/api/v1/donations" -H 'Content-Type: application/json' -H "Authorization: Bearer TOKEN" -d '{ "donation":{"first_name":"Test", "last_name":"Test", "email":"mail@test.com", "birth_date":"2023-07-03", "phone_number":"123456", "amount":"100000", "card_attributes":{"card_number":"123456789012", "security_code":"123", "expiration_date":"2023-07-28", "card_type":"visa", "document_type":"cc", "document_number":"7654321", "_destroy":"false"}} }'

## Update

curl -X PATCH "localhost:3000/api/v1/donations/:id" -H 'Content-Type: application/json' -H "Authorization: Bearer TOKEN" -d '{ "donation":{"first_name":"Test 2","last_name":"Test 2","email":"mail@test2.com","birth_date":"2023-07-03","phone_number":"12345678","amount":"50000.0","card_attributes":{"id":id,"card_number":"123456789012","security_code":"123","card_type":"mastercard","document_type":"cc","document_number":"9876543","donation_id":id,"expiration_date":"2023-07-21"}} }'

## Destroy

curl -X DELETE http://localhost:3000/api/v1/donations/:id -H "Authorization: Bearer TOKEN"
