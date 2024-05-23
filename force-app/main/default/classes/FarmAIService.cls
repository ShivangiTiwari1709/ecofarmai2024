public class FarmAIService {
    public static List<Recommendations__c> generateRecommendations(Farm__c farm) {
        List<Recommendations__c> recommendations = new List<Recommendations__c>();
        
        // Fetch recent sensor data
        List<Sensor__c> sensorData = [SELECT SensorType__c, ReadingValue__c FROM Sensor__c LIMIT 10];
        
        for (Sensor__c data : sensorData) {
            if (data.SensorType__c == 'Soil Moisture' && data.ReadingValue__c < 30) {
                Recommendations__c rec = new Recommendations__c();
                rec.Farm__c = farm.Id;
                rec.RecommendationType__c = 'Irrigation';
                rec.Description__c = 'Soil moisture is low. Recommend irrigation.';
                rec.CreatedTimestamp__c = DateTime.now();
                recommendations.add(rec);
            }
            if (data.SensorType__c == 'pH Level' && data.ReadingValue__c > 7) {
                Recommendations__c rec = new Recommendations__c();
                rec.Farm__c = farm.Id;
                rec.RecommendationType__c = 'Sustainability Practices';
                rec.Description__c = 'Soil pH is low. Recommend liming to increase pH level.';
                rec.CreatedTimestamp__c = DateTime.now();
                recommendations.add(rec);
            }
        }
        
        // Insert recommendations into the database
        insert recommendations;
        return recommendations;
    }
}