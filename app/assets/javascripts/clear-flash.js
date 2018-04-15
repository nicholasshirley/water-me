document.addEventListener("turbolinks:load", () => {
  var elem = document.querySelector('#flash')

  if(elem !== null && elem !== '') {
    setTimeout(() => {
      elem.parentNode.removeChild(elem)
    }, 3000)
  }
});