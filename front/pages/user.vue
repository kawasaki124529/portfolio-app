<template>
  <h1>Hello, {{ name }}</h1>
</template>

// <script>
// export default {
//   asyncData({ $axios, params }) {
//     return $axios.$get(`http://back:3000/users/${params.id}`)
//       .then((res) => {
//         return { name: res.name }
//       })
//   }
// }
// </script>