*** Settings ***
Documentation        Collab login procedure
Library              SeleniumLibrary
Library              CryptoLibrary    variable_decryption=False    key_path=C:/Users/jsilva04/AppData/Local/Programs/Python/Python312/Lib/site-packages/CryptoLibrary/keys/jsilva@icrc.org/
Resource             DIWP/custom_libraries/customized_keywords.robot
Resource             DIWP/Collab/resources/homepage.robot


*** Variables ***
# user credentials
${user_email}            jsilva@icrc.org
${encrypted_pass}        crypt:Sw3qj6fw9Eu7JZ8C8wOfhONTNgLYYZOjxTLSeUiyGjeY3MTWJnfP9g273yIX1dlYkN1SPA94Ms9Yvecvb9g=
# page elements
${email_input}           //input[@type='email']
${password_input}        //input[@type='password']
${next_element_btn}      //input[@type='submit']
${signin_element_btn}    //input[@type='submit']


*** Keywords ***
Open Collab site
    [Tags]    Ready
    [Arguments]    ${site_url}    ${browser}
    Open Browser    ${site_url}    ${browser}
    Wait Until Element Is Visible    ${email_input}
    Maximize Browser Window

Login with the correct credentials
    [Tags]    Ready
    Wait Until Element Is Visible And Input Text    ${email_input}    ${user_email}
    Wait Until Element Is Visible And Click    ${next_element_btn}
    ${user_pass}=    Get Decrypted Text    ${encrypted_pass}
    Wait Until Element Is Visible And Input Password    ${password_input}    ${user_pass}
    Wait Until Element Is Visible And Click    ${signin_element_btn}
    Wait Until Element Is Visible    ${homepage_side_menu}    15