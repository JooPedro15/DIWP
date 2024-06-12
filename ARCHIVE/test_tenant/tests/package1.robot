*** Settings ***
Documentation    Package 1 - Ivan's tenant
#                Login verification
#                Sensitivity lists verification
#                Space Type lists verification    
#                Creation of a single request
Library          SeleniumLibrary
Library          Collections
Resource         ../resources/login.robot
Resource         ../resources/sharepoint.robot
Resource         ../resources/teams.robot

Test Setup       Open SPO Site    ${tenant_url}
Test Teardown    Close Browser


*** Test Cases ***
Verify the Provisioning Process lists
    [Tags]    READY
    Login With The Correct Credentials    ${user_email}    ${enc_pass}
    Verify Sensitivity Labels List
    Verify Space Type list

Request a new Teams Group
    [Tags]    READY
    Login With The Correct Credentials    ${user_email}    ${enc_pass}
    Create And Submit A New Request
    
Validation flow
    [Tags]    IN PROGRESS
    Login With The Correct Credentials    ${user_email}    ${enc_pass}
    Access Teams
    Access Validators Teams Space