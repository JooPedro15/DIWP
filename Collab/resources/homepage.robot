*** Settings ***
Documentation        Collab homepage
Library              SeleniumLibrary
Resource             DIWP/custom_libraries/customized_keywords.robot
Resource             DIWP/Collab/resources/libraries.robot
Resource             DIWP/Collab/resources/dashboards.robot
Resource             DIWP/Collab/resources/calendars.robot
Resource             DIWP/Collab/resources/links.robot


*** Variables ***
# homepage elements
${icrc_logo_element}            //div[@class='icrc-logo']
${homepage_side_menu}           //div[@class='icrc-menu-left icrc-col icrc-m-3-12 icrc-l-3-12 ms-dialogHidden ms-forceWrap ms-noList']
${latest_news_page_element}     //div[@class='icrc-wp']
# side navigation menu elements
${libraries_side_hp_element}    //div[@class='icrc-menu-left icrc-col icrc-m-3-12 icrc-l-3-12 ms-dialogHidden ms-forceWrap ms-noList']//img[@src="/_layouts/15/ICRC.IMP/images/documents-bleu.png"]
${calendars_side_hp_element}    //div[@class='icrc-menu-left icrc-col icrc-m-3-12 icrc-l-3-12 ms-dialogHidden ms-forceWrap ms-noList']//img[@src="/_layouts/15/ICRC.IMP/images/calendar-bleu.png"]
${links_side_hp_element}        //div[@class='icrc-menu-left icrc-col icrc-m-3-12 icrc-l-3-12 ms-dialogHidden ms-forceWrap ms-noList']//img[@src="/_layouts/15/ICRC.IMP/images/links-bleu.png"]
${dashboard_side_hp_element}    //div[@class='icrc-menu-left icrc-col icrc-m-3-12 icrc-l-3-12 ms-dialogHidden ms-forceWrap ms-noList']//img[@src="/_layouts/15/ICRC.IMP/images/dashboard-bleu.png"]



*** Keywords ***
Return to homepage
    [Tags]    Ready
    Wait Until Element Is Visible And Click    ${icrc_logo_element}
    Wait Until Element Is Visible    ${homepage_side_menu}

Access Libraries
    [Tags]    Ready
    Wait Until Element Is Visible    ${icrc_logo_element}
    Wait Until Element Is Visible And Click    ${libraries_side_HP_element}
    Wait Until Element Is Visible    ${libraries_top_label}

Access Dashboard
    [Tags]    Ready
    Wait Until Element Is Visible    ${icrc_logo_element}
    Wait Until Element Is Visible And Click    ${dashboard_side_hp_element}
    Wait Until Element Is Visible    ${dashboards_top_label}

Access Calendars
    [Tags]    Ready
    Wait Until Element Is Visible    ${icrc_logo_element}
    Wait Until Element Is Visible And Click    ${calendars_side_hp_element}

    ${calendars_label1}=    Run Keyword And Return Status    Element Should Be Visible    ${calendars_top_label1}
    ${calendars_label2}=    Run Keyword And Return Status    Element Should Be Visible    ${calendars_top_label2}

    IF    ${calendars_label1}
        Capture Page Screenshot
    ELSE IF    ${calendars_label2}
        Capture Page Screenshot
    ELSE
        Fail
    END

Access Links
    [Tags]    IN PROGRESS
    Wait Until Element Is Visible    ${icrc_logo_element}
    Wait Until Element Is Visible And Click    ${links_side_hp_element}
    Wait Until Element Is Visible    ${links_top_label}
    Capture Page Screenshot

Access Our Delegation
    [Tags]    Ready
    Wait Until Element Is Visible    ${icrc_logo_element}
    Wait Until Element Is Visible And Click    ${libraries_side_HP_element}
    Wait Until Element Is Visible    ${libraries_top_label}
    Wait Until Element Is Visible And Click    ${our_delegation_element}
    Element Should Be Visible    ${our_delegation_top_label}