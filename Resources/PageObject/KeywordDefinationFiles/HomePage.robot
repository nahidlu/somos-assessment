*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    XML
Variables  ../Locators/HomePage.py
Variables  ../../TestData/Testdata.py

*** Variables ***
${UPLOAD_PATH}  /path/to/uploaded/files
${MAX_FILE_SIZE}  1 MB 
${UPLOADED_FILES_NAME}    Test.pdf    Test2.pdf    Test3.pdf


*** Keywords ***
Verify File Upload Element is Visible
    Element Should Be Visible    ${FileUploadButton}  timeout=15

Verify Submit Button is Disable
    Element Should Be Disabled    ${SubmitButton}    timeout=15

Upload a File
    ${FILE_PATH}  Set Variable  ${CURDIR}/../Resources/TestData/Files/Test.pdf
    ${FILE_PATH}  Normalize Path   ${FILE_PATH}
    Choose File  ${File}  ${FILE_PATH}
    Wait Until Element Is Enabled ${SubmitButton}
    Click Button  ${SubmitButton}

Verify File Upload Success Message
    Wait Until Page Contains Element   ${MessageAlert}
    Should Be Equal As Strings    ${MessageAlert}    File Uploaded Successfully

Verify File Uploaded to the Correct Location
    # Extracting the file download link and file name from the file upload history table and verifying that the download link matches the expected upload path
   ${FILE_DOWNLOAD_LINK}  Get Element Attribute   ${FileDownloadLink}   href
   ${FILE_Name}   Get Text  ${TopFileNameInTheTable}
   Run Keyword If    "${FILE_DOWNLOAD_LINK}" != "${UPLOAD_PATH}/${FILE_Name}"   Fail   File uploaded to incorrect location

Try to upload a file that exeed the size limit
    ${FILE_PATH}  Set Variable  ${CURDIR}/../Resources/TestData/Files/TestFIleSizeMoreThan1MB.pdf
    ${FILE_PATH}  Normalize Path   ${FILE_PATH}
    ${FILE_SIZE}  Run Keyword    Get File Size    ${FILE_PATH}
    Run Keyword If    ${FILE_SIZE} > ${MAX_FILE_SIZE}    Fail   File size exceeds the maximum limit
    Click Button  ${SubmitButton}

Get File Size
    [Arguments]    ${file_path}
    ${file_size}=    Run Keyword And Return Status    Get File    ${file_path}
    [Return]    ${file_size}

Verify File Size Limit Exeed Error Message
    Wait Until Page Contains Element   ${MessageAlert}
    Should Be Equal As Strings    ${MessageAlert}    File size exceeds the maximum limit

Try to upload a TXT file
    ${FILE_PATH}  Set Variable  ${CURDIR}/../Resources/TestData/Files/Test.txt
    ${FILE_PATH}  Normalize Path   ${FILE_PATH}
    Choose File  ${File}  ${FILE_PATH}
    Click Button  ${SubmitButton}

Try to upload a Docx file
    ${FILE_PATH}  Set Variable  ${CURDIR}/../Resources/TestData/Files/Test.docx
    ${FILE_PATH}  Normalize Path   ${FILE_PATH}
    Choose File  ${File}  ${FILE_PATH}
    Click Button  ${SubmitButton}

Verify File Type Not Support
    Wait Until Page Contains Element   ${MessageAlert}
    Should Be Equal As Strings    ${MessageAlert}    Unsupported file type

Upload Multiple Files
    ${FILES_TO_UPLOAD}  Set Variable  ${CURDIR}/../Resources/TestData/Files/Test.pdf    ${CURDIR}/../Resources/TestData/Files/Test2.pdf    ${CURDIR}/../Resources/TestData/Files/Test3.pdf  
    ${FILES_TO_UPLOAD}  Normalize Path   ${FILES_TO_UPLOAD}
    FOR    ${FILE_PTH}    IN    @{FILES_TO_UPLOAD}
        Choose File    ${File}    ${FILE_PTH}
    END
    Click Button  ${SubmitButton}
    
Verify Uploaded Files Listed in The History Table
    FOR    ${EXPECTED_FILE_NAME}    IN    @{UPLOADED_FILES_NAME}
        ${ACTUAL_FILE_NAME_IN_TABLE}    Get Text   xpath://table[@id='table-id']//td[contains(text(),'${EXPECTED_FILE_NAME}')] 
        Should Be Equal As Strings    ${EXPECTED_FILE_NAME}    ${ACTUAL_FILE_NAME_IN_TABLE}
    END

Verify Uploaded File on Top of History Table
    Wait Until Page Contains Element    ${TopFileNameInTheTable}
    ${ACTUAL_TOP_MOST_FILE_NAME}   Get Text  ${TopFileNameInTheTable}
    Should Be Equal As Strings    Test.pdf    ${ACTUAL_TOP_MOST_FILE_NAME} 