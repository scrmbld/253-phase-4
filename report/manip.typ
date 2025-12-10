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

Unfortunately, quantitative metrics for the last two users were lost. This was the result of a bug in either Git or Unity, in which scene information can sometimes fail to be updated correctly by a commit. The quantitative data collection scripts were removed from the scene due to this bug.

#table(
  columns: (auto, auto, auto),
  table.header(
    [], [*Control*], [*Experimental*]
  ),
  [Time Mean], [20.19], [35.58],
  [Grabs Mean], [2.75], [7.75],
  [Time Standard Deviation], [12.43], [28.68],
  [Grabs Standard Deviation], [1.91], [5.43],
)

=== Time Results


#figure(
  image("images/control_times.png", width: 60%),
  caption: [Distribution of completion times in the control condition.]
) <controltimes>

The time results show a distribution between ~5 to ~40 seconds. While there is a large cluster in the 5-10 second range, the rest of the distribution is relatively flat.

#figure(
  image("images/experiment_times.png", width: 60%),
  caption: [Distribution of completion times in the experiment condition.]
) <experimenttimes>

The experimental condition data has a similar shape to that of the control, but shifted significantly higher. The range goes all the way up to around 60.

=== Grab Count Results

#figure(
  image("images/control_grabs.png", width: 60%),
  caption: [Distribution of the number of grabs per task in the control condition.]
) <controlgrabs>

The control condition grab counts fall overwhelmingly between 1 and 3. It is clear from the data that users are not grabbing the object a large number of times. The three instances of 7 grabs are clear outliers compared to the other data points.

#figure(
  image("images/experiment_grabs.png", width: 60%),
  caption: [Distribution of the number of grabs per task in the experiment condition.]
) <experimentgrabs>

The experiment condition shows a much wider distribution of grab counts than the control case. The values are also significantly higher than that of the control.

=== Survey Results

#figure(
  grid(
    columns: 2,
    gutter: 2mm,
    image("images/q1_control.png", width: 90%),
    image("images/q2_control.png", width: 90%),
    image("images/q3_control.png", width: 90%),
    image("images/q4_control.png", width: 90%),
    image("images/q5_control.png", width: 90%),
  ),
  caption: [Distribution of responses on survey questions for the control condition.]
) <controlsurvey>

The results of the likert scale questions for the control condition surveys can be seen in @controlsurvey. The respondents seem to have a consensus, except when it comes to re-grabbing objects. Some found that it was necessary, and others did not, yielding a perfectly even split on the matter. For all of the other questions, the consensus is favorable to the control condition. When weighting positive statements with 1, and negative statements with $-1$, we come to an average combined score of 3.5.

#figure(
  grid(
    columns: 2,
    gutter: 2mm,
    image("images/q1_experiment.png", width: 90%),
    image("images/q2_experiment.png", width: 90%),
    image("images/q3_experiment.png", width: 90%),
    image("images/q4_experiment.png", width: 90%),
    image("images/q5_experiment.png", width: 90%),
  ),
  caption: [Distribution of responses on survey questions for the experimental condition.]
) <experimentsurvey>

The results of the likert scale questions for the experimental condition surveys can be seen in @experimentsurvey. Overall, users rated this version unfavorably. Regarding ease of moving objects to the desired position, it is possible that this question was misinterpreted as asking about only position by some users. Even so, the rating is still significantly lower than that of the control condition. The average combined score was $-2.17$.

The videos will be discussed in the #link(<analysis>, [Analysis]) section. Links to all of the recordings can be found in the #link(<appendix>, [Appendix]).

== Analysis <analysis>

It is very clear from both the qualitative and quantitative metrics that the control version is superior. There is a large difference in both grab count and time data, and in the surverys. There are a variety of factors contributing to this result.

The first is that the control condition is much more intuitive. This is not only because the control condition mirrors reality more closely, but also that mapping controller rotation to object rotation in the case of the experimental version did not line up with users' expectations. All of the users seem to assume that the object rotation is instead mapped to controller translation. The video shows every user translating the left controller, whereas rotating it in place allows more precision, greater range of motion, and more closely matches the mapping.

The second reason is a bug in the experimental code that causes the rotation of the object to jump every time it is grabbed with the left hand. The range of rotation afforded by a singe grab should be enough to reach the goal rotation in most cases regardless, but users aren't able to reach the full range of motion because they can't intuit that rotation is mapped to rotation.

The third readon is due to a seemingly insignificant implementation detail of the position control in the experimental version. Because the position of the cube is modified by the displacement of the right controller, and is independent of its rotation, wrist movements have a much smaller effect on the position of the object than in the control condition. This results in the movement feeling significantly more sluggish in the experimental version. One user mentions this in their survery response, with others mentioning it during the tests.

== Conclusion

Although the data is quite convincing, the test still leaves some open questions. It is not clear how much the bug influenced the results of the test. Even so, it seems unlikely that the experimental version would match the results of the control version, due to users' expectation that the object's rotation should be mapped to the cotroller's translation. A future experiment with a translation to rotation mapping that could measure accuracy directly would be interesting, but either way, the experiment clearly demonstrates that the control version is intuitive, efficient, and accurate enough for a wide range of tasks.

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

