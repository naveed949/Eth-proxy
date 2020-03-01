const Proxy = artifacts.require('Proxy')
const CourseV1 = artifacts.require('CourseV1')
const CourseV2 = artifacts.require('CourseV2')
const truffleAssert = require('truffle-assertions')




contract('UpgradableSmartContract - proxy', accounts => {
   let courseV1;
   let courseV2
   let proxy;
   let courseWithProxy;

  const teacher = accounts[0]
  const student1 = accounts[1]
  const student2 = accounts[2]
  const student3 = accounts[3]
  const student4 = accounts[4]

  before(async () => {
    proxy = await Proxy.new({from: teacher})
    courseV1 = await CourseV1.new({from: teacher})
    
  })
  it('configuring CourseV1 contract with proxy', async () => {
    
       let tx = await proxy.upgradeTo(courseV1.address,{from: teacher});
       courseWithProxy = await CourseV1.at(proxy.address);
  });
  it('enrolling student#1 through proxy', async () => {
    let tx = await courseWithProxy.enroll(student1,15,{from: teacher});
    truffleAssert.eventEmitted(tx, 'StudentEnrolled', (ev) => {
      return ev.student === student1;
  });
  })
  it('enrolling student#2 through proxy', async () => {

  let tx = await courseWithProxy.enroll(student2,15,{from: teacher});
  truffleAssert.eventEmitted(tx, 'StudentEnrolled', (ev) => {
    return ev.student === student2;
});
})
it('enrolling student#3 through proxy', async () => {
let tx = await courseWithProxy.enroll(student3,15,{from: teacher});
truffleAssert.eventEmitted(tx, 'StudentEnrolled', (ev) => {
  return ev.student === student3;
});
})
it('increasing student\'s marks', async () => {

let tx = await courseWithProxy.increaseMarks(student1,10,{from: teacher});
truffleAssert.eventEmitted(tx, 'MarksIncreased', (ev) => {
  return ev.marks.toNumber() === 25;
});
})

it('decreasing student\'s marks', async () => {
  
  let tx = await courseWithProxy.decreaseMarks(student1,5,{from: teacher});
  truffleAssert.eventEmitted(tx, 'MarksDecreased', (ev) => {
    return ev.marks.toNumber() === 20;
  });
  })

  it('Total students enrolled', async () => {
    
    let tx = await courseWithProxy.totallStudents();
    assert.equal(tx.toNumber(),3)
    })
    
it('Upgrading smartcontract through proxy', async () => {
    courseV2 = await CourseV2.new({from: teacher})
    await proxy.upgradeTo(courseV2.address,{from: teacher})

   courseWithProxy = await CourseV2.at(proxy.address)
   
 })

 it('Removing student(feature of upgraded contract)', async () => {
  
  let tx = await courseWithProxy.removeStudent(student1,{from: teacher});
  truffleAssert.eventEmitted(tx, 'StudentRemoved', (ev) => {
    return ev.student == student1;
  });
  })
})