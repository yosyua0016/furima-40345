let payInitialized = false; // 初期化済みフラグ

const pay = () => {
  if (!payInitialized) { // 初期化済みでない場合のみ処理を実行
    const publicKey = gon.public_key;
    const payjp = Payjp(publicKey)
    const elements = payjp.elements();
    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');

    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');

    const form = document.getElementById('charge-form')
    form.addEventListener("submit", (e) => {
      payjp.createToken(numberElement).then(function (response) {
        if (response.error) {
        } else {
          const token = response.id;
          const renderDom = document.getElementById("charge-form");
          const tokenObj = `<input value = ${token} name='token' type="hidden">`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
        }
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        document.getElementById("charge-form").submit();
      });
      e.preventDefault();
    });

    payInitialized = true; // 初期化済みフラグを設定
  }
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);