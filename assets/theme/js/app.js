/**
 * @package CybotranikWUI
 * @abstract Website html User Interface.
 * @since 2019
 * @author Azmi SAHIN
 * @copyright azmisahin.com
 * @license https://github.com/cybotranik-wui/cybotranik-wui/blob/master/LICENSE
 * */
function Documentation() { }

/**
 * PWA Application
 */
Documentation.prototype.ServiceWorker = function () {

  /// Service Worker Cache Delete
  // eslint-disable-next-line no-unused-vars
  function deleteCache(){
    caches.keys().then(function(names) {
      for (var name of names){
        console.log('Cache Clear : ' + name)
        caches.delete(name)
      }
    })
  }

  if ('serviceWorker' in navigator) {

    // deleteCache()

    navigator
      .serviceWorker.register('service-worker.js', { scope: '/' })
      .then(function (serviceWorkerRegistration) {

        /// Push permission
        serviceWorkerRegistration.pushManager.getSubscription()

        return serviceWorkerRegistration
      })

    navigator.serviceWorker.ready.then(function () {
      
    })
  }
}

new Documentation().ServiceWorker()
