*** Settings ***
Documentation        Teams resources
Library              SeleniumLibrary
Resource             Colla/custom_libraries/customized_keywords.robot
Resource             ../resources/sharepoint.robot


*** Variables ***
${teams_sidebtn}                  //button[@id='2a84919f-59d8-4441-a975-2a8c2643b741']
${teams_groups_iframe}            //iframe[@class='embedded-electron-webview embedded-page-content']
${business_validation_channel}    //span[@dir='auto' and contains(text(),'Business Validation3')]
${L2_IM_validation_channel}       //span[@dir='auto' and contains(text(),'L2 IM Validation3')]
${l2-l2_validation_channel}       //span[@dir='auto' and contains(text(),'L2-L3 Validation3')]

${group_name}                     Hello
${type_of_space}                  Generic MS Teams space
${sensitivity_label}              Confidential


*** Keywords ***
Access Teams
    [Tags]    READY
    Wait Until Button Is Visible And Click    ${app_laucher}
    Wait Until Element Is Visible And Click    ${teams_appbtn}
    #New window for Teams
    Switch Window    NEW
    #swithch to new Teams
    ${new_teams_btn}    Run Keyword And Return Status    Wait Until Element Is Visible    //button[@data-tid='app-switcher-install-by-policy-primary-btn']    15
    IF    ${new_teams_btn}
        Wait Until Button Is Visible And Click    //button[@data-tid='app-switcher-install-by-policy-primary-btn']
    END

Access Validators Teams Space
    #Wait Until Iframe Is Visible And Select Frame    //iframe[@title='Shifts Tab View']
    #Wait Until Element Is Visible And Click    //button[@aria-label='View schedule for Test Final4']
    #Unselect Frame
    Sleep    3
    #Select Teams tab
    Wait Until Button Is Visible And Click    ${teams_sidebtn}
    #Access Validation Group Teams Space
    #Wait Until Iframe Is Visible And Select Frame    ${teams_groups_iframe}
    Wait Until Element Is Visible And Click    ${business_validation_channel}
    Log    Validators Teams Group access: OK    WARN
    Sleep    5
