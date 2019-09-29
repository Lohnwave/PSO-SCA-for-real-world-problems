# PSO-SCA-for-real-world-problems

Two real-world engineering optimal problems are introduced to validate the effectiveness of PSO in solving real-world problems.
## a) Problem 1: Gear Train Design 
Introduced in [55], the gear train design aims to optimize the gear ratio of a compound gear train involving three gears. The gear ratio is defined as the ratio of the angular velocity of the output shaft to that of the input shaft. The gear ratio n is formulated by
```
n=X1*X2/X3*X4.                   (1)
```
where X_i∈[12,60],i=1,2,3,4. It is desired to achieve a gear ratio as close as possible to 1/6.931. Consequently, the objective function for optimizing the gear ration can be defined as
```
minf(X)=(1/6.931-n)^2.           (2)
```
## b) Problem 2: Parameter Estimation for Frequency-Modulated (FM) Sound Waves
The parameter estimation of frequency modulated (FM) sound waves, which is introduced in, is an extremely complicated multimodal problem. The sound wave can be formulated as 
```
y(t)=a1*sin⁡(ω1tθ+a2*sin⁡(ω2tθ+a3*sin⁡(ω3tθ))). (3)
```
where the estimated parameters can be described as a vector X=[a1,ω1,a2,ω2,a3,ω3].The formula for the target sound waves is formulated as:
```
yo(t)=sin⁡(5tθ-1.5sin⁡(4.8tθ+2sin⁡(4.9tθ))).   (4)
```
Here, the objective function can be described as
```
minf(X)=∑t=0^100(y(t)-yo(t))^2.         (5)
```
Particularly,θ=2π/100 and the estimated parameters [a1,ω1,a2,ω2,a3,ω3] are located in [-6.4, 6.35].
