*** Settings ***
Documentation        SharePoint resources
Library              SeleniumLibrary
Resource             Colla/custom_libraries/customized_keywords.robot
Resource             ../resources/resources.robot


*** Variables ***
#home elements
${site_header}                   //span[@id='SiteHeaderTitle']
${app_laucher}                   //button[@id='O365_MainLink_NavMenu']
${teams_appbtn}                  //a[@id='O365_AppTile_SkypeTeams']
${onedrive_appbtn}               //a[@id='O365_AppTile_Documents']
${outlook_appbtn}                //a[@id='O365_AppTile_Mail']

${teams_request_navbtn}          //div[@name='Teams Request']
${sensitivity_labels_navbtn}     //div[@name='Sensitivity Labels']
${space_type_navbtn}             //div[@name='Space Type']
#Sensitivity label page elements
${title_sl_page}                 //button[@title='Rename/edit list settings']
${sensitivity_label_elements}    //button[@data-automationid='FieldRenderer-name']
#Space Type list page elements
${title_space_type_page}         //button[@title='Rename/edit list settings']
${space_type_elements}           //button[@data-automationid='FieldRenderer-name']
#Teams request list page elements
${title_teams_request_page}      //button[@title='Rename/edit list settings']
${new_request_btn}               //button[@name='New']
#Request form elements
${request_form_iframe1}          //iframe[@name='webPlayer-iFrame-1']
${request_form_iframe2}          //iframe[@name='fullscreen-app-host']
${form_save_btn}                 //button[@name='Save']
${teams_groups_name_input}       //input[@title='Title']
${description_input}             //input[@title='Description']
${type_of_space_input}           //div[@title='Type of space']
${first_type_of_space}           //li[@data-index='0']
${second_type_of_space}          //li[@data-index='1']
${third_type_of_space}           //li[@data-index='2']
${fourth_type_of_space}          //li[@data-index='3']

${justification_input}           //textarea[@Title='Justification']
${owners_input}                  //div[@title='Owners']
${first_owner}                   //li[@data-index='0']
${second_owner}                  //li[@data-index='1']
${third_owner}                   //li[@data-index='2']

${members_input}                 //div[@title='Members']
${first_member}                  //li[@data-index='0']
${second_member}                 //li[@data-index='1']
${third_member}                  //li[@data-index='2']

${sensitivity_input}             //div[@title='Sensitivity']
${confidential}                  //li[@data-index='0']
${internal}                      //li[@data-index='1']
${public}                        //li[@data-index='2']
${strictly_confidential}         //li[@data-index='3']


*** Keywords ***
Verify Sensitivity Labels list
    #provisioning process was not deployed in GVA
    [Tags]    NOT READY
    #Access Sensitivity Labels list
    Wait Until Element Is Visible And Click    ${sensitivity_labels_navbtn}
    Wait Util Element Is Visible And Contains    ${title_sl_page}    Sensitivity Labels
    #Collect the actual Sensitivity Labels
    ${actual_sensitivity_labels}=    Get Webelements    ${sensitivity_label_elements}
    @{holder_list}=    Create List
    FOR    ${item}    IN    @{actual_sensitivity_labels}
        Append To List    ${holder_list}    ${item.text}
    END
    Compare Lists    ${holder_list}    ${expected_sensitivity_labels}
    log    ${holder_list}    WARN
    Log    ${expected_sensitivity_labels}    WARN
    Log    Sensitivity Labels list: OK    WARN

Verify Space Type list
    #provisioning process was not deployed in GVA
    [Tags]    NOT READY
    #Access Space Type list
    Wait Until Element Is Visible And Click    ${space_type_navbtn}
    Wait Util Element Is Visible And Contains    ${title_space_type_page}    Space Type
    #Collect the actual Sensitivity Labels
    ${actual_space_types}=    Get Webelements    ${space_type_elements}
    @{holder_list}=    Create List
    FOR    ${item}    IN    @{actual_space_types}
        Append To List    ${holder_list}    ${item.text}
    END
    Compare Lists    ${holder_list}    ${expected_space_types}
    Log    ${holder_list}    WARN
    Log    ${expected_space_types}    WARN
    Log    Space Type list: OK    WARN

Create and submit a new request
    #provisioning process was not deployed in GVA
    [Tags]    NOT READY
    Wait Until Element Is Visible    ${teams_request_navbtn}
    #Access Teams Request page
    Wait Until Element Is Visible And Click    ${teams_request_navbtn}
    Wait Util Element Is Visible And Contains    ${title_teams_request_page}    Teams Request
    #Open request form
    Wait Until Button Is Visible And Click    ${new_request_btn}
    Wait Until Iframe Is Visible And Select Frame    ${request_form_iframe1}
    Wait Until Iframe Is Visible And Select Frame    ${request_form_iframe2}
    #Fill request info
    Wait Until Element Is Visible And Input Text    ${teams_groups_name_input}    Internal Teams Space
    Wait Until Element Is Visible And Input Text    ${description_input}    testing
    Wait Until Element Is Visible And Click    ${type_of_space_input}
    Wait Until Element Is Visible And Click    ${first_type_of_space}
    Wait Until Element Is Visible And Input Text    ${justification_input}    testing
    Wait Until Element Is Visible And Click    ${owners_input}
    Wait Until Element Is Visible And Click    ${first_owner}
    Wait Until Element Is Visible And Click        ${members_input}
    Wait Until Element Is Visible And Click    ${first_member}
    Wait Until Element Is Visible And Click        ${sensitivity_input}
    Wait Until Element Is Visible And Click        ${internal}
    Capture Page Screenshot
    Unselect Frame
    Wait Until Button Is Visible And Click    ${form_save_btn}
    Log    Request form: OK    WARN
    Unselect Frame