public with sharing class ApexTestRunner {
    public static void runAllTests() {
        List<ApexTestQueueItem> testItems = new List<ApexTestQueueItem>();

        for (ApexClass c : ApexClassHandler.getClasses(true)) {
            testItems.add(new ApexTestQueueItem(ApexClassId = c.Id));
            System.debug('Test class: ' + c.Name);
        }

        // Execute tests
        insert testItems;
    }
}
