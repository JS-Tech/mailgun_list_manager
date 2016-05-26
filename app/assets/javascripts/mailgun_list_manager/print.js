function printElement(el) {
  $(el).addClass("print-alone");
  window.print();
  $(el).removeClass("print-alone");
}
