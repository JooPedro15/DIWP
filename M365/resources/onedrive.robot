*** Settings ***
Documentation        OneDrive Online resources
Library              SeleniumLibrary
Library              OperatingSystem
Resource             DW/custom_libraries/customized_keywords.robot
Resource             ../resources/sharepoint.robot


*** Variables ***
#Dentsu environment
#${source_file_path}         C:/Users/jsilva04/OneDrive - dentsu/Documentos/Test files
#${destination_file_path}    C:/Users/jsilva04/OneDrive - dentsu/Documentos/Test files/Bulk Files
#GVA
${source_file_path}         C:/Users/jsilva04/OneDrive - International Committee of the Red Cross/Automation
${destination_file_path}    C:/Users/jsilva04/OneDrive - International Committee of the Red Cross/Automation/Bulk Files
#Files
${word_file_name}           hello
#Page elements
${myfiles_btn}              //a[@title='My files']
${automation_folder}        //button[@title='Automation']
${bulk_files_folder}        //button[@title='Bulk Files']
${select_all1}              //div[@aria-labelledby='header24-check']
${select_all2}              //div[@id='header24-check']
${clear_selection_btn}      //button[@title='Clear selection']
${download_btn}             //button[@name='Download']
${delete_btn}               //button[@name='Delete']
${delete_confirm_btn}       //button[@data-automationid='confirmbutton']

*** Keywords ***
Access OneDrive Online
    [Tags]    READY
    Wait Until Element Is Visible And Click    ${app_laucher}
    Wait Until Element Is Visible And Click    ${onedrive_appbtn}
    Switch Window    NEW
    Wait Until Element Is Visible    ${myfiles_btn}

Download bulk files
    [Tags]    READY
    Wait Until Element Is Visible And Click    ${myfiles_btn}
    Wait Until Element Is Visible And Click    ${automation_folder}
    Wait Until Element Is Visible And Click    ${bulk_files_folder}
    Sleep    5
    Wait Until Element Is Visible And Click    ${select_all1}
    Wait Until Element Is Visible And Click    ${select_all2}
    Wait Until Button Is Visible And Click    ${download_btn}
    Log    Docs bulk download: EXECUTED

Delete bulk files
    [Tags]    READY
    Wait Until Element Is Visible And Click    ${myfiles_btn}
    Wait Until Element Is Visible And Click    ${automation_folder}
    Wait Until Element Is Visible And Click    ${bulk_files_folder}
    Wait Until Element Is Visible And Click    ${select_all1}
    Wait Until Button Is Visible And Click    ${delete_btn}
    Wait Until Button Is Visible And Click    ${delete_confirm_btn}
    Log    Docs bulk deletion: EXECUTED