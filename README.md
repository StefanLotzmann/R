# Introduction
This repository provides helpful tools for risk management. Some of the applications can be used in project risk management, others have been designed for 
simulation studies that can be used to analyse distribution models of risk variables.  All applications were developed in R. They are also freely available to 
other users under an MIT licence. In general, applications in risk management cannot be standardised very well, but usually have to be developed for the 
respective risk analysis. Therefore, the respective source code is to be understood as a blueprint and should still be modified accordingly for the respective 
problem.   
 
</br>

**MCS_Basics.R**</br>
Provides some basic considerations on Monte Carlos simulations.
 
</br>

**MCS_Beispiele.R**</br>
Provides a few standard academic examples for solving problems by MCS: approximation of an indefinite integral, approximation of the circular number Pi, simulation 
of the future price development of an asset starting from the closing price and under normal distribution assumption.

</br>

**Netzplan_CPM.R**</br>
This program takes an activity table and proccess it to find the critical path.
The Critical Path Method (CPM)  were developed by management scientists to help organizations with planning,  scheduling and controlling large projects, such as 
building a new hospital or launching a new product. Large projects have series of interdependent activities that take time to complete, require  funds and resources, 
such as time and labor. Interdependence means that activities follow a given sequence or precedence relationship - some activities cannot start until others are completed.

*Process of the network planning technique* </br>
- Step 1: Identify all the activities in your project! </br>
- Step 2: Determine all activity relationships! (Who is the immediate predecessor of each operation?) </br>
- Step 3: Estimate all activity completion times and costs! </br>
- Step 4: Construct an activitynetwork! </br>
- Step 5: Perform forward scheduling to determine the earliest start time and the earliest end time for each activity as well as the estimated project completion time! </br>
- Step 6: Perform backward scheduling to determine the laterst start time and the latest end time for each activity! </br>
- Step 7: Identify activity slack (length of time an activity can be delayed without delaying the project completion time)! </br>
- Step 8: Find all the activities with zero slack; these are critical activities and make up at least one critical path! </br>
- Step 9: Use information from Steps 5 - 8 to optimize the activity schedule for the project! </br>
- Step 10: Calculate project completion time variance and conduct probability analysis, such as  the probability of meeting a customer target completion time under the condition of uncertainty in activity times! </br>
- Step 11: Consider time-cost tradeoffs! </br>
- Step 10: Implement, monitor and control the project! </br>

*Critical Path Method (CPM)* </br>
The "critical path method" or "critical path analysis" is an algorithm for scheduling a set of project activities. It is commonly used in conjunction with the program evaluation and review technique (PERT).

 -   Netzplan_CPM.R takes an activity table with each activity's titel, immediate predecessor(s) and time and stores it into a graph
 -   it use's a modified Breadth-First-Search-algorithm to traverse the graph to find the forward and backward path
 -   in the forward path it calculates the ES (Early Start time) and EF (Early Finish time ) of each activity
 -   in the backward path it calculates the LS (Late Start time ) and LF (Late Finish time ) of each activity
 -   it calculates the slack value of each activity </br>
  -   it draws a plot showing the graph, the attributes for each node and the critical path (green nodes) </br>
 </br>
        ES (Early Start Time)  = maximum value of "EF" for all the activities it depends on </br> 
        EF (Early Finish Time) = ES + Activity time  </br>
        LF (Late Finish Time) = minimum value of "LS" for all the activites that depends on this activity </br>
        LS (Late Start Time ) = LF - Activity time  </br>
        S (Slack Value) = LS - ES of each activity, if it's zero then this activity is in the critical path </br>
        </br>
