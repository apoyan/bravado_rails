# Bravado backend test

----

You are suggested to implement a simple dockerized application that consists of two parts:

1. Rails CRUD to manage companies
2. Companies autocomplete (not necessary to use Rails, the faster the better)

----
## Requirements
1. Rails CRUD should use the latest stable Rails
2. The whole stack should be running with `docker-compose up` or `docker run ...` (1 command)
3. Rails application should be available on port 3000 (basic auth is enough)
4. Autocomplete application should be available on port 3001
5. Initial autocomplete data should be taken from [this snapshot](http://download.companieshouse.gov.uk/en_output.html)
6. Autocomplete should have simple http GET interface similar to [bravado autocomplete](https://bravado.co/autocomplete?term=goog&kind=crunchbase_company_final)
7. Autocomplete results should be **available immediately** after the container run
8. Companies database **should be updated on a background** from the snapshot every hour
9. Any changes made with CRUD should be available in the autocomplete immediately 


----
## The task highlights

1. Autocomplete response time is important
2. Also important: Ruby code quality, Docker config, gems used, overall solution simplicity, system requirements
3. Database choice is not important
4. Autocomplete UI is not a strict requirement, but a simple solution built with `webpacker` would be your advantage
