*** Settings ***
Library    OperatingSystem
Library    RequestsLibrary
Resource   ../resources/fakestoreapi.resource


*** Test Cases ***
Verify Get All Products
    ${reponse}  When I send a request get to /products   
    Then the response status code should be   200   ${reponse}
    Then response body should contains data   ${reponse}

Verify Get Product By Id
    ${reponse}  When I send a request to get /products/id  1 
    Then the response status code should be   200   ${reponse}
    Then response body should contains product data   ${reponse} 

Verify Add Product
    ${reponse}  When I send a request post to /products 
    Then the response status code should be   200   ${reponse}
    Then response body should contains new product data   ${reponse}  

Verify Delete Product
    ${reponse}  When I send a request delete to /products/id  21 
    Then the response status code should be   200   ${reponse}
    Then response body should be null  ${reponse}              