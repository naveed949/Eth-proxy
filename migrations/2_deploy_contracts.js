let Proxy = artifacts.require('./Proxy.sol');
let CourseV1 = artifacts.require('./CourseV1.sol');

module.exports = async function (deployer) {
  let proxy 
  deployer.deploy(Proxy).then(proxy =>{
  
    deployer.deploy(CourseV1).then(courseV1 =>{
      proxy.upgradeTo(courseV1.address)
    })
  })
  
  
};
