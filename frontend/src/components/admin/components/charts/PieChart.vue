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
                        label: 'Reservation',
                        backgroundColor: ['#5cc064', '#ffce56', '#ff6384'],
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
                        align: 'start',
                        labels: {
                            color: "#ffffff",
                        },
                    }
                }
            }
        }
    },

    async mounted() {
        this.loaded = false

        try {
            const response = await axios.get(this.env.apiURL + 'dashboard/pie-chart-data');
            this.chartData.datasets[0].data = response.data.data;

            this.chartData.datasets.forEach(dataset => {
                if (dataset.data.every(el => el === 0)) {
                    dataset.backgroundColor.push('rgba(255,255,255,0)');
                    dataset.data.push(1);
                }
            })

            this.loaded = true;
        } catch (e) {
            console.error(e);
        }
    }
}
</script>