public with sharing class DirectionsController {
    
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