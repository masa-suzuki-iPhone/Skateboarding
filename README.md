<br>

# 🛹　SkateSpot　🛹
<br>

<div align="center">
<img src="https://user-images.githubusercontent.com/71866173/112087903-30059f80-8bd2-11eb-86c4-577a2b3f9b43.png" width="300px" height="300px">
</div>
<br>

# :iphone:About App
<p> 私は2021年の3月に「SkateSpot」というアプリをAppStoreにリリースしました。<br>「SkateSpot」は、全国の練習場所に困っているスケーターのためのアプリです。全国にいるスケーター同士でスケボーのできるスポットをシェアする事ができます。さらに、投稿されたスポットにコメントやいいねもする事ができ、ユーザーの感想を把握する事もできます。</p>
<br>

# :globe_with_meridians:App URL
<p> https://apps.apple.com/jp/app/skate-spot/id1556373994 </p>
<br>

# :bulb:Skate Spot の機能

|①スポット一覧|②スポット詳細|③いいね機能|
|:---|:---|:---|
|<img src="https://user-images.githubusercontent.com/71866173/112494846-b71b6900-8dc6-11eb-96c5-ef10750244f7.png" width="250px" height="550px">|<img src="https://user-images.githubusercontent.com/71866173/112497219-c13e6700-8dc8-11eb-82e4-ad86b5b3ca45.png" width="250px" height="550px">|<img src="https://user-images.githubusercontent.com/71866173/112697847-cb955980-8ecb-11eb-996c-63f6f8b6cd71.png" width="250px" height="250px">|
|全国のスケーターが投稿した<br>スポットの一覧を見ることができる!!|投稿をタップすると<br>スポットの詳細な情報を閲覧する事ができる!!|投稿にいいねすることができる!!|


|④コメント機能|⑤マップ機能|⑥投稿機能|
|:---|:---|:---|
|<img src="https://user-images.githubusercontent.com/71866173/112697550-24182700-8ecb-11eb-90ee-fd9679e24d4b.png" width="250px" height="550px">|<img src="https://user-images.githubusercontent.com/71866173/112500622-e54f7780-8dcb-11eb-82d8-b8da52fa1d21.png" width="250px" height="550px">|<img src="https://user-images.githubusercontent.com/71866173/112698121-5bd39e80-8ecc-11eb-9922-e6f1c99c08d2.png" width="250px" height="550px">|
|Spotに対して感想などを投稿できる!!　|現在地付近からスポットを探す事できる!!|あらかじめ用意されたフォームから<br>スポットを気軽にシェアできる!!|
<br>

# :key:アプリを作成した理由
#### 練習場所に困っているスケーターのために、このアプリを作りました。<br>私は高校生の頃、1年間アメリカへ留学していました。そこでは、通学路にスケートパークやスケートスポットがたくさんあり、毎日放課後に友達とスケートボードの練習をしていました。しかし、日本に帰ってきてみると、スケートパークやスケートスポットは少なく、練習することすら難しい状況でした。私の場合、往復2時間かけて練習場所に行かなければなりませんでした。<br>この状況を変えたいと思い、「SkateSpot」というアプリケーションを作りました。全国のスケーターが知っているスポットを共有すれば、練習スポットの総数が増えます。また、スケーター同士の交流が活発になり、スケートボードのコミュニティが広がると考えています。
<br>

# :open_file_folder:使用技術
|言語|サーバーサイド|マップ|
|:---|:---|:---|
|<img src="https://user-images.githubusercontent.com/71866173/112707416-9f3f0480-8eee-11eb-9589-3b5037b49ebb.jpg"  width="250px" heght="100px">|<img src="https://user-images.githubusercontent.com/71866173/112088986-21b88300-8bd4-11eb-8fec-2f7732ca7b5f.png"  width="250px" heght="100px">|<img src="https://user-images.githubusercontent.com/71866173/112707603-f98c9500-8eef-11eb-8e7d-045ad8eca52a.png" width="250px" heght="100px"> |
<br>

# :low_brightness:技術選定理由

<div align="center"><img src="https://user-images.githubusercontent.com/71866173/112088986-21b88300-8bd4-11eb-8fec-2f7732ca7b5f.png" width=device-width heght="100px"></div>

 #### ①サーバー管理・保守の不要
 <p>Firebase を使用する大きなメリットは、手間のかかるサーバー管理や保守が不要になる事です。今回「SkateSpot」というアプリをすぐにでも完成させ、ユーザーの悩みを解決したいと思い、1人で開発するという事も考え、Firebase を選びました。</p>
 
 #### ②認証機能の実装
 <p>「SkateSpot」アプリでは、アカウント登録やログイン機能をつけ、投稿情報を管理しようと考えていたため、Firebase Authentication という、ソーシャルログインやメールアドレスとパスワードに基づく認証を簡単に実装できる機能をもったFirebase を選びました。</p>
 
 #### ③長期的にユーザーの利用状況を分析
 <p>アプリを長期間、より多くの人に利用してもらうためには、ユーザーのニーズを正しく把握するべきと考え、多角的かつ詳細な分析に優れた「Google Analytics for Firebase」という機能を利用する事のできるFirebase を選びました。</p><br>
 
 
 <div align="center"><img src="https://user-images.githubusercontent.com/71866173/112707603-f98c9500-8eef-11eb-8e7d-045ad8eca52a.png" width=device-width heght="100px"></div>
<p>私はアプリ内でマップを表示しようと考え、MapKitではなく、Google Maps SDK for iOSを使用することに決めました。理由としては、「情報量」「iPhoneとAndroid の共通レイアウト」の2点があります。</p>

#### ①情報量
<p>マップを使用する理由は、スポットの位置情報を表示するためです。ユーザーは、今まで知らなかったスポットの住所を、マップを見て探します。そのようなユーザーの視点に立つと、地図に表示される店や地名などの情報が多い方が目的地を探しやすいのではないかと考え、情報量の多いGoogle Mapを使用することに決めました。</p>

#### ②iPhoneとAndroid の共通レイアウト
<p>「SkateSpot 」は現時点でAppStoreでのみリリースされています。アプリをより多くのユーザーに利用してもらうため、今後、Google Play ストアでのリリースも考えています。そのため、iPhone上でもAndroid上でもマップの見え方が統か一されるように Google Mapを使用することにしました。</p>

# :tada:作ってみて出てきた課題
<p>実際にアプリを作成してみて、私は主に以下の2つの問題に直面しました。</p>


#### ①シンプルで簡単な投稿フォーム
<p>投稿フォームを作る際に、特にこだわったのは、とにかく簡単にする事。なぜなら、投稿する難易度が直接、スポットの投稿数に影響すると考えたからです。
　まず一つ目に、スポット住所の記入をマップをタップするだけで完了できるようにしました。スポットの住所を「〇〇県〇〇市1-1-1」のように文字で打ってもらう方法では、ユーザーがスポットを投稿する際に住所を調べるという手順が増えます。手順を減らすために、マップから直接住所を入力する方法で対処する事ができました。</p>
 
#### ②様々な状況に対応したUI
<p>投稿内容によってUIが崩れないよう、投稿内容の詳細ビューはTableViewを使い整えました。
　投稿内容は、住所の長さやユーザーが記入する文の長さによって表示のされ方が異なります。そのため、一つ一つのコンポーネントをViewに直接置いてしまうと、全ての投稿に対応する事ができません。tableViewを使用する事によって、一覧のように区切りがつけられ、どのような投稿にも対応できるようになりました。</p>

<h2 align="middle">Visit our SkateSpot app!!</h2>
