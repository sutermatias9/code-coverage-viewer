@isTest
public with sharing class ApexTestRunnerTest {
    @isTest
    static void testRunAllTests() {
        Integer numberOfTestClasses = ApexClassHandler.getClasses(true).size();

        Integer numTestClassesExecuted = ApexTestRunner.runAllTests();

        Assert.areEqual(numTestClassesExecuted, numberOfTestClasses);
    }
}
