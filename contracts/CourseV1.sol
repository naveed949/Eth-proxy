pragma solidity ^0.5.3;
import "./Storage.sol";

/**
* @title First version of 'course' smart contract.
* describing a demo of upgradable smartcontract.
* course is smartcontract of an academeic subject where teacher enrolling students
* and as per student's evaluation increase/decrease marks.
* */
contract CourseV1 is Storage {
    /**
    * @dev sets teacher
    * */
    constructor() public {
        teacher = msg.sender;
    }
    /**
    * @dev Modifier ensuring only caller is teacher account.
    * */
    modifier onlyTeacher() {
        require (msg.sender == teacher);
        _;
    }
   /**
   * @dev students can be enrolled by teacher in his course.
   * Modifier - ensuring only teacher can enroll students
   * @param _student - student to be enrolled
   * @param _marks - initial marks (if any) or set default zero.
    */
    function enroll(address _student, uint _marks) public onlyTeacher 
    {
        require (marks[_student] == 0,"student already exists");
        marks[_student] = _marks;
        totallStudents++;
        emit StudentEnrolled(_student);
    }
    /**
   * @dev student's marks increase by teacher.
   * Modifier - ensuring only teacher can increase marks
   * @param _student - student whose marks to be increased
   * @param _marks - marks to be increased.
    */
    function increaseMarks(address _student, uint _marks) public onlyTeacher 
    {
        require (marks[_student] != 0);
        marks[_student] += _marks;

        emit MarksIncreased(_student,marks[_student]);
    }
     /**
   * @dev student's marks decreased by teacher.
   * Modifier - ensuring only teacher can decrease marks
   * @param _student - student whose marks to be decreased
   * @param _marks - marks to be decreased.
    */
    function decreaseMarks(address _student, uint _marks) public onlyTeacher 
    {
        if(marks[_student] - _marks <= 0){
            marks[_student] = 0;
        }else{
            marks[_student] -= _marks;
        }
        emit MarksDecreased(_student, marks[_student]);
    }
     /**
   * @dev return student's marks.
   * @param _student - student whose marks to be returned
    */
    function getMarks(address _student) view public returns (uint) {
        return marks[_student];
    }

    /**
    * Event {StudentEnrolled} - when new student enrolled
    *
     */
    event StudentEnrolled(address indexed student);
    
    /**
    * Event {MarksIncreased} - when student's marks increased
    *
     */
    event MarksIncreased(address indexed student, uint marks);

     /**
    * Event {MarksDecreased} - when student's marks decreased
    *
     */
    event MarksDecreased(address indexed student, uint marks);

}