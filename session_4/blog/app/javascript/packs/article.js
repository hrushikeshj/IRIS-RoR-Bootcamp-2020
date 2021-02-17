
window.addEventListener("load", () => {
  element = document.querySelector('#heat_link');
  element.addEventListener("ajax:success", (event) => {
    console.log('res')
    const [data, status, xhr] = event.detail;
    //console.log(element.classList)
    //Object { status: "success, action: "liked", likes: 1 }
    if(data.status=="success" && data.action=="liked"){
      element.classList.remove("far", "like");
      element.classList.add("fas", "liked");
      element.href=element.href.replace("like","unlike")
      document.querySelector('#count').innerHTML=data.likes+" likes"
    }
    if(data.status=="success" && data.action=="unliked"){
      element.classList.remove("fas", "liked");
      element.classList.add("far", "like");
      element.href=element.href.replace("unlike","like")
      document.querySelector('#count').innerHTML=data.likes+" likes"
    }
  });
  inactive = document.querySelector('#heat_inactive');
  inactive.addEventListener('click', (event)=>{
    event.preventDefault();

  }
});