- #link("https://drive.google.com/file/d/1txqr13IDrL9SWw0ApOxrjlY6SD6rqNyS/view?usp=drive_link", "https://drive.google.com/file/d/1txqr13IDrL9SWw0ApOxrjlY6SD6rqNyS/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1QjWZafn-rNWdX8ezWfdPFd09WmFMv1QU/view?usp=drive_link", "https://drive.google.com/file/d/1QjWZafn-rNWdX8ezWfdPFd09WmFMv1QU/view?usp=drive_link")
- #link("https://drive.google.com/file/d/12ZYIz3fmVOZGroq4htHGQl3Mz_EdV8TJ/view?usp=drive_link", "https://drive.google.com/file/d/12ZYIz3fmVOZGroq4htHGQl3Mz_EdV8TJ/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1p8wVS0O5OHxM2cas2qLlsoC3CyArNjFQ/view?usp=drive_link", "https://drive.google.com/file/d/1p8wVS0O5OHxM2cas2qLlsoC3CyArNjFQ/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1oDju7xbL6PJKlpXyNkLjC3QqC1yTCXEA/view?usp=drive_link", "https://drive.google.com/file/d/1oDju7xbL6PJKlpXyNkLjC3QqC1yTCXEA/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1YTFosMxlzW2sc1KDHgXV6DdY7I7mrICj/view?usp=drive_link", "https://drive.google.com/file/d/1YTFosMxlzW2sc1KDHgXV6DdY7I7mrICj/view?usp=drive_link")

=== Experimental

- #link("https://drive.google.com/file/d/1eKy2a6rAh7sw7mZctZr2XHdxVzSRx4q_/view?usp=drive_link", "https://drive.google.com/file/d/1eKy2a6rAh7sw7mZctZr2XHdxVzSRx4q_/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1ZinS7gxvgC5e-ZT1tEMemy5lVyJNzemH/view?usp=drive_link", "https://drive.google.com/file/d/1ZinS7gxvgC5e-ZT1tEMemy5lVyJNzemH/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1ZuImztI-biDDyaWiI-YBbIR4syur8PGN/view?usp=drive_link", "https://drive.google.com/file/d/1ZuImztI-biDDyaWiI-YBbIR4syur8PGN/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1y2nBlVCBwomiFCRIPvuaCdt7pIVFpxJ8/view?usp=drive_link", "https://drive.google.com/file/d/1y2nBlVCBwomiFCRIPvuaCdt7pIVFpxJ8/view?usp=drive_link")
- #link("https://drive.google.com/file/d/10kOYV8zJfiRiRmCMzCJ4uOpwyF3BZjzi/view?usp=drive_link", "https://drive.google.com/file/d/10kOYV8zJfiRiRmCMzCJ4uOpwyF3BZjzi/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1nnaoTV2VkyJWq66wgSbVaLKKxCzgYgQV/view?usp=drive_link", "https://drive.google.com/file/d/1nnaoTV2VkyJWq66wgSbVaLKKxCzgYgQV/view?usp=drive_link")

=== Screen Recordings (Uncategorized)

These screen recordings cover 

- #link("https://drive.google.com/file/d/1Vz6LTTw6bXRP9H3m5IAgogfUgmcIHFhl/view?usp=drive_link", "https://drive.google.com/file/d/1Vz6LTTw6bXRP9H3m5IAgogfUgmcIHFhl/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1P2D_UlWAseMyQ5e1vG-SCrPD207rzxm4/view?usp=drive_link", "https://drive.google.com/file/d/1P2D_UlWAseMyQ5e1vG-SCrPD207rzxm4/view?usp=drive_link")
- #link("https://drive.google.com/file/d/13HYKROCot5dCwKDwgv3qWxTpbUuYeqEv/view?usp=drive_link", "https://drive.google.com/file/d/13HYKROCot5dCwKDwgv3qWxTpbUuYeqEv/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1IAMsqavDQ4XrcK4D8dvc8d82zmUZWw71/view?usp=drive_link", "https://drive.google.com/file/d/1IAMsqavDQ4XrcK4D8dvc8d82zmUZWw71/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1J6W6YZeCqRaa9-uoaX7ID6a0dMKIGZja/view?usp=drive_link", "https://drive.google.com/file/d/1J6W6YZeCqRaa9-uoaX7ID6a0dMKIGZja/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1J6W6YZeCqRaa9-uoaX7ID6a0dMKIGZja/view?usp=drive_link", "https://drive.google.com/file/d/1J6W6YZeCqRaa9-uoaX7ID6a0dMKIGZja/view?usp=drive_link")
- #link("https://drive.google.com/file/d/1xNf9udsWiE-EXC-5Qem-KoUCCHuKPzTg/view?usp=drive_link", "https://drive.google.com/file/d/1xNf9udsWiE-EXC-5Qem-KoUCCHuKPzTg/view?usp=drive_link")
