app.controller('VisitsController', ['$scope', '$resource', function($scope, $resource) {
  $scope.topReferrers = 'Loading...';
  $scope.topUrls = 'Loading...';

  $resource('/top_urls').get(function(response) {
    $scope.topUrls = JSON.stringify(response, null, 4);
  });

  $resource('/top_referrers').get(function(response) {
    $scope.topReferrers = JSON.stringify(response, null, 4);
  });
}]);

$(document).ready(function() {
  $('.toggle').click(function() {
    var id = '#' + $(this).attr('data-id');
    $(id).toggle();
  });
});
