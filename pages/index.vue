<template>
<div>
  <Header/>
  <div id="queries">
    <h1> Queries </h1>
    <Queries  />
  </div>
</div>
</template>

<script lang="ts">
import Vue from 'vue'
export default Vue.extend({})
</script>

<style scoped>
#queries {
  margin-left: 20%;
  margin-right: 20%;
}

h1 {
  text-align: center;
}
</style>
