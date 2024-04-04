import numpy as np

# import matplotlib.pyplot as plt
import sys

args = sys.argv
sensorType = args[1]
num_steps = int(args[2])
mean = float(args[3])
volatility = float(args[4])
mean_reversion_rate = float(args[5])


def random_walk_with_mean_reversion(num_steps, mean, volatility, mean_reversion_rate):
    series = np.zeros(num_steps)
    series[0] = mean
    for t in range(1, num_steps):
        shock = volatility * np.random.randn()
        mean_diff = mean - series[t - 1]
        series[t] = series[t - 1] + mean_diff * mean_reversion_rate + shock
    return series


series = random_walk_with_mean_reversion(
    num_steps, mean, volatility, mean_reversion_rate
)

# save series to csv
np.savetxt(f"./data/{sensorType}.csv", series, delimiter=",")

# plt.plot(series)
# plt.title("Random Walk with Mean Reversion")
# plt.xlabel("Time")
# plt.ylabel("Value")
# plt.show()
