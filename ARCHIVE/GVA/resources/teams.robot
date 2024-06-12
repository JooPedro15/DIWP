*** Settings ***
Documentation        Teams resources
Library              SeleniumLibrary
Resource             Colla/custom_libraries/customized_keywords.robot
Resource             ../resources/sharepoint.robot


*** Variables ***
${teams_sidebtn}                  //button[@id='app-bar-2a84919f-59d8-4441-a975-2a8c2643b741']
${teams_groups_iframe}            //iframe[@class='embedded-electron-webview embedded-page-content']
${business_validation_channel}    //span[@data-tid='channel-list-item-text-19:4578d78c375548338957ad57882fd02b@thread.tacv2']
${L2_IM_validation_cahnnel}       //span[@data-tid='channel-list-item-text-19:e0f555182e694c9889840d029fbfce7e@thread.tacv2']


*** Keywords ***
Request Validation
    [Tags]    READY
    #Access Teams
    Wait Until Element Is Visible And Click    ${app_laucher}
    Wait Until Element Is Visible And Click    ${teams_appbtn}
    #New window for Teams
    Switch Window    NEW
    #this elements may not be present in the prod solution
    Sleep    60
    Wait Until Iframe Is Visible And Select Frame    //iframe[@title='Shifts Tab View']
    Wait Until Element Is Visible And Click    //button[@aria-label='View schedule for Test Final4']
    Unselect Frame
    #Select Teams tab
    Wait Until Button Is Visible And Click    ${teams_sidebtn}
    #Open Validation Group frame
    Wait Until Iframe Is Visible And Select Frame    ${teams_groups_iframe}
    Wait Until Element Is Visible And Click    ${business_validation_channel}
    Log    Business Validator Channel access: OK    WARN