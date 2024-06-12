*** Settings ***
Library          SeleniumLibrary
Library          Collections
Resource         ../resources/login_dev.robot
Resource         ../resources/sharepoint.robot
Resource         ../resources/teams.robot
Test Setup       Open SPO Site    ${tenant_url}
Test Teardown    Close Browser


*** Test Cases ***
Test Case 473509: Verify Login and Provisioning Process lists
    [Documentation]    *Objective:* Sensitivity labels and Type of Space lists verification
    ...                *Test Case URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=412018&suiteId=473508
    ...                *Prerequisites:* have a the expected Sensitivity Labels and Space type lists verified
    [Tags]    READY
    Login With The Correct Credentials    ${user_email}    ${enc_pass}
    Verify Sensitivity Labels List
    Verify Space Type list

Test Case 473510: Provision a single Teams Group
    [Documentation]    *Objective:* Request a new Teams Group and approve all the validation flow
    ...                *Test Case URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=412018&suiteId=473508
    [Tags]    READY
    Login With The Correct Credentials    ${user_email}    ${enc_pass}
    Create And Submit A New Request
    Access Teams
    Access Validators Teams Space and Validate