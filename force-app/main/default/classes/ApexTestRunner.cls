public with sharing class ApexTestRunner {
    @AuraEnabled
    public static void runAllTests() {
        List<ApexTestQueueItem> testItems = new List<ApexTestQueueItem>();

        for (ApexClass c : ApexClassHandler.getClasses(true)) {
            testItems.add(new ApexTestQueueItem(ApexClassId = c.Id));
        }

        // Execute tests
        insert testItems;
    }
}
