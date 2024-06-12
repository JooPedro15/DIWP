*** Settings ***
Documentation    Package 2 - Ivan's tenant
#                Request a new Teams Group - multiple iterations
#                Iterations defined in append package2.1_data.csv file
Library          SeleniumLibrary
Library          DataDriver    file=../Resources/package2_data.csv    encoding=utf_8    dialect=excel
Resource         Colla/custom_libraries/customized_keywords.robot
Resource         ../resources/login.robot
Resource         ../resources/sharepoint.robot
Resource         ../resources/teams.robot
Test Setup       Open SPO Site    ${ivan_tenant_url}
Test Template    Create a new request
Test Teardown    Close Browser


*** Test Cases ***
Request a new Teams Groups: ${teams_group_name}


*** Keywords ***
Create a new request
    [Tags]    READY
    [Arguments]    ${teams_group_name}    ${sensitivity_label}    ${sensitivity_label_no}    ${space_type}    ${space_type_no}
    Login With The Correct Credentials    ${ivan_user_email}    ${ivan_tenant_enc_pass}
    Log    TEST DATA    WARN
    Log    Sensitivity Label: ${sensitivity_label}    WARN
    Log    Space Type: ${space_type}    WARN
    Wait Until Element Is Visible And Click    ${teams_request_navbtn}
    Wait Util Element Is Visible And Contains    ${title_teams_request_page}    Teams Request
    #Open request form
    Wait Until Button Is Visible And Click    ${new_request_btn}
    Wait Until Iframe Is Visible And Select Frame    ${request_form_iframe1}
    Wait Until Iframe Is Visible And Select Frame    ${request_form_iframe2}
    Sleep    3
    #Fill request info
    Wait Until Element Is Visible And Input Text    ${teams_groups_name_input}    ${teams_group_name}
    Wait Until Element Is Visible And Input Text    ${description_input}    testing
    Wait Until Element Is Visible And Click    ${type_of_space_input}
    Wait Until Element Is Visible And Click    //li[@data-index='${space_type_no}']
    Wait Until Element Is Visible And Input Text    ${justification_input}    testing
    Wait Until Element Is Visible And Click    ${owners_input}
    Wait Until Element Is Visible And Click    ${first_owner}
    Wait Until Element Is Visible And Click    ${members_input}
    Wait Until Element Is Visible And Click    ${first_member}
    Wait Until Element Is Visible And Click    ${sensitivity_input}
    Wait Until Element Is Visible And Click    //li[@data-index='${sensitivity_label_no}']
    Log    Request form: OK    WARN
    Sleep    5
    Capture Page Screenshot
    #Exit request form frame
    Unselect Frame
    Unselect Frame
    #Access Teams
    Wait Until Button Is Visible And Click    ${app_laucher}
    Wait Until Element Is Visible And Click    ${teams_appbtn}
    #New window for Teams
    Switch Window    NEW
    #this elements may not be present in the final solution
    Wait Until Iframe Is Visible And Select Frame    //iframe[@title='Shifts Tab View']
    Wait Until Element Is Visible And Click    //button[@aria-label='View schedule for Test Final4']
    Unselect Frame
    Sleep    3
    #Select Teams tab
    Wait Until Button Is Visible And Click    ${teams_sidebtn}
    #Access Validation Group Teams Space
    Wait Until Iframe Is Visible And Select Frame    ${teams_groups_iframe}
    Wait Until Element Is Visible And Click    ${business_validation_channel}
    Log    Validators Teams Group access: OK    WARN
    Sleep    5