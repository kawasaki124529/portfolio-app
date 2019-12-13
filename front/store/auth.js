export const state = () => {
  return {
    Tokens : {}, 
    User: "",
    isLoggedIn: false,
    successLogin: false,
    failedLogin: false,
    successLogout: false,
  }
}

export const mutations = {
  updateTokens(state, Tokens){
    state.Tokens = Tokens;
  },
  updateUser(state, user){
    state.User = user;
  },
  updateIsLoggedIn(state, boolean){
    state.isLoggedIn = boolean;
    state.successLogin = boolean;
  },
  removeAlert(state, payload){
    state.successLogin = payload;
    state.failedLogin = payload;
    state.successLogout = payload;
  },
  failedLogin(state, payload){
    state.failedLogin = payload;
  },
  successLogout(state, payload){
    state.successLogout = payload;
  },
}

export const actions = {
  // ログイン処理
  login({ commit, router }, authData) {
    this.$axios
          // railsのユーザーコントローラーへアクセス
          .post(
            process.env.apiBaseUrl + '/api/auth/sign_in',
            {
              email: authData.email,
              password: authData.password,
            }
          )
          // ログイン成功時処理
          .then(response => {
            console.log(response);
            if (response.statusText === "OK"){
              commit('updateTokens', {
                accessToken: response.headers['access-token'],
                expiry: response.headers.expiry,
                uid: response.headers.uid,
              });
              commit('updateUser', {
                user: response.data.data
              });
              commit('updateIsLoggedIn', true);
              this.$router.push('/');
              setTimeout(function(){
                commit('removeAlert', false);
              },4000);
            }
          })
          // ログイン失敗の際の処理
          .catch(error => {
            console.log(error);
            commit('failedLogin', true);
            setTimeout(function(){
              commit('removeAlert', false);
            },4000);
        })
  },
  // ログアウト処理
  logout({ commit }) {
    commit('updateTokens', null);
    commit('updateUser', null);
    commit('updateIsLoggedIn', false);
    commit('successLogout', true);
    setTimeout(function(){
      commit('removeAlert', false);
    },3500);
    this.$router.push('/');
  }
}

export const strict = false;