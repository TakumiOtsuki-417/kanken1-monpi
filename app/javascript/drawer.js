const drawer = ()=>{

  const body = document.getElementById('body');
  const openMenu = document.getElementById('menuControlOpen'); // or whatever triggers the toggle
  const closeMenu = document.getElementById('menuControlClose'); // or whatever triggers the toggle
  openMenu.addEventListener('click', function(e) {
    body.classList.toggle('menu--active'); // or whatever your active class is
  });
  
  closeMenu.addEventListener('click', function(e) {
    body.classList.toggle('menu--active'); // or whatever your active class is
  });
  

};


window.addEventListener('load', drawer);


      