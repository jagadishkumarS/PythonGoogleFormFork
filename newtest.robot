*** Settings ***
Library    SeleniumLibrary
Library    Collections
Suite Setup   Setup


*** Test Cases ***
New Test
    Open Browser    https://docs.google.com/forms/d/e/1FAIpQLSdS26l6h2iffHLO8CXXjOgn1BrEPGc701VDvWKnjqO67h52Rg/viewform   chrome   
    Input Text      //input[@aria-labelledby='i1 i4']       123


    # facility
    click Element    //span[text()='Choose'] 
    Sleep     1
    click Element    (//span[text()='MotherHub_STV_BTS'])[2]

    # Department
    click Element    //div[@data-value='Sorting & Bagging']

    # Next
    Click Element   //span[text()='Next']

    Question Answers    LDAP ID is used for Login in Hub System=Own
    ...    What is the full form of CPD?=Customer Promise Date
    ...    Which tool we are using for Sorting process?=Both b and C
    ...    While Secondary Sorting, Shipment are sorted basis of the Bin Number displayed on the screen=TRUE
    ...    When do we start the Bagging Process?=Above a & b
    ...    While Closing the bag, Ensure that items are not filled beyond the maximum limit of the bag indicated by the___color line=Blue
    ...    What is the difference between Primary & Secondary Sorting=Station No.& Bin No
    ...    What is the full form of BRSNR?=Bag Receive Shipment Not Received
    ...    If the tracking id is not readable or the operator finds any shipment which has no label or tracking ID in it, then handover the shipment to=IRT
    ...    While Secondary sorting, If we get the error as Wrong Station then what it means=Shipment is scanned at the wrong station

    



*** Keywords ***
Setup
    Set Selenium Implicit Wait        30
    Set Selenium Timeout              30


Question Answers
    [Arguments]     &{QA}
    @{mykeys} =  Get Dictionary Keys    ${QA}
    FOR    ${Q}    IN    @{mykeys}
        Click Element     //span[contains(text(),'${Q}')]//ancestor::div[@jscontroller='sWGJ4b']//*[text()='${QA}[${Q}]']
    END
    
    