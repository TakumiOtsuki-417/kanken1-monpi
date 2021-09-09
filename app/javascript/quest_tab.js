const selectTab = ()=>{

  const tabs = document.getElementsByClassName("tab");
  const sections = document.getElementsByClassName("genres");
  for(let i = 0; i < tabs.length; i++) {
    tabs[i].addEventListener('click', ()=>{
      console.log(tabs[i]);
      console.log(sections[i]);
      for(let h = 0; h < tabs.length; h++){
        if (tabs[h].classList.contains("is-active")==true){
          tabs[h].classList.remove("is-active");
        }
        if (sections[h].classList.contains("is-active")==true){
          sections[h].classList.remove("is-active");
        }
      }
      tabs[i].classList.add("is-active");
      sections[i].classList.add("is-active");
    });
  }
  

};

window.addEventListener('load', selectTab);