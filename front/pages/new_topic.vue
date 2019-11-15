<template>
    <v-container fluid grid-list-lg>
      <v-layout row wrap>
        <v-flex xs12 sm12 md6>
          <NewTopicBtn/>
          <!-- <v-btn
            color="cyan accent-2"
            dark
            fab
            fixed
            bottom
            right
          >
            <v-icon>fas fa-plus</v-icon>
          </v-btn> -->
        </v-flex>
      </v-layout>
    </v-container>  
</template>

<script>
import NewTopicBtn from "../components/NewTopicBtn.vue"

export default {
  components: {
    NewTopicBtn
  }
}
</script>