const pay = () => {
  // PAY.JPテスト公開鍵を設定
  const payjp = Payjp(process.env.PAYJP_PUBLIC_KEY);
  // フォームを生成するため、elementsインスタンスを作成
  const elements = payjp.elements();
  // 入力フォームを作成(カード番号、有効期限、CVC)
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // id属性を指定し、フォームを置き換える
  numberElement.mount('#card-number');
  expiryElement.mount('#card-expiry');
  cvcElement.mount('#card-cvc');

  // 購入ボタンのid="button"を変数submitに代入
  const submit = document.getElementById("button");
  // 「購入」が押された時にイベント発火
  submit.addEventListener("click", (e) => {
    // 通常のフォーム送信処理がキャンセルされ、サーバーサイドにリクエストは送られない
    e.preventDefault();

    // トークン化
    // 戻り値としてカード情報のトークン取得
    payjp.createToken(numberElement).then(function (response){
      // エラーがないとnilになり、elseの処理がされる
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        // input要素にトークンの値を埋め込む
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      // クレジットカードの情報を削除
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      // キャンセルされていたフォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
      
    });
  });
};

// ページが読み込まれた時に、変数payが実行される
window.addEventListener("load", pay);