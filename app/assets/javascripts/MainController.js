
app.controller('MainController', [ '$scope', '$http', '$sce', function($scope, $http, $sce){
    $scope.title = "Connect 4";
    $scope.gameId = null;
    $scope.state = null;
    $scope.gameInProgress = false;
    $scope.instructions = "Click the button to create a new game";

    $scope.createGame = function(){
        $http({
            method: 'POST',
            url: 'create'
        }).then(function successCallback(response){
            $scope.gameId = response.data.id;
            $scope.state = convertColumnsToRows(JSON.parse(response.data.state));
        });
        $scope.gameInProgress = true;
        $scope.instructions = "To take turn, click a column."
    };

    $scope.playerColor = function(val){
        if(val == "1"){
            return 'redSquare';
        }else if(val == "2"){
            return 'yellowSquare';
        }else{
            return 'square';
        }
    }

    $scope.selectColumn = function(index){
        if($scope.gameInProgress){
            $http({
                method: 'PUT',
                url: 'update/' + $scope.gameId,
                data: {
                    column: index
                }
            }).then(function successCallback(response){
                if(response.data.result == "won"){
                    $scope.instructions = "Congratulations, you won!"
                    $scope.gameInProgress = false;
                }else if(response.data.result == "lost"){
                    $scope.instructions = "You lost.  Better luck next time."
                    $scope.gameInProgress = false;
                }
                $scope.state = convertColumnsToRows(JSON.parse(response.data.state));
            });
        }
    }
}]);

function convertColumnsToRows(json){
    var rows = [];
    for(i = json[0].length - 1; i >= 0; i-- ){
        row = []
        for(j = 0; j < json.length; j++){
            row.push(json[j][i]);
        }
        rows.push(row);
    }
    return rows;
}

