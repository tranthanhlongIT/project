<template>
    <router-view />
</template>
  
<script>
export default {
    name: 'FrontIndex',
}
</script>

<style>
/* width */
::-webkit-scrollbar {
    width: 0px;
}

@media (min-width: 1140px) {
    .container {
        max-width: 1140px !important;
    }
}
</style>