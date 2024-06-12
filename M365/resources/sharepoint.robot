*** Settings ***
Documentation        DWP SharePoint resources
Library              SeleniumLibrary
Resource             DW/custom_libraries/customized_keywords.robot


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
#Sensitivity Labels page elements
${title_sl_page}                 //input[@value='Sensitivity Labels']
${sensitivity_label_elements}    //span[@data-id="heroField"]
#Space Types list page elements
${title_space_type_page}         //input[@value='Space Type']
${space_type_elements}           //span[@data-id="heroField"]
#Teams Request page elements
${title_teams_request_page}      //button[@title='Rename/edit list settings']
${new_request_btn}               //button[@name='New']
#Request Form elements
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
${fifth_type_of_space}           //li[@data-index='4']
${justification_input}           //textarea[@Title='Justification']
${owners_element}                //div[@title='Owners']
${owners_input}                  //input[@placeholder='Find items']
${first_owner}                   //li[@data-index='0']
${second_owner}                  //li[@data-index='1']
${third_owner}                   //li[@data-index='2']
${members_element}               //div[@title='Members']
${members_input}                 //input[@placeholder='Find items']
${first_member}                  //li[@data-index='0']
${second_member}                 //li[@data-index='1']
${third_member}                  //li[@data-index='2']
${sensitivity_input}             //div[@title='Sensitivity']
${confidential}                  //li[@data-index='0']
${internal}                      //li[@data-index='1']
${public}                        //li[@data-index='2']
${strictly_confidential}         //li[@data-index='3']
#Expected Lists values
@{expected_sensitivity_labels}    Internal
...                               Strictly Confidential
...                               Confidential
...                               Public
@{expected_space_types}           Validator, L2 Aps Admin and L2 IM
...                               L2 Apps Admin
...                               Validator and L2 Apps Admin
...                               L2 Apps Admin and L2 IM
...                               Generic MS Teams space

*** Keywords ***
Verify Sensitivity Labels list
    [Tags]    READY
    #Access Sensitivity Labels list
    Wait Until Element Is Visible And Click    ${sensitivity_labels_navbtn}
    Wait Until Element Is Visible    ${title_sl_page}
    #Collect the actual Sensitivity Labels
    ${actual_sensitivity_labels}=    Get Webelements    ${sensitivity_label_elements}
    @{holder_list}=    Create List
    FOR    ${item}    IN    @{actual_sensitivity_labels}
        Append To List    ${holder_list}    ${item.text}
    END
    #Validate the list
    Compare Lists    ${holder_list}    ${expected_sensitivity_labels}
    Log    Sensitivity Labels list: CORRECT

Verify Space Type list
    [Tags]    READY
    #Access Space Type list
    Wait Until Element Is Visible And Click    ${space_type_navbtn}
    Wait Until Element Is Visible    ${title_space_type_page}
    #Collect the actual Sensitivity Labels
    ${actual_space_types}=    Get Webelements    ${space_type_elements}
    @{holder_list}=    Create List
    FOR    ${item}    IN    @{actual_space_types}
        Append To List    ${holder_list}    ${item.text}
    END
    #Validate the list
    Compare Lists    ${holder_list}    ${expected_space_types}
    Log    Space Type list: CORRECT

Create and submit a new request
    [Tags]    READY
    Wait Until Element Is Visible    ${teams_request_navbtn}
    #Access Teams Request page
    Wait Until Element Is Visible And Click    ${teams_request_navbtn}
    Wait Util Element Is Visible And Contains    ${title_teams_request_page}    Teams Request
    #Open Request Form
    Wait Until Button Is Visible And Click    ${new_request_btn}
    Wait Until Iframe Is Visible And Select Frame    ${request_form_iframe1}
    Wait Until Iframe Is Visible And Select Frame    ${request_form_iframe2}
    #Fill Request From
    Wait Until Element Is Visible And Input Text    ${teams_groups_name_input}    Manual test Group Name
    Wait Until Element Is Visible And Input Text    ${description_input}    Testing
    Wait Until Element Is Visible And Click    ${type_of_space_input}
    Wait Until Element Is Visible And Click    ${fifth_type_of_space}
    Wait Until Element Is Visible And Input Text    ${justification_input}    This is a test manual test
    Wait Until Element Is Visible And Click    ${owners_element}
    Wait Until Element Is Visible    ${owners_input}
    Input Text    ${owners_input}    collet
    Wait Until Element Is Visible And Click    ${first_owner}
    Wait Until Element Is Visible And Click    ${members_element}
    Wait Until Element Is Visible    ${members_input}
    Input Text    ${members_input}    sebastien pierre
    Wait Until Element Is Visible And Click    ${first_member}
    Wait Until Element Is Visible And Click        ${sensitivity_input}
    Wait Until Element Is Visible And Click        ${confidential}
    Capture Page Screenshot
    Unselect Frame
    #Submit
    Wait Until Button Is Visible And Click    ${form_save_btn}
    Wait Until Element Is Not Visible    ${form_save_btn}
    Log    Request Form: EXECUTED
    Unselect Frame