*** Settings ***
Documentation        Main components verification (Libraries, Dasboard, Calendars and Links)
Library              SeleniumLibrary
Resource             DW/Collab/resources/login.robot
Resource             DW/Collab/resources/homepage.robot
Test Setup           Open Collab site    ${collab_test_uat}    chrome
Test Teardown        Close Browser


*** Variables ***
# test sites
${collab_prod}           https://collab.ext.icrc.org/sites/TS_MON/MOMSC/MOMSC/Forms/AllItems.aspx
${collab_beyrut_uat}     https://collab.uat.icrc.org/sites/TS_BEY/Pages/default.aspx
${collab_test_uat}       https://collab.uat.icrc.org/sites/FD_CU24_SCP/Pages/default.aspx

# Publication and versioning data
${docset_name}    Automated DocSet - Publish and Versioning4
${file_name}      upload_file02

*** Test Cases ***
Test Case 506611: Libraries access and content verification
    [Tags]    Ready
    [Documentation]    *Objective:* Verify Libraries access and components
    ...                *Test Case URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=474976&suiteId=506349
    ...                *Pre-requisites:* None
    Login With The Correct Credentials
    Access Libraries
    Verify Libraries Page Contents

Test Case 506616: Dashboard access and content verification
    [Tags]    Ready
    [Documentation]    *Objective:* Verify Dashboard access and components
    ...                *Test Case URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=474976&suiteId=506349
    ...                *Pre-requisites:* None
    Login With The Correct Credentials
    Access Dashboard
    Verify Dashboard Page Elements

Test Case 506865: Create a DocSet at a library level
    [Tags]    Ready
    [Documentation]    *Objective:* Create a DocSet on a Library
    ...                *Test Case URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=474976&suiteId=506349
    ...                *Pre.requisites:* A DocSet name must be provided as an argument
    Login With The Correct Credentials
    Access Our Delegation
    Create A DocSet On A Our Delegation Library    JP Automated DocSet

Test Case 506935: Upload a document to a DocSet at a library level
    [Tags]    Ready
    [Documentation]    *Objective:* Upload a file into a DocSet stored in a library and all the needed validations.
    ...                *Test URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=474976&suiteId=506349
    ...                *Pre-requisites:* DocSet must be created at a library level.
    ...                                  The DocSet name must be provided as an argument.
    ...                                  The file must be stored in the correct folder and the file name must be provided as an argument.
    Login With The Correct Credentials
    Access Our Delegation
    Upload A Document To A DocSet At A Library Level    JP Automated DocSet    upload_file01


Test Case 507183: Publication and Versioning - library level
    [Tags]    Ready
    [Documentation]    *Objective:* Upload and publication of a document. Then, versioning is tested by uploading the same file and republishing it.
    ...                *Test URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=474976&suiteId=506349
    ...                *Pre-requisites:* The DocSet name must be set in the variables.
    ...                                  The file name must be set in the variables.
    Login With The Correct Credentials
    Access Our Delegation
    Create A DocSet On A Our Delegation Library    ${docset_name}
    Access Our Delegation
    Upload A Document To A DocSet At A Library Level    ${docset_name}    ${file_name}
    Access Our Delegation
    Verify document version at a library level    ${docset_name}    ${file_name}    0.1
    Access Our Delegation
    Publish A Document On A DocSet At A Library Level    ${docset_name}    ${file_name}
    Access Our Delegation
    Verify document version at a library level    ${docset_name}    ${file_name}    1.0
    Access Our Delegation
    Upload A Document To A DocSet At A Library Level    ${docset_name}    ${file_name}
    Access Our Delegation
    Verify document version at a library level    ${docset_name}    ${file_name}    1.1
    Access Our Delegation
    Publish A Document On A DocSet At A Library Level    ${docset_name}    ${file_name}
    Access Our Delegation
    Verify document version at a library level    ${docset_name}    ${file_name}    2.0

Verify the DocSet permissions
    [Tags]    IN PROGRESS
    [Documentation]    Access and verify the user's permissions at of a given DocSet
    Login With The Correct Credentials
    Access Libraries








Test Case 506617: Calendars access and verify contents
    [Tags]    IN PROGRESS
    [Documentation]    *Objective:* Verify Calendars access and components
    ...                *Test Case URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=474976&suiteId=506349
    ...                *Pre-requisites:* None
    Login With The Correct Credentials
    Access Calendars

Test Case 506618: Links access and verify contents
    [Tags]    IN PROGRESS
    [Documentation]    *Objective:* Verify Links access and components
    ...                *Test Case URL:* https://tfs.ext.icrc.org/ICRCCollection/Digital%20Workplace/_testPlans/define?planId=474976&suiteId=506349
    ...                *Pre-requisites:* None
    Login With The Correct Credentials
    Access Links