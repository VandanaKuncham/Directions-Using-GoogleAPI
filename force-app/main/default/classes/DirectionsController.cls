/*
************************************************************************************
Apex Class Name    : DirectionsController
Created Date       : May 12, 2023
@description       : This Controller is called by the getDirections LWC.
                     
@author            : Vandana Kuncham 

Modification Log:
Ver   Date         Author                               Modification
1.0   05-12-2023   Vandana Kuncham                      Initial Version
*************************************************************************************
*/
public with sharing class DirectionsController {
    /*
    *************************************************************************************
    @Method Name    : getTravelCost
    @author         : Vandana Kuncham
    @description    : method is used to call the method in the DirectionsService class which returns 
                        possible routes with cost information. 

    @param          : String that represents the orgin address selected in the UI 
                      String that represents the destination address selected in the UI
                      String to represent the transportation mode selected in the UI
    @return         : ResponseModel records representing the 
                      Fare/Cost details for possible routes returned by the API call 
    ************************************************************************************
    */
    @AuraEnabled (cacheable = true)
    public static List<ResponseModel> getTravelCost(String origin, String destination, String transportationMode) {
        try {
			List<ResponseModel> responseModels = DirectionsService.getRoutes(origin, destination, transportationMode);
            return responseModels;
        } catch	(Exception ex) {
            throw  new AuraHandledException(ex.getMessage());
        }
    }    
}