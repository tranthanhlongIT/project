<template>
    <v-main style="background: #f5f7fb">
        <v-container style="max-width: inherit">
            <router-view></router-view>
        </v-container>
    </v-main>
</template>

<script>
export default {
    name: "AppContainer"
}
</script>

<style lang="scss" scoped></style>