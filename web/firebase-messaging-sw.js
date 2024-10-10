importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');


  const firebaseConfig = {
    apiKey: 'AIzaSyA532-eIG1geQsl7kINzrL_ZUkxuaZC1KE',
    appId: '1:260675355930:web:91b5d29e50ca3f878898a3',
    messagingSenderId: '260675355930',
    projectId: 'testrafahiaapp',
    authDomain: 'testrafahiaapp.firebaseapp.com',
    storageBucket: 'testrafahiaapp.appspot.com',
    measurementId: 'G-VW942HFNP8',
    };
  // const firebaseConfig = {
  //   apiKey: "AIzaSyCGHLyWqwol0pkU_WwPXvMi0Zi0I6RAZ9E",
  //   authDomain: "rafahiaapp.firebaseapp.com",
  //   projectId: "rafahiaapp",
  //   storageBucket: "rafahiaapp.appspot.com",
  //   messagingSenderId: "172282797237",
  //   appId: "1:172282797237:web:7d6886196d5d7a933eb2fc"
  // };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();


  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });