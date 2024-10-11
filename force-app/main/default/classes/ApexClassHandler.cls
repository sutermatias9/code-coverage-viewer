public with sharing class ApexClassHandler {
    /**
     * @return List<ApexClass> A list of ApexClass records that meet the specified condition.
     *         If `getTestClasses` is true, the list will contain only test classes.
     *         If `getTestClasses` is false, the list will contain only non-test classes.
     */
    public static List<ApexClass> getClasses(Boolean getTestClasses) {
        List<ApexClass> classes = new List<ApexClass>();

        for (ApexClass c : [SELECT Id, Body, Name FROM ApexClass]) {
            Boolean isTest = isTestClass(c.Body);

            if (getTestClasses == isTest) {
                classes.add(c);
            }
        }

        return classes;
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
