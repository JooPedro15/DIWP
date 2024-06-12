*** Settings ***
Documentation        Collab Dashboards
Library              SeleniumLibrary


*** Variables ***
${dashboards_top_label}            //span[@id="DeltaPlaceHolderPageTitleInTitleArea" and contains(text(),'Dashboards')]
${all_icrc_documents_element}      //a[@title='All ICRC Documents']
${all_site_documents_element}      //a[@title='All site documents']
# All ICRC Documents page elements
${all_icrc_documents_top_label}    //span[@id="DeltaPlaceHolderPageTitleInTitleArea" and contains(text(),'All ICRC Documents')]
${all_site_documents_top_label}    //span[@id="DeltaPlaceHolderPageTitleInTitleArea" and contains(text(),'All site documents')]


*** Keywords ***
Verify Dashboard page elements
    [Tags]    In Progress
    log    Check Dashboard elements are present
    Capture Page Screenshot    
    Element Should Be Visible    ${all_icrc_documents_element}
    Element Should Be Visible    ${all_site_documents_element}
    log    Check All ICRC Documents page
    Click Element    ${all_icrc_documents_element}
    Wait Until Element Is Visible    ${all_icrc_documents_top_label}
    Capture Page Screenshot
    Go Back
    Log    Check ALl site documents page elements
    Click Element    ${all_site_documents_element}
    Wait Until Element Is Visible    ${all_site_documents_top_label}
    Capture Page Screenshot