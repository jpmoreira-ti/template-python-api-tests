*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary   
Resource   ../services/fakestoreapi_service.resource

*** Keywords ***
When I send a request get to /products
    ${response}   When I send a GET request to /products
    RETURN      ${response}

When I send a request to get /products/id
    [Arguments]    ${id}
    ${response}   When I send a GET request to /products/id   ${id}  
    RETURN      ${response}    

When I send a request post to /products
    ${response}   When I send a POST request to /products   
    RETURN      ${response}

When I send a request delete to /products/id
    [Arguments]    ${id}
    ${response}   When I send a DELETE request to /products/id  ${id}
    RETURN      ${response}        

Then the response status code should be 
    [Arguments]    ${status_code}   ${response}
    Status Should Be    ${status_code}     ${response}

Then response body should contains data
    [Arguments]    ${response}
    Should Not Be Empty    ${response.content}

Then response body should be null
    [Arguments]    ${response}
    ${response_content}    Convert To String    ${response.content}
    Should Be Equal    ${response_content}    null    

Then response body should contains product data
    [Arguments]    ${response}
    ${response_data}    Convert String To Json    ${response.content}
    Should Be Equal As Numbers    ${response_data['id']}    1
    Should Be Equal    ${response_data['title']}    Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops
    Should Be Equal As Numbers    ${response_data['price']}    109.95
    Should Be Equal    ${response_data['description']}    Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday
    Should Be Equal    ${response_data['category']}    men's clothing
    Should Be Equal    ${response_data['image']}    https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg
    Should Be Equal As Numbers    ${response_data['rating']['rate']}    3.9
    Should Be Equal As Numbers    ${response_data['rating']['count']}    120

Then response body should contains new product data
    [Arguments]    ${response}
    ${response_data}    Convert String To Json    ${response.content}
    Should Be Equal As Numbers    ${response_data['id']}    21
    Should Be Equal    ${response_data['title']}    new product
    Should Be Equal As Numbers    ${response_data['price']}    33.0
    Should Be Equal    ${response_data['description']}    new description here
    Should Be Equal    ${response_data['category']}    gadgets
    Should Be Equal    ${response_data['image']}    https://i.pravatar.cc/300
        