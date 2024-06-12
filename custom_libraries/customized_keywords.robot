*** Settings ***
Documentation        Customized keywords
Library              SeleniumLibrary
Library              Collections


*** Keywords ***
Wait until element is visible and click
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}    20
    Click Element    ${element}

Wait until button is visible and click
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}    20
    Click Button    ${element}

Wait until iframe is visible and select frame
    [Arguments]    ${iframe}
    Wait Until Element Is Visible    ${iframe}    30
    Select Frame    ${iframe}

Wait until element is visible and input text
    [Arguments]    ${element}    ${input}
    Wait Until Element Is Visible    ${element}    20
    Input Text    ${element}    ${input}

Wait until element is visible and input password
    [Arguments]    ${element}    ${password}
    Wait Until Element Is Visible    ${element}    20
    Input Password    ${element}    ${password}

Wait extra until element is visible and input text
    [Arguments]    ${element}    ${input}
    Wait Until Element Is Visible    ${element}    30
    Input Text    ${element}    ${input}

Wait extra until element is visible and input password
    [Arguments]    ${element}    ${password}
    Wait Until Element Is Visible    ${element}    30
    Input Password    ${element}    ${password}
Wait util element is visible and contains
    [Arguments]    ${element}    ${text}
    Wait Until Element Is Visible    ${element}    20
    Wait Until Element Contains    ${element}    ${text}
    
Compare lists
    [Arguments]    ${first_list}    ${second_list}
    Sort List    ${first_list}
    Sort List    ${second_list}
    Lists Should Be Equal    ${first_list}    ${second_list}
    
Click element if visible
    [Arguments]    ${element_locator}
    ${element}=    Run Keyword And Return Status    Element Should Be Visible    ${element_locator}
    WHILE    ${element}
        Click Element    ${element_locator}
        Sleep    3
        ${element}=    Run Keyword And Return Status    Element Should Be Visible    ${element_locator}
    END