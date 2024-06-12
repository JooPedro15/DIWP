*** Settings ***
Library          SeleniumLibrary
Resource         ../resources/login_gva.robot
Resource         ../resources/onedrive.robot
Resource         ../resources/outlook.robot



*** Test Cases ***
Test Case 473512: Download and delete files on OneDrive Online
    [Documentation]    *Objective:* Download and delete files in bulk on OneDrive Online
    ...                *Test Case URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=412018&suiteId=473508
    [Tags]    READY
    Open SPO Site    ${tenant_url}
    Login With The Correct Credentials    ${user_email}    ${enc_pass}
    Access OneDrive Online
    Download Bulk Files
    Delete Bulk Files

Test Case 473513: Verify emails notifications for Strictly Confidential docs
    [Documentation]    *Objective:* Verify emails notifications for Strictly Confidential docs
    ...                *Test Case URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=412018&suiteId=473508
    ...
    [Tags]    READY
    Open SPO Site    ${tenant_url}
    Login With The Correct Credentials    ${user_email}    ${enc_pass}
    Access Outlook
    Verify The Sensitivity Label Email Notification    template_sc_280224    10
