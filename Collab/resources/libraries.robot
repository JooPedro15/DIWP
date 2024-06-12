*** Settings ***
Documentation        Collab Libraries
Library              SeleniumLibrary
Resource             DIWP/custom_libraries/customized_keywords.robot
Resource             DIWP/Collab/resources/homepage.robot


*** Variables ***
${libraries_top_label}               //span[@id="DeltaPlaceHolderPageTitleInTitleArea" and contains(text(),'Libraries')]
# side navigation menu elements
${calendars_lib_side_element}        //div[@class="noindex ms-core-listMenu-verticalBox"]//img[@src="/_layouts/15/ICRC.IMP/images/calendar-bleu.png"]
${links_lib_side_element}            //div[@class="noindex ms-core-listMenu-verticalBox"]//img[@src="/_layouts/15/ICRC.IMP/images/links-bleu.png"]
${dashboards_lib_side_element}       //div[@class="noindex ms-core-listMenu-verticalBox"]//img[@src="/_layouts/15/ICRC.IMP/images/dashboard-bleu.png"]
# page elements
${our_delegation_element}            //a[@title='01. Our Delegation']
${operational response_element}      //a[@title='02. Operational response']
${support_element}                   //a[@title='03. Support']
# our delegation
${our_delegation_top_label}          //a[@title='01. Our Delegation']
# operational response
${operational_response_top_label}    //a[@title='02. Operational response']
# support
${support_top_label}                 //a[@title='03. Support']
# libraries tab elements
${libraries_side_element}            //div[@class='noindex ms-core-listMenu-verticalBox']//img[@src='/_layouts/15/ICRC.IMP/images/documents-bleu.png']
${files_tab}                         //span[@class='ms-cui-tt-span' and contains(text(),'Files')]
${delete_doc_btn}                    //span[@class='ms-cui-ctl-mediumlabel' and contains(text(), 'Delete Document')]
${browse_tab}                        //span[@class='ms-cui-tt-span' and contains(text(), 'Browse')]
${new_document_element}              //span[@id='Ribbon.Documents.New.NewDocument-Large']//span[@class='ms-cui-ctl-largelabel']
${new_docset_element}                //span[@class='ms-cui-glass-ff']
${publish_element}                   //a[@id='Ribbon.Documents.Workflow.Publish-Large']
# new DocSet form elements
${new_docset_form_title}                //span[@id='DeltaPlaceHolderPageTitleInTitleArea' and contains(text(), 'New Document Set: ICRC Team Document Set')]
${new_docset_form_name_label}           //span[@id='FileLeafRef']
${new_docset_form_name_input}           //input[@id='FileLeafRef_8553196d-ec8d-4564-9861-3dbe931050c8_$onetidIOFile']
${new_docset_form_description_label}    //span[@id='DocumentSetDescription']
${new_docset_form_isrec_label}          //span[@id='ICRCIMP_IsRecord']
${new_docset_form_isrec_click}          //input[@id='ICRCIMP_IsRecord_6e849896-ab64-4f8f-aa06-6605bcfadf40_$BooleanField']
${new_docset_rmid_label}                //span[@id='ICRCIMP_RMIdentifier']
${new_docset_rmunit_label}              //span[@id='ICRCIMP_RMUnitInCharge']
${new_docset_form_savebtn}              //input[@id='ctl00_PlaceHolderMain_ctl00_RptControls_btnOK']
# DocSet elements
${doc_selection_element}                //td[@class='ms-cellStyleNonEditable ms-vb-itmcbx ms-vb-imgFirstCell']
${open_dialog_menu_element}             //a[@id='ctx10_146_calloutLaunchPoint']
${more_action_element}                  //span[@id='co10,146,0_callout-ecbMenu']
${doc_version_element}                  //td[@class='ms-cellstyle ms-vb2'][4]
${upload_doc_element}                   //a[@id='Ribbon.Documents.New.AddDocument-Large']
${input_file_element}                   //input[@id='ctl00_PlaceHolderMain_UploadDocumentSection_ctl05_InputFile']
${add_doc_frame}                        //iframe[@class='ms-dlgFrame']
${add_doc_ok_btn}                       //input[@id='ctl00_PlaceHolderMain_ctl04_RptControls_btnOK']
${add_doc_save_btn}                     //input[@id='ctl00_SPWebPartManager_g_cae34b7c_c043_47b5_a3b5_1a2b801e124e_ctl00_ctl02_ctl00_toolBarTbl_RightRptControls_ctl00_ctl00_diidIOSaveItem']
# publish frame
${publish_frame}                        //iframe[@class='ms-dlgFrame']
${publish_ok_element}                           //input[@id='CheckinOk']
# word online app elements
${word_app_frame}                       //iframe[@id='WebApplicationFrame']
${edit_doc_element}                     //span[@class='cui-ctl-mediumlabel' and contains(text(), 'Edit Document')]
${edit_in_browser_option}               //span[@class='cui-ctl-mediumlabel cui-btn-title UIFontBold' and contains(text(), 'Edit in Browser')]
${edit_area}                            //div[@id='WACViewPanel_EditingElement']
${saved_element}                        //span[@id='BreadcrumbSaveStatus' and contains(text(), 'Saved')]


