<template>
  <div>
    <form action="">
      <div class="card-header bg-transparent font-weight-bold">
          LOGIN
      </div>
      <div class="card-body">
          <div class="form-label-group">
              <label class="label">ID</label>
              <input class="input form-control" type="text" placeholder="test@test.com" name="email" id="email">
          </div>
          <div class="form-label-group">
              <label class="label">PASSWORD</label>
              <input class="form-control" type="password" placeholder="password" name="password" id="password">
              <div class="text-right mt-md-3">
                  <a class="text-right mt-md-3" href="">パスワード忘れ</a>
              </div>
          </div>
          <div class="card-footer bg-transparent text-center">
              <button class="btn btn-outline-info  btn-lg">
                      LOGIN
              </button>
          </div>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  
}
</script>

<style>

</style>