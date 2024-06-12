*** Settings ***
Documentation        DW login resources and procedure
Library              SeleniumLibrary
Library              CryptoLibrary    variable_decryption=False    key_path=C:/Users/jsilva04/AppData/Local/Programs/Python/Python312/Lib/site-packages/CryptoLibrary/keys/collab/
Resource             ../resources/sharepoint.robot
Resource             ../custom_libraries/customized_keywords.robot


*** Variables ***
#Access to Ivan tenant
${browser}                Chrome
${gva_url}                https://icrc.sharepoint.com/_layouts/15/sharepoint.aspx?&login_hint=jsilva@icrc.org
${gva_user_email}         jsilva@icrc.org
${gva_tenant_enc_pass}    crypt:8PJbON6hXYRCltgRg3OqcbqorXrzbOfOqECEkWctH0kgjQUvZGzkn5qW450u6CHK6/bXwxLV7ArI9vhb4C0=
#Login elements
${email_input}            //input[@type='email']
${next_btn}               //input[@type='submit']
${password_input}         //input[@name='passwd']
${submit_btn}             //input[@type='submit']


*** Keywords ***
Open SPO site
    [Tags]    READY
    [Arguments]    ${spo_url}
    Open Browser    ${spo_url}    ${browser}
    Maximize Browser Window

Login with the correct credentials
    [Tags]    READY
    [Arguments]    ${user_email}    ${encrypted_pass}
    ${user_pass}=    Get Decrypted Text    ${encrypted_pass}
    Wait Until Element Is Visible And Input Password    ${password_input}    ${user_pass}
    Wait Until Element Is Visible And Click    ${submit_btn}
    Log    Login: OK    WARN
    Wait Until Element Is Visible    ${app_laucher}    20