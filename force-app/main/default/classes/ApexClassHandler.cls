public with sharing class ApexClassHandler {
    @AuraEnabled
    public static List<ClassCoverageWrapper> getClassCoverages() {
        String baseUrl = 'callout:ToolingRest/?q=';
        String query = 'SELECT NumLinesCovered, NumLinesUncovered, Coverage, ApexClassorTriggerId FROM ApexCodeCoverageAggregate';

        try {
            Http http = new Http();

            HttpRequest request = new HttpRequest();
            request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
            request.setMethod('GET');
            request.setEndpoint(baseUrl + EncodingUtil.urlEncode(query, 'UTF-8'));

            HttpResponse response = http.send(request);
            Map<String, Object> deserializedRes = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

            Map<Id, sObject> apexClassesAndTriggers = new Map<Id, sObject>([SELECT Id, Name, Body FROM ApexClass]);
            apexClassesAndTriggers.putAll([SELECT Id, Name, Body FROM ApexTrigger]);
            List<ClassCoverageWrapper> codeCoverageData = new List<ClassCoverageWrapper>();

            for (Object r : (List<Object>) deserializedRes.get('records')) {
                Map<String, Object> record = (Map<String, Object>) r;
                Map<String, Object> coverage = (Map<String, Object>) record.get('Coverage');
                Id classId = (Id) record.get('ApexClassOrTriggerId');
                String className = (String) apexClassesAndTriggers.get(classId).get('Name');
                String classBody = JSON.serialize(apexClassesAndTriggers.get(classId).get('Body')); // Serialize to preserve the \n and \t

                ClassCoverageWrapper classInfo = new ClassCoverageWrapper();
                classInfo.className = className;
                classInfo.body = classBody;
                classInfo.numLinesCovered = (Integer) record.get('NumLinesCovered');
                classInfo.numLinesUncovered = (Integer) record.get('NumLinesUncovered');
                classInfo.coveredLines = convertToIntegerList((List<Object>) coverage.get('coveredLines'));
                classInfo.uncoveredLines = convertToIntegerList((List<Object>) coverage.get('uncoveredLines'));

                codeCoverageData.add(classInfo);
            }

            return codeCoverageData;
        } catch (Exception e) {
            throw new AuraHandledException('Error getting class coverages: ' + e.getMessage());
        }
    }

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

    private static List<Integer> convertToIntegerList(List<Object> objectList) {
        List<Integer> integers = new List<Integer>();

        for (Object num : objectList) {
            integers.add((Integer) num);
        }

        return integers;
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
