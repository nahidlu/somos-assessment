*** Settings ***
Library  SeleniumLibrary
Variables  ../Locators/LoginPage.py
Variables  ../Locators/Header.py

*** Variables ***
${site_url}  https://test-qa.somos.com/
${browser}  Chrome

*** Keywords ***
Opening Browser
    Open Browser  ${site_url}  ${browser}
    Wait Until Element Is Visible  ${LoginUsernameInputBox}  timeout=15

Do Logout
    Click Element  ${LogoutButton}
    Wait Until Element Is Visible  ${LoginUsernameInputBox}  timeout=15