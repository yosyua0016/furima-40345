const pay = () => {
  console.log("カード情報トークン化のためのJavaScript");
  const payjp = Payjp(publicKey)
  const form = document.getElementById('charge-form')
  form.addEventLcistener("submit", (e) => {
    console.log("フォーム送信時にイベント発火")
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);