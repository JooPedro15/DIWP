*** Settings ***
Documentation        Outlook resources
Library              SeleniumLibrary
Library              String
Library              Dialogs
Resource             Colla/custom_libraries/customized_keywords.robot


*** Variables ***
${outlook_url}               https://mail.ext.icrc.org/owa/?bO=1#path=/mail/inbox
${email_expected_title}      Storing Strictly confidential information in M365
${email_expected_body}       You stored some strictly confidential information in M365 (OneDrive or SharePoint Online).
...                          If you want to collaborate with external partners (use partners.ext.icrc.org or iTransfer).
...                          If it contains sensitive data with beneficiary data, please store it in specially designed systems.
...                          For more information, please read this article: IHT Details
#Page elements
${inbox_nav_element}         //span[@title='Caixa de Entrada']
${office365_emails_title}    //span[@autoid='_lvv_5' and contains(text(),'Office365 Doc')]
${office365_emails_desc}     //span[@autoid='_lvv_6' and contains(text(),'Storing Strictly confidential information in M365')]
${email_actual_title}        //span[@role='heading']
${email_actual_body}         //div[@id='Item.MessagePartBody']


*** Keywords ***
Access Outlook
    [Tags]    READY
    Go To    ${outlook_url}
    Wait Until Element Is Visible And Click    ${inbox_nav_element}

Verify the Sensitivity Label email notification
    [Tags]    READY
    [Arguments]    ${template_file_name}    ${num_docs}
    #generate a list of expected docs names
    @{created_docs_names}    Create List
    WHILE    ${num_docs} > 0
        ${text}=    Catenate    ${template_file_name}${num_docs}
        Append To List    ${created_docs_names}    ${text}
        ${num_docs}=    Evaluate    ${num_docs} -1
    END
    Sort List    ${created_docs_names}
    Log    Expected docs names: ${created_docs_names}    WARN
    #convert expected docs names is expected emails titles
    @{expected_emails_titles}    Create List
    FOR    ${element}    IN    @{created_docs_names}
        ${text}=    Catenate    ${email_expected_title} ${element}
        Append To List    ${expected_emails_titles}    ${text}
    END
    Log    Expected emails titles: ${expected_emails_titles}    WARN
    #verify if the email is present
    ${element_is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${office365_emails_desc}
    IF    ${element_is_visible}
        Log    Notification found    WARN
        Wait Until Element Is Visible And Click    ${office365_emails_desc}
        #retrieve list of emails titles
        Wait Until Element Is Visible    ${office365_emails_desc}
        @{descriptions_list}    Get Webelements    ${office365_emails_desc}
        @{present_docs_titles}    Create List
        FOR    ${element}    IN    @{descriptions_list}
            Append To List    ${present_docs_titles}    ${element.text}
        END
        Sort List    ${present_docs_titles}
        Log    Present emails title: ${present_docs_titles}    WARN
        #compare the expected and actual emails titles and number of emails
        Lists Should Be Equal    ${present_docs_titles}    ${expected_emails_titles}
        Log    Number of received emails: OK    WARN
        #Verification of the email body
        Wait Until Element Is Visible    ${email_actual_body}
        ${email_body}    Get Webelement    ${email_actual_body}
        ${email_body_text}    Set Variable    ${email_body.text}
        ${email_body_text}=    Replace String    ${email_body_text}    \n    ${SPACE}
        Log    Expected email body: ${email_expected_body}    WARN
        Log    Actual email body: ${email_body_text}    WARN
        Should Be Equal As Strings    ${email_body_text}    ${email_expected_body}
        Log    Email body: OK    WARN
    ELSE
        Log    Notification not found    WARN
        Fail
    END
    
    
testing
    [Arguments]    ${num_iter}
    ${my_var}    Set Variable    True
    Log    ${my_var}    WARN
    ${my_var}    Set Variable    False
    Log    ${my_var}    WARN
    ${reload_time}    Set Variable    10
    ${my_var}    Run Keyword And Return Status    Element Should Be Visible    ${office365_emails_desc}
    Log    start: ${my_var}    WARN

    IF    ${my_var}
        Log    Notification found at first try    WARN
    ELSE
        WHILE    ${num_iter} <=5
            ${my_var}    Run Keyword And Return Status    Element Should Be Visible    ${office365_emails_desc}
            Log    ${my_var}    WARN
            IF    ${my_var}
                
                Log    Notification found elsewhere    WARN
                BREAK

            ELSE
                Log    ${num_iter}    WARN
                #${element_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${office365_emails_title}

                
                Reload Page
                Sleep    5

                ${counter}=    Evaluate    ${num_iter} -1
            END
        END
        Log    Notification not found    WARN
        Fail
    END