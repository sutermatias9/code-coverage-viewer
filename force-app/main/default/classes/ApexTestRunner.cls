public with sharing class ApexTestRunner {
    public static void runAllTests() {
        String b = [SELECT Id, Body FROM ApexClass WHERE Name = 'ApexTestRunner'].Body;
        Boolean isTest = isTestClass(b);
        System.debug(isTest);
        // List<ApexTestQueueItem> qi = new List<ApexTestQueueItem>();

        // for(ApexClass c : [SELECT Id FROM ApexClass]) {
        //     qi.add(new ApexTestQueueItem(ApexClassId=c.Id));
        // }

        // insert qi;
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
