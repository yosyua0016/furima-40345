const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

    if (document.getElementById('number-form')) {
      numberElement.mount('#number-form');
    }
    if (document.getElementById('expiry-form')) {
      expiryElement.mount('#expiry-form');
    }
    if (document.getElementById('cvc-form')) {
      cvcElement.mount('#cvc-form');
    }
    const form = document.getElementById('charge-form');
    if (form) { 
      form.addEventListener("submit", (e) => {
        e.preventDefault();
        payjp.createToken(numberElement).then(function (response) {
          if (response.error) {
          } else {
            const token = response.id;
            const renderDom = document.getElementById("charge-form");
            const tokenObj = `<input value=${token} name='token' type="hidden">`;
            renderDom.insertAdjacentHTML("beforeend", tokenObj);
          }
          numberElement.clear();
          expiryElement.clear();
          cvcElement.clear();
          document.getElementById("charge-form").submit();
        });
      });
    }
  };

  window.addEventListener("turbo:load", pay)
  window.addEventListener("turbo:render", pay)