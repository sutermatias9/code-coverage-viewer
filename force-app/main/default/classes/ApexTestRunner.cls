public with sharing class ApexTestRunner {
    @AuraEnabled
    public static Integer runAllTests() {
        List<ApexTestQueueItem> testItems = new List<ApexTestQueueItem>();

        for (ApexClass c : ApexClassHandler.getClasses(true)) {
            testItems.add(new ApexTestQueueItem(ApexClassId = c.Id));
        }

        if (!Test.isRunningTest()) {
            // Execute tests
            insert testItems;
        }

        return testItems.size();
    }
}
