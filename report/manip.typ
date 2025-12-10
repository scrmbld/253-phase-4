// document metadata
#set document(
  title: [Virtual Object Manipulation Experiment Report],
  author: "Cynthia Allen",
  date: auto
)

// link stylinig
#show link: underline
#show link: set text(blue)

= Experiment Report -- Virtual Object Manipulation

This report covers the results of the lab usability tests for the virtual object manipulation features.

== Hypothesis Overview

The object manipulation feature covers the movement of virtual objects in the VR environment. In the system, users could grab objects by pressing the grip button on either of their controllers. The behavior of grabbed objects was the subject of the test.

In the control version of the system, the movement of the object is mapped to that of the grabbing controller using Unity's object parent system. The parent system keeps the object's transform fixed relative to that of the parent -- in this case, the grabbed object is fixed relative to the controller. This simulates how real objects move as we hold them in our hands.

The experimental version instead allowed the left hand to only change the rotation, and the right hand to only change the translation. This was implemented by taking the displacement of the controller since the previous update tick, whether in position or rotation, and adding that to the position or rotation of the grabbed object. This seemingly minor implementation detail had an unanticipated effect on how it felt to translate the object.

I hypothesized that, since the experimental condition only required the user to get one out of rotation and translation correct at any given time, it would be more efficient for placing objects in a specific location.

== Experiment Overview

The experiment consisted of an object placement task repeated five times. The system placed two cubes in the environment immediately around the user. One cube repesents a grabbable object, indicated by its red color. The other cube indicated the goal position, and was colored black. Users were instructed to move the red cube to match the goal cube. The task was considered complete when the red cube was within a certain threshold, in rotation and translation, of displacement from those of black cube or one of its symmetries. The translation threshold was $plus.minus 0.1$ Unity distance units ("meters"), the rotation threshold was $plus.minus 8 degree$ total across all three axes of rotational symmetry.

== Recorded Metrics

The experiment recorded the time taken for each of the five tasks, the number of grabs for each of the five tasks, and the number of tasks completed. There was only one experiment run in which the user did not complete five tasks. This occured in the experimental condition; the user successfully placed one out of the five objects in six minutes, which was deemed a time so long relative to the complexity of the tasks that it could be considered a failure.

After each test run, users were asked to fill out a survey about their experience. The survey covered physical comfort, frustration while working on the task, and perceived difficulty. The specific questions can be found in #link(<appendix>, [Appendix]).

The first of the five tasks was treated as a tutorial. Since many users had not used VR before, they required coaching as to how to move in the environment, what button they can use to grab, etc. Thus, the metrics from the first task are not considered in the analysis.

== Results

// TODO: averages table

=== Time Results

#figure(
  image("images/control_times.png", width: 60%),
  caption: [Distribution of completion times in the control condition.]
) <controltimes>

#figure(
  image("images/experiment_times.png", width: 60%),
  caption: [Distribution of completion times in the experiment condition.]
) <experimenttimes>


=== Grab Count Results

#figure(
  image("images/control_grabs.png", width: 60%),
  caption: [Distribution of the number of grabs per task in the control condition.]
) <controlgrabs>

#figure(
  image("images/experiment_grabs.png", width: 60%),
  caption: [Distribution of the number of grabs per task in the experiment condition.]
) <experimentgrabs>

=== Survey Results

#figure(
  grid(
    columns: 2,
    gutter: 2mm,
    image("images/q1_control.png"),
    image("images/q2_control.png"),
    image("images/q3_control.png"),
    image("images/q4_control.png"),
    image("images/q5_control.png"),
  ),
  caption: [Distribution of responses on survey questions for the control condition.]
) <controlsurvey>

The results of the likert scale questions for the control condition surveys can be seen in @controlsurvey. The respondents seem to have a consensus, except when it comes to re-grabbing objects. Some found that it was necessary, and others did not, yielding a perfectly even split on the matter. For all of the other questions, the consensus is favorable to the control condition. When weighting positive statements with 1, and negative statements with $-1$, we come to an average combined score of 3.5.

#figure(
  grid(
    columns: 2,
    gutter: 2mm,
    image("images/q1_experiment.png"),
    image("images/q2_experiment.png"),
    image("images/q3_experiment.png"),
    image("images/q4_experiment.png"),
    image("images/q5_experiment.png"),
  ),
  caption: [Distribution of responses on survey questions for the experimental condition.]
) <experimentsurvey>

The results of the likert scale questions for the experimental condition surveys can be seen in @experimentsurvey. Overall, users rated this version unfavorably. Regarding ease of moving objects to the desired position, it is possible that this question was misinterpreted as asking about only position by some users. Even so, the rating is still significantly lower than that of the control condition. The average combined score was $-2.17$.

The videos will be discussed in the #link(<analysis>, [Analysis]) section. Links to all of the recordings can be found in the #link(<appendix>, [Appendix]).

== Analysis <analysis>

It is very clear from both the qualitative and quantitative metrics that the control version is superior. There is a large difference in both grab count and time data, and in the surverys. There are a variety of factors contributing to this result.

The first is that the control condition is much more intuitive. This is not only because the control condition mirrors reality more closely, but also that mapping controller rotation to object rotation in the case of the experimental version did not line up with users' expectations.

= Appendix <appendix>

== Survey Questions

=== 5 Point Likert Scale

- I felt that I was easily able to grab the objects.
- I found it physically uncomfortable to manipulate the objects at times.
- I found that I needed to release and re-grab the object in order to manipulate it in the way that I wanted.
- It was easy to move objects to the location that I wanted.
- I found manipulating the objects to be frustrating.

=== Free Text

- Do you have any other thoughts or comments that you would like to share?

== Video List

=== Control

=== Experimental
