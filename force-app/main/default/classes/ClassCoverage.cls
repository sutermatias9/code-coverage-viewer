public with sharing class ClassCoverage {
    @AuraEnabled
    public String className;
    @AuraEnabled
    public Integer numLinesCovered;
    @AuraEnabled
    public Integer numLinesUncovered;
    @AuraEnabled
    public List<Integer> coveredLines;
    @AuraEnabled
    public List<Integer> uncoveredLines;
}
