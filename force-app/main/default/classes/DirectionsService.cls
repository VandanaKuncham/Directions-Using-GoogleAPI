public with sharing class DirectionsService {

    public static String vHash = 'VmFuZGFuYSBLdW5jaGFt';

    private static Map<String, Decimal> costPerMileData {
        get{
            if (costPerMileData == null) {
                costPerMileData = new Map<String, Decimal>();
                for (CostDetails__mdt cost : CostDetails__mdt.getAll().values()) {
                    costPerMileData.put(cost.TransportationMode__c, cost.Cost_per_mile__c);
                }
            }
            return costPerMileData;
        }               
        private set;
    }

    private static GoogleAPIDetail__mdt googleAPIInfo {
        get{
            if (googleAPIInfo == null) {
                googleAPIInfo = GoogleAPIDetail__mdt.getInstance('GetDirections');
            }
            return googleAPIInfo;
        }               
        private set;
    }

    public static List<ResponseModel> calculateCost(List<DirectionsModel.Routes> possibleRoutes, String transportationMode) {
        List<ResponseModel> responseList = new List<ResponseModel>();
        Decimal transportationCost;
        Integer count = 0;
        for (DirectionsModel.Routes route : possibleRoutes) {
            for (DirectionsModel.Legs leg : route.Legs) {
                count = count + 1;
                String legDuration = (leg.distance.text).substringBefore(' mi');         
                Decimal mileCost;
                if (costPerMileData.containsKey(transportationMode)) {
                    mileCost = costPerMileData.get(transportationMode);
                } else {
                    mileCost = 0;
                } 
                transportationCost =  Decimal.valueOf(legDuration) * mileCost;
                ResponseModel response = new ResponseModel();
                response.id = count;
                response.transportationCost = transportationCost;
                response.duration = leg.distance.text;
                response.distance = leg.duration.text;
                System.debug('Route details:' + response);
                responseList.add(response);
            }
        }
        return responseList;
    }

    public static List<ResponseModel> getRoutes(String origin, String destination, String transportationMode) {
        List<ResponseModel> responseModels =  new List<ResponseModel>();
        HttpRequest req = new HttpRequest();       
        String endPointURL = googleAPIInfo.EndPointURL__c  + '?origin=' + EncodingUtil.urlEncode(origin,'UTF-8') + '&destination=' + EncodingUtil.urlEncode(destination,'UTF-8') + '&mode=' + transportationMode + '&units=imperial&alternatives=true&key=' + googleAPIInfo.APIKey__c;
        req.setEndpoint(endPointURL);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        DirectionsModel directions = DirectionsModel.parse(res.getBody());
        if (directions.status == 'OK') {
            System.debug('Directions:' + directions);
            responseModels = calculateCost(directions.routes, transportationMode);
        } else {
            throw new DirectionsServiceException('Callout failed due to the following reason: ' + directions.status);
        }
        return responseModels;
    }

    public class DirectionsServiceException extends Exception {

    }

}