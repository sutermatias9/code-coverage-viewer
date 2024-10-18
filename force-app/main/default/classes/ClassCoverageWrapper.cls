public with sharing class ClassCoverageWrapper {
    @AuraEnabled
    public String className;
    @AuraEnabled
    public String body;
    @AuraEnabled
    public Integer numLinesCovered;
    @AuraEnabled
    public Integer numLinesUncovered;
    @AuraEnabled
    public List<Integer> coveredLines;
    @AuraEnabled
    public List<Integer> uncoveredLines;
}
