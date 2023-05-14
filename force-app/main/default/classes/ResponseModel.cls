/*
**************************************************************************
Apex Class Name    : ResponseModel
Created Date       : May 12, 2023
@description       : This class represents the response Directions 
                        Controller sends to the UI.
                     
@author            : Vandana Kuncham 

Modification Log:
Ver   Date         Author                               Modification
1.0   05-12-2023   Vandana Kuncham                      Initial Version
**************************************************************************
*/
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