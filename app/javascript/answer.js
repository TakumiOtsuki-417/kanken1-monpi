const answer = ()=>{
  // 読み込んでから1.5秒後に以下の処理を開始する(謎遅延の対策)
  // window.setTimeout(function(){
    const btn1 = document.getElementById("first-btn");
    console.log(btn1);
    const secondElements = document.querySelectorAll('.second-content');
    secondElements.forEach(function(elem){
      elem.style.display = "none";
    });
    btn1.addEventListener('click', function(){
      btn1.style.display = "none";
      secondElements.forEach(function(elem){
        elem.style.display = "";
      });
      const questRadio = document.querySelectorAll('.quest-radio');
      questRadio.forEach(function(elem){
        if(elem.checked == false){
          elem.disabled = true;
        }
      });
      const top = document.querySelector('html');
      top.scrollTop = 0;
    });
  // }, 1500);
};

window.addEventListener('load', answer);