import numpy as np
import matplotlib.pyplot as plt
import os

# 生成角度数据，从0到2π，步长为0.01
angles = np.arange(0, 2 * np.pi, 0.01)

# 计算正弦、余弦和正切函数的值
sine_values = np.sin(angles)
cosine_values = np.cos(angles)
tangent_values = np.tan(angles)

# 创建一个图像窗口
plt.figure(figsize=(10, 6))

# 绘制正弦函数图像
plt.subplot(3, 1, 1)
plt.plot(angles, sine_values, label='Sine')
plt.title('Sine Function')
plt.legend()

# 绘制余弦函数图像
plt.subplot(3, 1, 2)
plt.plot(angles, cosine_values, label='Cosine', color='orange')
plt.title('Cosine Function')
plt.legend()

# 绘制正切函数图像
plt.subplot(3, 1, 3)
plt.plot(angles, tangent_values, label='Tangent', color='green')
plt.title('Tangent Function')
plt.legend()

# 调整图像布局
plt.tight_layout()

# 显示图像
plt.show()
