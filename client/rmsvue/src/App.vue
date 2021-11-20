<template>
  <div id="app">
    <Dashboard v-if="settings == true" />
  </div>
</template>

<script>
import Dashboard from "./components/Dashboard/dashboard.vue";
export default {
  name: "App",
  components: {
    Dashboard,
  },
  data() {
    return { settings: false };
  },
  mounted() {
    console.log("mounted!");
    this.settings = true;
  },
  setup() {
    console.log("setup!");
  },
};
</script>

<style>
@import "./assets/styles/global.css";
</style>
