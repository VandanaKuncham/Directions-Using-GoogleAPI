@isTest
private class DirectionsCalloutTest {
    @isTest static  void testGetCalloutDriving() {
        String origin = '650 California Street, California, 94105';
        String destination = '140 New Montgomerry Road,California, 94105';
        String transportationMode = 'Driving';
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetDirectionsResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        List<ResponseModel> fareOptions = DirectionsController.getTravelCost(origin, destination, transportationMode);
        System.assertEquals('VmFuZGFuYSBLdW5jaGFt',DirectionsService.vHash, 'values do not match');
        System.assertEquals(1, fareOptions.size(), 'Number of responses do not match.');       
        System.assertEquals('23.2 mi', fareOptions[0].duration, 'Duration does not match.');   
        System.assertEquals('27 mins', fareOptions[0].distance, 'Distance does not match.');  
        System.assertEquals(232, fareOptions[0].transportationCost, 'Cost does not match.');  
    }   

    @isTest static  void testGetCalloutWalking() {
        String origin = '650 California Street, California, 94105';
        String destination = '140 New Montgomerry Road,California, 94105';
        String transportationMode = 'Walking';
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetDirectionsResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        List<ResponseModel> fareOptions = DirectionsController.getTravelCost(origin, destination, transportationMode);
        System.assertEquals(1, fareOptions.size(), 'Number of responses do not match.');       
        System.assertEquals('23.2 mi', fareOptions[0].duration, 'Duration does not match.');   
        System.assertEquals('27 mins', fareOptions[0].distance, 'Distance does not match.');  
        System.assertEquals(0, fareOptions[0].transportationCost, 'Cost does not match.');  
    } 


    @isTest static  void testGetCalloutFailure() {
        String origin = '650 California Street, California, 94105';
        String destination = '140 New Montgomerry Road,California, 94105';
        String transportationMode = 'Walking';
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetDirectionsFailureResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        String errorMessage = '';
        List<ResponseModel> fareOptions = new List<ResponseModel>();
        Test.startTest();
            try {
                fareOptions = DirectionsController.getTravelCost(origin, destination, transportationMode);        
            } catch (Exception e) {
                errorMessage = e.getMessage();
            }
        Test.stopTest();
        System.assertEquals(0, fareOptions.size(), 'Number of responses do not match.');  
        System.assertEquals('Script-thrown exception', errorMessage);     
    } 
}