*** Settings ***
Documentation        Outlook resources
Library              SeleniumLibrary
Library              String
Library              Dialogs
Resource             DW/custom_libraries/customized_keywords.robot


*** Variables ***
${outlook_url}               https://mail.ext.icrc.org/owa/?bO=1#path=/mail/inbox
${email_expected_title}      Storing Strictly confidential information in M365
${email_expected_body}       You have classified your information as Strictly Confidential in Microsoft 365 services, which is a cloud solution.
...                          If your document contains beneficiary data, please move it to an appropriate solution.
...                          Read more information
#Page elements
${inbox_nav_element}         //span[@title='Caixa de Entrada']
${office365_email_title}    //span[@autoid='_lvv_5' and contains(text(),'Office365 Doc')]
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
    #Generate a list of expected docs names
    @{created_docs_names}    Create List
    WHILE    ${num_docs} > 0
        ${text}=    Catenate    ${template_file_name}_${num_docs}
        Append To List    ${created_docs_names}    ${text}
        ${num_docs}=    Evaluate    ${num_docs} -1
    END
    Sort List    ${created_docs_names}
    #Convert expected docs names is expected emails titles
    @{expected_emails_titles}    Create List
    FOR    ${element}    IN    @{created_docs_names}
        ${text}=    Catenate    ${email_expected_title} ${element}
        Append To List    ${expected_emails_titles}    ${text}
    END
    #Emails verifications
    Log    Verify if at least one email is present
    ${element_is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${office365_emails_desc}
    Log    Verification of emails titles and bodies
    IF    ${element_is_visible}
#        Wait Until Element Is Visible And Click    ${office365_emails_desc}
        #Retrieve list of emails titles
        Wait Until Element Is Visible    ${office365_emails_desc}
        @{descriptions_list}    Get Webelements    ${office365_emails_desc}
        @{present_docs_titles}    Create List
        FOR    ${element}    IN    @{descriptions_list}
            Append To List    ${present_docs_titles}    ${element.text}
        END
        Sort List    ${present_docs_titles}
        #Compare the expected and actual emails titles and number of emails
        Log    Compare the expected and actual emails titles and number of emails
        Lists Should Be Equal    ${present_docs_titles}    ${expected_emails_titles}
        Log    Emails titles: CORRECT
        Log    Number of emails: CORRECT
        #Verification of the email body
        Log    Verification of the emails bodies
        FOR    ${elements}    IN    @{present_docs_titles}
            Wait Until Element Is Visible And Click    //span[@autoid='_lvv_6' and contains(text(),'${elements}')]
            Wait Until Element Is Visible    ${email_actual_body}
            Capture Page Screenshot
            ${email_body}    Get Webelement    ${email_actual_body}
            Log    ${email_body.text}
            ${email_body_text}    Set Variable    ${email_body.text}
            ${email_body_text}=    Replace String    ${email_body_text}    \n    ${SPACE}
            Log    Actual email body: ${email_body_text}
            Should Be Equal As Strings    ${email_body_text}    ${email_expected_body}
            Log    Emails bodies: CORRECT
        END
    ELSE
        Fail
    END