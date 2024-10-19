@isTest
public with sharing class ApexClassHandlerTest {
    @isTest
    static void testGetClassCoverages() {
        Test.setMock(HttpCalloutMock.class, new ClassCoveragesCalloutMock());

        Integer numClassesInResponseBody = 4;

        Test.startTest();
        List<ClassCoverageWrapper> result = ApexClassHandler.getClassCoverages();
        Test.stopTest();

        Assert.areEqual(numClassesInResponseBody, result.size());
    }
}
