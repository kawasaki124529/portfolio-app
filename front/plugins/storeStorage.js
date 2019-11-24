import createPersistedState from 'vuex-persistedstate'

export default ({ store }) => {
    window.onNuxtReady(() => {
        createPersistedState({
          key: 'portfolio-key',
          storage: window.sessionStorage
        })(store)
    })
}