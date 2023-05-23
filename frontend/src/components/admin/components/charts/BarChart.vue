<template>
    <Bar v-if="loaded" :options="chartOptions" :data="chartData" height="400" />
</template>

<script>
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'
import axios from "axios"

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
    components: { Bar },

    data() {
        return {
            loaded: false,
            chartData: {
                labels: [],
                datasets: [{
                    label: 'Revenue',
                    backgroundColor: '#f87979',
                    data: []
                }]
            },
            chartOptions: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                var label = context.dataset.label || '';
                                if (label) label += ': ';
                                label += '$' + context.formattedValue;
                                return label;
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        max: 10,
                        min: 0,
                    }
                },
            }
        }
    },

    async mounted() {
        this.loaded = false;

        try {
            const response = await axios.get(this.env.apiURL + 'dashboard/bar-chart-data');
            this.chartOptions.scales.y.max = Math.ceil(response.data.max_value + response.data.max_value * 0.1);
            this.chartData.datasets[0].data = response.data.data;
            this.chartData.labels = response.data.days_in_month;

            this.loaded = true;
        } catch (e) {
            console.error(e);
        }
    }
}
</script>