import './main.css';
import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

console.log('initializing elm...');

function waitForLoginStatus(count) {
  if (count > 50) {
    // prevent eternal loop in case something goes wrong with login
    console.error(
      'Something went wrong (maximum tries exceeded) - try logging in again'
    );
    userData = {};
  }

  console.log('checking login status...');
  if (userData !== undefined) {
    // received login status - initialize Elm

    Elm.Main.init({
      node: document.getElementById('root'),
      flags: {
        timestamp: Date.now(),
        userData: JSON.stringify(userData),
      },
    });

    registerServiceWorker();
  } else {
    window.setTimeout(() => {
      waitForLoginStatus(count + 1);
    }, 100);
  }
}

waitForLoginStatus(1);
