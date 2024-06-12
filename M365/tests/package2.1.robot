*** Settings ***
Documentation    Package 2.1
Library          SeleniumLibrary
Library          DataDriver    file=../resources/package2.1_data.csv    encoding=utf_8    dialect=excel
Resource         DW/custom_libraries/customized_keywords.robot
Resource         ../resources/login_dev.robot
Resource         ../resources/sharepoint.robot
Resource         ../resources/teams.robot
Test Setup       Open SPO Site    ${tenant_url}
Test Template    Create And Approve A New Request
Test Teardown    Close Browser


*** Test Cases ***
Test Case 473511: Provision a new Teams Group: ${teams_group_name}
    [Documentation]    *Objective:* Request and approve a new Teams Group in multiple iterations
    ...                *Test Case URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=412018&suiteId=473508
    ...                *Prerequisites:* Define iteration to be executed in append package2.1_data.csv file


*** Keywords ***
Create and approve a new request
    [Tags]    READY
    [Arguments]    ${teams_group_name}    ${sensitivity_label}    ${sensitivity_label_no}    ${space_type}    ${space_type_no}    ${justification}
    #Login to SPO and access Teams Request page
    Login With The Correct Credentials    ${user_email}    ${enc_pass}
    Wait Until Element Is Visible And Click    ${teams_request_navbtn}
    Wait Util Element Is Visible And Contains    ${title_teams_request_page}    Teams Request
    #Open Request Form
    Wait Until Button Is Visible And Click    ${new_request_btn}
    Wait Until Iframe Is Visible And Select Frame    ${request_form_iframe1}
    Wait Until Iframe Is Visible And Select Frame    ${request_form_iframe2}
    #Prevent the Request Form from not loading
    ${check_form_open}    Run Keyword And Return Status    Element Should Be Visible    ${teams_groups_name_input}
    IF    ${check_form_open} == False
        Unselect Frame
        Unselect Frame
        Reload Page
    END
    Wait Until Button Is Visible And Click    ${new_request_btn}
    Wait Until Iframe Is Visible And Select Frame    ${request_form_iframe1}
    Wait Until Iframe Is Visible And Select Frame    ${request_form_iframe2}
    #Fill request info
    Log    Fill Request Form
    Wait Until Element Is Visible And Input Text    ${teams_groups_name_input}    ${teams_group_name}
    Wait Until Element Is Visible And Input Text    ${description_input}    All approve
    Wait Until Element Is Visible And Click    ${type_of_space_input}
    Wait Until Element Is Visible And Click    //li[@data-index='${space_type_no}']
    Wait Until Element Is Visible And Input Text    ${justification_input}    ${justification}
    Wait Until Element Is Visible And Click    ${owners_element}
    Wait Until Element Is Visible    ${owners_input}
    Input Text    ${owners_input}    collet
    Wait Until Element Is Visible And Click    ${first_owner}
    Wait Until Element Is Visible And Click    ${members_element}
    Wait Until Element Is Visible    ${members_input}
    Input Text    ${members_input}    sebastien pierre
    Wait Until Element Is Visible And Click    ${first_member}
    Wait Until Element Is Visible And Click    ${sensitivity_input}
    Wait Until Element Is Visible And Click    //li[@data-index='${sensitivity_label_no}']
    Capture Page Screenshot
    #Exit request form frame
    Unselect Frame
    Wait Until Button Is Visible And Click    ${form_save_btn}
    Wait Until Element Is Not Visible    ${form_save_btn}
    Log    Request form: EXECUTED
    Unselect Frame
    #Access Teams
    Wait Until Button Is Visible And Click    ${app_laucher}
    Wait Until Element Is Visible And Click    ${teams_appbtn}
    Switch Window    NEW
    #Swithch to new Teams
    Sleep    3
    ${new_teams_btn}    Run Keyword And Return Status    Wait Until Element Is Visible    ${switch_new_teams_btn}    15
    IF    ${new_teams_btn}
        Wait Until Button Is Visible And Click    ${switch_new_teams_btn}
    END
    #Select a schedule - specific for Carlos design
    #Wait Until Iframe Is Visible And Select Frame    //iframe[@title='Shifts Tab View']
    #Wait Until Element Is Visible And Click    //button[@aria-label='View schedule for Test Final4']
    #Unselect Frame
    #Select Teams tab
    Wait Until Element Is Visible    ${teams_sidebtn}    30
    Wait Until Button Is Visible And Click    ${teams_sidebtn}
    #Identify the validations that needs to be executed
    ${business_validation}    Run Keyword And Return Status    Should Contain    ${space_type}    Validator
    ${l2appsadmin_validation1}    Run Keyword And Return Status    Should Contain    ${space_type}     L2 Aps Admin
    ${l2appsadmin_validation2}    Run Keyword And Return Status    Should Contain    ${space_type}     L2 Apps Admin
    ${l2im_validation}    Run Keyword And Return Status     Should Contain    ${space_type}    L2 IM
    #Business Validator validation
    Log    Business Validation
    IF    ${business_validation}
        Wait Until Element Is Visible And Click    ${business_validation_channel}
        Wait Until Element Is Visible    //div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')]    120
        Element Should Be Visible    (//div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')])[2]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${space_type}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${justification}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${sensitivity_label}')]
        Wait Until Button Is Visible And Click    ${approve_btn}
        Wait Until Element Is Not Visible    //div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')]    20
        Log    Business Validaton: EXECUTED
    ELSE
        Log    Business Validation: IGNORED
    END
    IF    ${l2appsadmin_validation1}
    #L2 Apps admin validation
        Wait Until Element Is Visible And Click    ${l2-l2_validation_channel}
        Wait Until Element Is Visible    //div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')]    120
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${space_type}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${justification}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${sensitivity_label}')]
        Wait Until Button Is Visible And Click    ${approve_btn}
        Input Text    (${l2appsadmin_input})[1]    Autommated test site
        Input Text    (${l2appsadmin_input})[2]    Automated test site
        Wait Until Button Is Visible And Click    ${send_btn}
        Wait Until Element Is Not Visible    //div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')]    20
        Log    L2 Apps Admin Validation: EXECUTED
    ELSE IF    ${l2appsadmin_validation2}
        Wait Until Element Is Visible And Click    ${l2-l2_validation_channel}
        Wait Until Element Is Visible    //div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')]    120
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${space_type}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${justification}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${sensitivity_label}')]
        Wait Until Button Is Visible And Click    ${approve_btn}
        Input Text    (${l2appsadmin_input})[1]    Automated test site
        Input Text    (${l2appsadmin_input})[2]    Automated test site
        Wait Until Button Is Visible And Click    ${send_btn}
        Wait Until Element Is Not Visible    //div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')]    20
        Log    L2 Apps Admin Validation: EXECUTED
    ELSE
        Log     L2 Apps Admin Validation: IGNORED
    END
    IF    ${l2im_validation}
    #l2-l3 IM validation
        Wait Until Element Is Visible And Click    ${L2_IM_validation_channel}
        Wait Until Element Is Visible    //div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')]    20
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${space_type}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${justification}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${sensitivity_label}')]
        Wait Until Element Is Visible And Click    ${approve_btn}
        Wait Until Element Is Not Visible    //div[@class='ac-textBlock']//p[contains(text(),'${teams_group_name}')]    20
        Log    L2 IM Validation: EXECUTED
    ELSE
        Log     L2 IM Validation: IGNORED
    END