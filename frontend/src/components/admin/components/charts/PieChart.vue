<template>
    <Pie v-if="loaded" :options="chartOptions" :data="chartData" height="200" />
</template>

<script>
import { Pie } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, ArcElement, CategoryScale } from 'chart.js'
import axios from "axios"

ChartJS.register(Title, Tooltip, Legend, ArcElement, CategoryScale)

export default {
    components: { Pie },

    data() {
        return {
            loaded: false,
            chartData: {
                labels: ['Reserved', 'Pending', 'Canceled'],
                datasets: [
                    {
                        label: 'Status',
                        backgroundColor: ['#ff6384', '#36a2eb', '#ffce56'],
                        data: []
                    }
                ]
            },
            chartOptions: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'left',
                        align: 'start'
                    }
                }
            }
        }
    },

    async mounted() {
        this.loaded = false

        try {
            const response = await axios.get(this.env.apiURL + 'pie-chart-data')
            this.chartData.datasets[0].data = response.data

            console.log(this.chartData.datasets[0].data)

            this.loaded = true
        } catch (e) {
            console.error(e)
        }
    }
}
</script>