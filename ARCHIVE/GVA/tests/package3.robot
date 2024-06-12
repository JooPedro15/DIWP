*** Settings ***
Documentation    Package 3 - GVA
#                Bulk download and deletion of docs
#                Email notifications fro SC docs
Library          SeleniumLibrary
Resource         ../resources/login.robot
Resource         ../resources/onedrive.robot
Resource         ../resources/outlook.robot



*** Test Cases ***
Download and delete files on OneDrive Online
    [Tags]    READY
    Open SPO Site    ${gva_url}
    Login With The Correct Credentials    ${gva_user_email}    ${gva_tenant_enc_pass}
    Access OneDrive Online
    Download Bulk Files
    Delete Bulk Files

Verify emails notifications for Strictly Confidential docs
    [Tags]    READY
    Open SPO Site    ${gva_url}
    Login With The Correct Credentials    ${gva_user_email}    ${gva_tenant_enc_pass}
    Access Outlook
    Verify The Sensitivity Label Email Notification    template_sc_120224    50
