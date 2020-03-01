pragma solidity ^0.5.3;
import "./CourseV1.sol";

/**
*@title CourseV2
* upgraded version of CourseV1.
* through this update Teacher can now remove student from Course.
* 
*/
contract CourseV2 is CourseV1 {

/**
   * @dev student can be removed by teacher from his course.
   * Modifier - ensuring only teacher remove student
   * @param _student - student to be removed.
   *
    */
function removeStudent(address _student) public onlyTeacher 
    {
        delete marks[_student];
        emit StudentRemoved(_student);
    }

    /**
    *@dev Event {StudentRemoved} - when student removed by teacher from his course.
    *
     */
    event StudentRemoved(address indexed student);
}