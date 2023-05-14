public with sharing class ResponseModel {
    @AuraEnabled
    public Integer id;
    @AuraEnabled
    public Decimal transportationCost;
    @AuraEnabled
    public String duration;
    @AuraEnabled
    public String distance;

    public ResponseModel() {

    }
}