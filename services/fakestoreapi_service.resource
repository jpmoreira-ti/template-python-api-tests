*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://fakestoreapi.com
${CURRENT_PATH}    ${CURDIR}/../payloads

*** Keywords ***
Create fakestore session
    Create Session    
    ...    alias=fakestore    
    ...    url=${BASE_URL}       
    ...    disable_warnings=True

When I send a GET request to /products
    Create fakestore session

    ${response}    GET On Session
    ...            alias=fakestore    
    ...            url=/products
    ...            expected_status=any

    [Return]    ${response}  

When I send a GET request to /products/id
    [Arguments]  ${id}
    Create fakestore session

    ${response}    GET On Session
    ...            alias=fakestore    
    ...            url=/products/${id}
    ...            expected_status=any

    [Return]    ${response}

When I send a POST request to /products
    Create fakestore session

    ${body}    Load Json From File   ${CURRENT_PATH}/add_product.json
    Set To Dictionary    ${body}    price    33.0

    ${response}    POST On Session
    ...            alias=fakestore    
    ...            url=/products
    ...            expected_status=any
    ...            json=${body}   

    [Return]    ${response}            

When I send a DELETE request to /products/id
    [Arguments]  ${id}
    Create fakestore session

    ${response}    Delete On Session
    ...            alias=fakestore    
    ...            url=/products/${id}
    ...            expected_status=any

    [Return]    ${response}