*** Keywords ***
Verify Libraries page contents
    [Tags]    Ready
    [Documentation]    Content verification for Libraries, Our Delagation, Operational response and Support pages
    log    Check Libraries elements are present
    Capture Page Screenshot
    Element Should Be Visible    ${our_delegation_element}
    Element Should Be Visible    ${operational response_element}
    Element Should Be Visible    ${support_element}
    Log    Check Our Delegation page content
    Wait Until Element Is Visible And Click    ${our_delegation_element}
    Element Should Be Visible    ${our_delegation_top_label}
    Capture Page Screenshot
    Go Back
    log    Check Operational Response page content
    Wait Until Element Is Visible And Click    ${operational response_element}
    Element Should Be Visible    ${operational_response_top_label}
    Capture Page Screenshot
    Go Back
    log    Check Support page content
    Wait Until Element Is Visible And Click    ${support_element}
    Element Should Be Visible    ${support_top_label}
    Capture Page Screenshot
    Return To Homepage

Create a DocSet on a Our Delegation library
    [Tags]    Ready
    [Documentation]    Create a DocSet
    [Arguments]    ${docset_name}
    Wait Until Element Is Visible And Click    ${files_tab}
    Wait Until Element Is Visible And Click    ${new_document_element}
    Wait Until Element Is Visible And Click    ${new_docset_element}
    Capture Page Screenshot
    Log    Verify the form elements
    Element Should Be Visible    ${new_docset_form_title}
    Element Should Be Visible    ${new_docset_form_name_label}
    Element Should Be Visible    ${new_docset_form_description_label}
    Element Should Be Visible    ${new_docset_form_isrec_label}
    Element Should Be Visible    ${new_docset_rmid_label}
    Element Should Be Visible    ${new_docset_rmunit_label}
    Log    Fill the form
    Input Text    ${new_docset_form_name_input}    ${docset_name}
    Click Element    ${new_docset_form_savebtn}
    Wait Until Element Is Visible And Click    ${libraries_side_element}
    Wait Until Element Is Visible And Click    ${our_delegation_element}
    Wait Until Element Is Visible    //a[@aria-label='${docset_name}, Folder']
    Capture Page Screenshot
    Return To Homepage
    Wait Until Element Is Visible    ${latest_news_page_element}

Upload a document to a DocSet at a library level
    [Tags]    Ready
    [Documentation]    Upload a document to a DocSet stored in a library.
    [Arguments]    ${docset_name}    ${file_name}
    Wait Until Element Is Visible And Click    //a[@aria-label='${docset_name}, Folder']
    Wait Until Element Is Visible    //span[@id='idDocsetName' and contains(text(), '${docset_name}')]
    Wait Until Element Is Visible And Click    ${files_tab}
    Wait Until Element Is Visible And Click    ${upload_doc_element}
    Wait Until Iframe Is Visible And Select Frame    ${add_doc_frame}
    Wait Until Element Is Visible    ${input_file_element}
    Capture Page Screenshot
    Choose File    ${input_file_element}    C:/Users/jsilva04/OneDrive - International Committee of the Red Cross/Automation/test_files/${file_name}.docx
    Click Element    ${add_doc_ok_btn}
    Wait Until Element Is Visible And Click    ${add_doc_save_btn}
    Unselect Frame
    Element Should Be Visible    //a[@class='ms-listlink ms-draggable' and contains(text(), '${file_name}')]
    Capture Page Screenshot
    Double Click Element    ${browse_tab}
    Return To Homepage
    Wait Until Element Is Visible    ${latest_news_page_element}

Verify document version at a library level
    [Tags]    Ready
    [Documentation]    Compare the document version to an expected value
    [Arguments]    ${docset_name}    ${file_name}    ${expected_version}
    Wait Until Element Is Visible And Click    //a[@aria-label='${docset_name}, Folder']
    Wait Until Element Is Visible And Click    //span[@id='idDocsetName' and contains(text(), '${docset_name}')]
    Element Should Be Visible    //a[@class='ms-listlink ms-draggable' and contains(text(), '${file_name}')]
    Element Should Be Visible    ${doc_version_element}
    ${doc_version}    Get Text    ${doc_version_element}
    IF    ${doc_version} == ${expected_version}
        Log    Version ok
    ELSE
        Fail    Wrong doc version|Expected value= ${expected_version}|Currect value= ${doc_version}
    END
    Double Click Element    ${browse_tab}
    Return To Homepage
    Wait Until Element Is Visible    ${latest_news_page_element}

Publish a document on a DocSet at a Library level
    [Tags]    Ready
    [Documentation]    Publish a document
    [Arguments]    ${docset_name}    ${file_name}
    # access the doc container
    Wait Until Element Is Visible And Click    ${libraries_side_element}
    Wait Until Element Is Visible And Click    ${our_delegation_element}
    Element Should Be Visible    ${our_delegation_top_label}
    Wait Until Element Is Visible And Click    //a[@aria-label='${docset_name}, Folder']
    Wait Until Element Is Visible And Click    //span[@id='idDocsetName' and contains(text(), '${docset_name}')]
    Element Should Be Visible    //a[@class='ms-listlink ms-draggable' and contains(text(), '${file_name}')]
    Wait Until Element Is Visible And Click    ${files_tab}
    Click Element    ${doc_selection_element}
    Wait Until Element Is Visible And Click    ${publish_element}
    Wait Until Iframe Is Visible And Select Frame    ${publish_frame}
    Wait Until Element Is Visible And Click    ${publish_ok_element}
    Unselect Frame
    Double Click Element    ${browse_tab}
    Return To Homepage
    Wait Until Element Is Visible    ${latest_news_page_element}


Access DocSet permissions
    [Tags]    IN PROGRESS
    [Documentation]    Access the user permission of a given DocSet
    [Arguments]
    