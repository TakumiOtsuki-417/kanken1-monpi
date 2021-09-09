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

const countRadio = ()=>{
  const radios = document.getElementsByClassName("quest-radio");
  const noCheckMessage = document.getElementById("nocheck-message");
  const firstBtn = document.getElementById("first-btn");
  console.log(radios);
  // チェックされてなければならない数
  const countQuest = radios.length / 4;
  // 単一オブジェクトで機能するaddEventLister準備にforで細分化
  for (let j = 0; j < radios.length; j++) {
    radios[j].addEventListener('change', ()=>{
      console.log(radios[j]);
      let countNotChecked = 0;
      for (let i = 0; i < countQuest; i++) {
        const quest = document.getElementsByName(`score_update[select${i + 1}]`);
        flag = false;
        for (let h = 0; h < 4; h++) {
          if (quest[h].checked == true){
            flag = true;
          }
        }
        const thisQuest = document.getElementById(`block-quest-${i + 1}`);
        if (!flag){
          thisQuest.classList.add("no-checked");
          countNotChecked++;
        } else if (flag && thisQuest.classList.contains("no-checked")) {
          thisQuest.classList.remove("no-checked");
        }
      }
      if (countNotChecked != 0){
        console.log(countNotChecked);
        noCheckMessage.style.display = "block";
        firstBtn.style.display = "none";
      } else {
        noCheckMessage.style.display = "none";
        firstBtn.style.display = "block";
      }
    });
    
  }
};

window.addEventListener('load', answer);
window.addEventListener('load', countRadio);