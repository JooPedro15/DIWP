*** Settings ***
Documentation        Collab login resources and procedure
Library              SeleniumLibrary
Library              CryptoLibrary    variable_decryption=False    key_path=C:/Users/jsilva04/AppData/Local/Programs/Python/Python312/Lib/site-packages/CryptoLibrary/keys/jsilva.testnms_enc/
Resource             ../resources/sharepoint.robot
Resource             DW/custom_libraries/customized_keywords.robot


*** Variables ***
${browser}    Chrome
${tenant_url}    https://icrcspace.sharepoint.com/teams/Team_Requests
${user_email}    jsilva@testnms.icrc.org
${enc_pass}      crypt:QBPwiV8iMOk6sVtI19rDrweWLcgHjfwJjll9zd1xS2sLqni+GSU3wKyDtexz6Vimcwt7kfXO89apJ7yCbk4=

${email_input}       //input[@type='email']
${next_btn}          //input[@type='submit']
${password_input}    //input[@name='passwd']
${submit_btn}        //input[@type='submit']


*** Keywords ***
Open SPO site
    [Tags]    READY
    [Arguments]    ${spo_url}
    Open Browser    ${spo_url}    ${browser}
    Wait Until Element Is Visible    ${email_input}
    Maximize Browser Window

Login with the correct credentials
    [Tags]    READY
    [Arguments]    ${user_email}    ${encrypted_pass}
    Wait until element is visible And Input Text    ${email_input}    ${user_email}
    Wait Until Button Is Visible And Click    ${next_btn}
    ${user_pass}=    Get Decrypted Text    ${encrypted_pass}
    Wait Until Element Is Visible And Input Password    ${password_input}    ${user_pass}
    Wait Until Element Is Visible And Click    ${submit_btn}
    ${stay_signedin}    Run Keyword And Return Status    Wait Until Element Is Visible    ${submit_btn}    5
    IF    ${stay_signedin}
        Wait Until Element Is Visible And Click    ${submit_btn}
    END
    Wait Until Element Is Visible    ${site_header}     15