export const state = () => {
  return {
    Tokens : {}, // accessToken, uid, expiry wo kakunou
    // accessToken: null, 
    // uid: null,
    // expiry: null,
  }
}

export const mutations = {
  updateTokens(state, Tokens){
    state.Tokens = Tokens;
  },
  updateAccessToken(state, accessToken){
    state.accessToken = accessToken;
    console.log(state.accessToken)
  },
  updateUid(state, uid){
    state.uid = uid;
    console.log(state.uid)
  },
  updateAccessToken(state, expiry){
    state.accessToken = expiry;
    console.log(state.expiry)
  },
}

export const actions = {
  login({ commit }, authData) {
    this.$axios
          .post(
            'http://localhost:8000/api/auth/sign_in',
            {
              email: authData.email,
              password: authData.password,
            }
          )
          .then(response => {
            commit('updateTokens', {
              accessToken: response.headers['access-token'],
              expiry: response.headers.expiry,
              uid: response.headers.uid
            });
            // commit('updateUid', response.headers.uid)
            console.log(response)
          });
  } 
}