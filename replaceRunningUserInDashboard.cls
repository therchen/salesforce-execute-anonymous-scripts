//USE THIS WHEN YOU HAVE AN INACTIVE USER THAT NEEDS TO BE REMOVE FROM MANY, MANY DASHBOARDS AS THE RUNNING USER - REDUCE CLICKS
String oldUserId = 'UserOneId';
String newUserId = 'UserTwoId';
List<Dashboard>() dashboardsIn = [Select Id, Title from Dashboard where Type='SpecifiedUser' and RunningUserId =: oldUserId];
List<Dashboard>() dashboardsOut = new List<Dashboard>();
if(!dashboardsIn.isEmpty()){
    for(Dashboard d: dashboardsIn){
        d.RunningUserId = newUserId;
        dashboardsOut.add(d);
    }
    if(!dashboardsOut.isEmpty()){
        update dashboardsOut;
    }    
}
