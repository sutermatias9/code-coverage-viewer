@isTest
global with sharing class ClassCoveragesCalloutMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setHeader('Content-Type', 'application/json');
        response.setBody(
            '{"size":4,"totalSize":4,"done":true,"queryLocator":null,"entityTypeName":"ApexCodeCoverageAggregate","records":[{"attributes":{"type":"ApexCodeCoverageAggregate","url":"/services/data/v60.0/tooling/sobjects/ApexCodeCoverageAggregate/715ak000001NsjtAAC"},"NumLinesCovered":0,"NumLinesUncovered":2,"Coverage":{"coveredLines":[],"uncoveredLines":[]},"ApexClassOrTriggerId":"01pak000008C4uUAAS"},{"attributes":{"type":"ApexCodeCoverageAggregate","url":"/services/data/v60.0/tooling/sobjects/ApexCodeCoverageAggregate/715ak000001NsjuAAC"},"NumLinesCovered":0,"NumLinesUncovered":7,"Coverage":{"coveredLines":[],"uncoveredLines":[]},"ApexClassOrTriggerId":"01pak000008C4uTAAS"},{"attributes":{"type":"ApexCodeCoverageAggregate","url":"/services/data/v60.0/tooling/sobjects/ApexCodeCoverageAggregate/715ak000001PfdhAAC"},"NumLinesCovered":12,"NumLinesUncovered":46,"Coverage":{"coveredLines":[3,4,5,7,8,10,11,12,13,15,39,40],"uncoveredLines":[17,19,20,22,23,24,25,27,28,29,30,31,32,33,35,38,49,50,52,53,55,56,60,63,64,66,67,70,73,74,75,76,77,79,80,83,85,87,90,91,94,95,96,100,104,107]},"ApexClassOrTriggerId":"01pak000008L0wTAAS"},{"attributes":{"type":"ApexCodeCoverageAggregate","url":"/services/data/v60.0/tooling/sobjects/ApexCodeCoverageAggregate/715ak000001SbGzAAK"},"NumLinesCovered":0,"NumLinesUncovered":0,"Coverage":{"coveredLines":[],"uncoveredLines":[]},"ApexClassOrTriggerId":"01pak000008aKDJAA2"}]}'
        );

        return response;
    }
}
