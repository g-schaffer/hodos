

class RouteT {

    final String title;
    final String description;
    final String urlImage;
    final String creator;
    final int avgTime; // in seconds
    final int distance; // in meters
    final double rating; // max=5
    final int traveledBy; // max=5
    final double lat;
    final double lng;

    RouteT(this.title, this.description, this.urlImage, this.avgTime, this.distance, this.rating, this.creator, this.traveledBy, this.lat, this.lng);

    String getStrDistanceKm(){
        return (this.distance / 1000).toStringAsFixed(0);
    }

    String getStrAvgTimeMin(){
        return (this.avgTime / 60).toStringAsFixed(0);
    }

}