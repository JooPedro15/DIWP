*** Settings ***
Documentation        Resources file for Collab testing
Library              SeleniumLibrary


*** Variables ***
@{expected_sensitivity_labels}     Internal
...                                Strictly Confidential
...                                Confidential
...                                Public
@{expected_space_types}            Validator, L2 Aps Admin and L2 IM
...                                L2 Apps Admin
...                                Validator and L2 Apps Admin
...                                L2 Apps Admin and L2 IM
...                                Generic MS Teams space