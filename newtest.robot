*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    utilities.py
Library    String
Suite Setup   Open Browser     about:blank   chrome   
Suite Teardown   Close All Browsers


*** Test Cases ***
New Test
    ${totalrows} =   Get Total Rows Excluding Headers
    FOR   ${row}   IN RANGE   1   ${totalrows}+1
        ${data} =   Get Row Values As List   ${row}
        Log To Console    ${data}[0]
        Run Keyword And Continue On Failure      Give Exam    ${data}
    END




*** Keywords ***
Setup
    Set Selenium Implicit Wait        30
    Set Selenium Timeout              30


Question Answers
    [Arguments]     &{QA}
    @{mykeys} =  Get Dictionary Keys    ${QA}
    # @{shuffledKeys} =  Shuffle List    ${mykeys}
    # ${correctAnswers} =  Generate Random Integer   7   10
    # Log To Console    ${correctAnswers}

    # @{correct_keys}=    Get Slice From List    ${shuffledKeys}    0    ${correctAnswers}
    # Log To Console    @{correct_keys}
    # @{wrong_keys}=      Get Slice From List    ${shuffledKeys}    ${correctAnswers}
    # Log To Console    @{wrong_keys}

    # FOR    ${q}    IN    @{correct_keys}
    #     ${expected}=    Get From Dictionary    ${QA}    ${q}
    #     ${user_answer}=    Set Variable    ${expected}    # Correct answer
    #     # Click Element     //span[contains(text(),'${q}')]//ancestor::div[@jscontroller='sWGJ4b']//*[text()='${expected}']
    # END

    FOR    ${Q}    IN    @{mykeys}
        Click Element     //span[contains(text(),'${Q}')]//ancestor::div[@jscontroller='sWGJ4b']//*[text()='${QA}[${Q}]']
    END

Question Answers Incorrectly
    [Arguments]     &{QA}
    @{mykeys} =  Get Dictionary Keys    ${QA}
    FOR    ${Q}    IN    @{mykeys}
        ${randomnumber} =  Set Variable  ${{random.randint(1, 4)}}
        Log To Console    ${randomnumber}
        Click Element     (//span[contains(text(),'${Q}')]//ancestor::div[@jscontroller='sWGJ4b']//span[@class='H2Gmcc tyNBNd']//span)[${randomnumber}]
    END

Give Exam
    [Arguments]     ${data}
    Go To    https://docs.google.com/forms/d/e/1FAIpQLSdS26l6h2iffHLO8CXXjOgn1BrEPGc701VDvWKnjqO67h52Rg/viewform 
    #Profile ID
    Input Text      //input[@aria-labelledby='i1 i4']       ${data}[0]
    #Emp Name
    Input Text      //input[@aria-labelledby='i6 i9']       ${data}[1]
    # facility
    click Element    //span[text()='Choose'] 
    Sleep     1
    click Element    (//span[text()='MotherHub_STV_BTS'])[2]
    # Department
    click Element    //div[@data-value='Sorting & Bagging']
    # Next
    Click Element   //span[text()='Next']
    sleep  1s
    
    Question Answers    LDAP ID is used for Login in Hub System=Own
    ...    What is the full form of CPD?=Customer Promise Date
    ...    While Secondary Sorting, Shipment are sorted basis of the Bin Number displayed on the screen=TRUE
    ...    While Closing the bag, Ensure that items are not filled beyond the maximum limit of the bag indicated by the___color line=Blue
    ...    What is the difference between Primary & Secondary Sorting=Station No.& Bin No
    ...    What is the full form of BRSNR?=Bag Receive Shipment Not Received
    ...    Which tool we are using for Sorting process?=Both b and C
    ...    If the tracking id is not readable or the operator finds any shipment which has no label or tracking ID in it, then handover the shipment to=IRT

    Question Answers Incorrectly    When do we start the Bagging Process?=Above a & b
    ...    While Secondary sorting, If we get the error as Wrong Station then what it means=Shipment is scanned at the wrong station
    
    #Submit
    click element   //span[text()='Submit']
    Wait until page contains    Your response has been recorded
    
    
    