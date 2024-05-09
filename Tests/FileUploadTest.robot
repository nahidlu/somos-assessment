*** Settings ***
Documentation  Uploading File and Managing The Uploaded File History

Library  SeleniumLibrary
Resource  ../Resources/PageObject/KeywordDefinationFiles/LoginPage.robot
Resource  ../Resources/PageObject/KeywordDefinationFiles/HomePage.robot
Resource  ../Resources/PageObject/KeywordDefinationFiles/Base.robot

*** Test Cases ***
Login to test-qa.somos.com
    Opening Browser
    Login into the App
    Verify File Upload Element is Visible
    Verify Submit Button is Disable

Upload a File and Verify Location
    Upload a File
    Verify File Upload Success Message
    Verify File Uploaded to the Correct Location

Verify File Upload Size Limt
    Try to upload a file that exeed the size limit
    Verify File Size Limit Exeed Error Message

Verify Uploading Unsupported File Type
    Try to upload a TXT file
    Verify File Type Not Support
    Try to upload a Docx file
    Verify File Type Not Support

Verify Upload Multiple Files
    Upload Multiple Files
    Verify File Upload Success Message
    Verify Uploaded Files Listed in The History Table

Verify Newly Uploaded File Should Appear on The Top Of The History Table
    Upload a File
    Verify Uploaded File on Top of History Table

Verify History of Uploaded Files
    #Above 2 test cases already covered some scenarios of uploaded history table validation. We can add more test case base on further requirement.
    Do Logout
    Close Browser