*** Settings ***
Library  SeleniumLibrary

Variables  ../Locators/LoginPage.py
Variables  ../../TestData/Testdata.py

*** Keywords ***
Login into the App
    Input Text  ${LoginUsernameInputBox}  ${Username}
    Input Text  ${LoginPasswordInputBox}  ${Password}
    Click Element  ${LoginButton}