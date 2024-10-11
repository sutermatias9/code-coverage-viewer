public with sharing class ApexTestRunner {
    public static void runAllTests() {
        List<ApexTestQueueItem> testItems = new List<ApexTestQueueItem>();

        for (ApexClass c : [SELECT Id, Body, Name FROM ApexClass]) {
            if (isTestClass(c.Body)) {
                testItems.add(new ApexTestQueueItem(ApexClassId = c.Id));
                System.debug('Test class: ' + c.Name);
            }
        }

        // Execute tests
        insert testItems;
    }

    private static boolean isTestClass(String classBody) {
        String testAnnotation = '@isTest';
        Integer i = 0;
        Boolean isComment = true;
        Boolean isTest = false;

        while (isComment) {
            String nextTwoChars = classBody.substring(i, i + 2);

            // Skip new lines and whitespaces
            if (!nextTwoChars.contains('\n') && !nextTwoChars.contains(' ')) {
                // Detect single-line comments (//)
                if (nextTwoChars == '//') {
                    // Skip to the end of the line
                    i = classBody.indexOf('\n', i);
                }
                // Detect multi-line comments (/*)
                else if (nextTwoChars == '/*') {
                    i = classBody.indexOf('*/', i) + 1;
                }
                // Detect "@isTest" annotation outside comments
                else if (classBody.substring(i, i + testAnnotation.length()).equalsIgnoreCase(testAnnotation)) {
                    isComment = false;
                    isTest = true;
                }
                // If it's not a comment and the "@isTest" annotation, end the loop.
                else {
                    isComment = false;
                }
            }

            i++;
        }

        return isTest;
    }
}
