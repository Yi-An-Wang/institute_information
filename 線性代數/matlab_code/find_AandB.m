function [A,ATA,B,BTB]=find_AandB()
load("U.S._industrial_Sales_and_Profit.mat");
x_bar=mean(M);
A=M-repmat(x_bar,10,1);
SSD=(sum(A.^2)./(10-1)).^(1/2);
B=A./SSD;
Covariance_Matrix=(1/(10-1))*(A')*A;
ATA=Covariance_Matrix*(10-1);
Correlation_Matrix=(1/(10-1))*(B')*B;
BTB=Correlation_Matrix*(10-1);