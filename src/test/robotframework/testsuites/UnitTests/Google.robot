*** Settings ***
Suite Setup       Google.Site.Open
Suite Teardown    Google.Site.Close
Test Setup        Google.Site.Init
Resource          ../../settings/Settings.txt
Resource          ../../imports/Google.txt
Default Tags      phantomjs

*** Testcases ***
Open And Close Google Site
    Capture Page Screenshot
    
Store Web Element In JavaScript
    Wait Until Page Contains Element    //*[contains(@class,'gsfi')]
    Execute Javascript    window.document.my_element = window.document.getElementsByClassName('gsfi')[0];
    ${className}=    Execute Javascript    return window.document.my_element.className;
    Should Contain    ${className}    gsfi

Search Robotframework Selenium2Library
    Google.Search.Search String    Robotframework Selenium2Library Java
    
Search With JavaScript Locator
    SeleniumLibrary.Add Location Strategy    elementById    return window.document.getElementById(arguments[0]);
    Input Text    elementById=lst-ib    Robotframework Selenium2Library Java
    Press Key    elementById=lst-ib    \\13
    Wait Until Element Is Visible    xpath=//a[contains(.,'MarkusBernhardt')]
    Capture Page Screenshot
   
Search With JavaScript Locator Text
    SeleniumLibrary.Add Location Strategy    text    return window.document.evaluate("//*[contains(@value,'" + arguments[0] + "')]", window.document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    Wait Until Element Is Visible    text=Google

Search Without Locator Type
    Input Text    lst-ib    Robotframework Selenium2Library Java
    Press Key    lst-ib    \\13
    Wait Until Element Is Visible    //a[contains(.,'MarkusBernhardt')]
    
Get Id Of Active Element With JavaScript
    Input Text    lst-ib    Robotframework Selenium2Library
    ${activeElementId}=    Execute JavaScript    return window.document.activeElement.id;
