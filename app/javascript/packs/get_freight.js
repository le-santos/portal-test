const form = document.getElementById("freight-form");
const cost = document.getElementById("freight-cost");

form.addEventListener("ajax:success", (event) => {
  const [data, status, xhr] = event.detail;
  let response = JSON.parse(xhr.responseText);
  console.log("AJAX request");
  console.log(response[0].cost.toFixed(2));

  cost.innerHTML = `R$ ${response[0].cost.toFixed(2)}`;
});

form.addEventListener("ajax:error", () => {
  cost.innerHTML = "";
  let node = document.createElement("P");
  let content = document.createTextNode("erro na consulta");
  node.appendChild(content);
  cost.appendChild(node);
});
