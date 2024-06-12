*** Settings ***
Documentation        Collab Calendars
Library              SeleniumLibrary


*** Variables ***
${calendars_top_label1}        //span[@id="DeltaPlaceHolderPageTitleInTitleArea" and contains(text(),'Calendars')]
${calendars_top_label2}        //a[@title="Calendar" and contains(text(),'Calendar')]


*** Keywords ***

