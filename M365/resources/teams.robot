*** Settings ***
Documentation        MS Teams resources
Library              SeleniumLibrary
Resource             DW/custom_libraries/customized_keywords.robot
Resource             ../resources/sharepoint.robot


*** Variables ***
${switch_new_teams_btn}              //button[@data-tid='app-switcher-install-by-policy-primary-btn']
${teams_sidebtn}                     //button[@id='2a84919f-59d8-4441-a975-2a8c2643b741']
${teams_groups_iframe}               //iframe[@class='embedded-electron-webview embedded-page-content']
${business_validation_channel}       //span[@dir='auto' and contains(text(),'Business Validation3')]
${L2_IM_validation_channel}          //span[@dir='auto' and contains(text(),'L2 IM Validation3')]
${l2-l2_validation_channel}          //span[@dir='auto' and contains(text(),'L2-L3 Validation3')]
#Validators elements
${approve_with_changes_btn}           //button[@title='Approve with changes']
${approve_btn}                        //button[@title='Approve']
${reject_btn}                         //button[@title='Reject']
${rejection_justification_element}    //div[@class='ac-input-container']//textarea[@aria-required='true']
${l2appsadmin_input}                  //input[@type='text']
${send_btn}                           //button[@title='Send']
#Test data
${manual_group_name}                  Manual test Group Name
${manual_type_of_space}               Validator, L2 Aps Admin and L2 IM
${manual_justification}               This is a test manual test
${manual_sensitivity_label}           Confidential


*** Keywords ***
Access Teams
    [Tags]    READY
    #Access Teams from SPO
    Wait Until Button Is Visible And Click    ${app_laucher}
    Wait Until Element Is Visible And Click    ${teams_appbtn}
    Switch Window    NEW
    #Swithch to new Teams
    ${new_teams_btn}    Run Keyword And Return Status    Wait Until Element Is Visible    ${switch_new_teams_btn}    15
    IF    ${new_teams_btn}
        Wait Until Button Is Visible And Click    ${switch_new_teams_btn}
    END
    Wait Until Element Is Visible    ${teams_sidebtn}    30

Access Validators Teams Space and Validate
    [Tags]    READY
    #Select a schedule - specific for Carlos design
    #Wait Until Iframe Is Visible And Select Frame    //iframe[@title='Shifts Tab View']
    #Wait Until Element Is Visible And Click    //button[@aria-label='View schedule for Test Final4']
    #Unselect Frame
    Wait Until Button Is Visible And Click    ${teams_sidebtn}
    #Identify the validations that needs to be executed
    ${business_validation}    Run Keyword And Return Status    Should Contain    ${manual_type_of_space}    Validator
    ${l2appsadmin_validation1}    Run Keyword And Return Status    Should Contain    ${manual_type_of_space}     L2 Aps Admin
    ${l2appsadmin_validation2}    Run Keyword And Return Status    Should Contain    ${manual_type_of_space}     L2 Apps Admin
    ${l2im_validation}    Run Keyword And Return Status     Should Contain    ${manual_type_of_space}    L2 IM
    #Business Validator validation
    Log    Business Validation
    IF    ${business_validation}
        Wait Until Element Is Visible And Click    ${business_validation_channel}
        Wait Until Element Is Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')]    120
        Element Should Be Visible    (//div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')])[2]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_type_of_space}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_justification}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_sensitivity_label}')]
        Wait Until Button Is Visible And Click    ${approve_btn}
        Wait Until Element Is Not Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')]    10
        Log    Business Validaton: EXECUTED
    ELSE
        Log    Business Validation: IGNORED
    END
    #L2 Apps admin validation
    Log    L2 Appd Admin Validation
    IF    ${l2appsadmin_validation1}
        Wait Until Element Is Visible And Click    ${l2-l2_validation_channel}
        Wait Until Element Is Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')]    120
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_type_of_space}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_justification}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_sensitivity_label}')]
        Wait Until Button Is Visible And Click    ${approve_btn}
        Input Text    (${l2appsadmin_input})[1]    Manual test site
        Input Text    (${l2appsadmin_input})[2]    Manual tets site
        Wait Until Button Is Visible And Click    ${send_btn}
        Wait Until Element Is Not Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')]    10
        Log    L2 Apps Admin Validation: EXECUTED
    ELSE IF    ${l2appsadmin_validation2}
        Wait Until Element Is Visible And Click    ${l2-l2_validation_channel}
        Wait Until Element Is Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')]    120
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_type_of_space}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_justification}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_sensitivity_label}')]
        Wait Until Button Is Visible And Click    ${approve_btn}
        Input Text    (${l2appsadmin_input})[1]    Manual test site
        Input Text    (${l2appsadmin_input})[2]    Manual tets site
        Wait Until Button Is Visible And Click    ${send_btn}
        Wait Until Element Is Not Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')]    10
        Log    L2 Apps Admin Validation: EXECUTED
    ELSE
        Log     L2 Apps Admin Validation: IGNORED
    END
    #l2-l3 IM validation
    Log    L2-L3 IM Validation
    IF    ${l2im_validation}
        Wait Until Element Is Visible And Click    ${L2_IM_validation_channel}
        Wait Until Element Is Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')]    120
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_type_of_space}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_justification}')]
        Element Should Be Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_sensitivity_label}')]
        Wait Until Button Is Visible And Click    ${approve_btn}
        Wait Until Element Is Not Visible    //div[@class='ac-textBlock']//p[contains(text(),'${manual_group_name}')]    10
        Log    L2 IM Validation: EXECUTED
    ELSE
        Log     L2 IM Validation: IGNORED
    END

    