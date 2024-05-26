function [J_star, J_star_methane, J_star_comfort, J_h1, J_h1_methane, J_h1_comfort, J_h2, J_h2_methane, ... 
    J_h2_comfort] = DP_RC_plot(gt_star, gt_star_comfort, gt_star_methane, gt_h1, gt_h1_comfort, gt_h1_methane, gt_h2, ...
    gt_h2_comfort, gt_h2_methane, Nrun, T)

%% Plot results

%% TOTAL COST Optimal Policy
% Total cost for each run
J_star=sum(gt_star,1);
J_star_methane=sum(gt_star_methane,1);
J_star_comfort = sum(gt_star_comfort,1);

% Sample mean
mJ1=mean(J_star);
mJ1_methane=mean(J_star_methane);
mJ1_comfort=mean(J_star_comfort);

figure
hold on
histogram(J_star,round(sqrt(Nrun)),'Normalization','pdf','FaceColor','b');
[z_star,edges_star]=histcounts(J_star,round(sqrt(Nrun)),'Normalization','pdf');
plot(mJ1*[1 1], [0 max(z_star)],'k','LineWidth',2);
legend('Histogram',['Mean value = ' num2str(mJ1)]);
xlabel('Total cost');
ylabel('Probability density');
title(['Optimal policy 1 - Total cost distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
grid;

% figure
% hold on
% histogram(J_star_methane,round(sqrt(Nrun)),'Normalization','pdf','FaceColor','b');
% [z_star_methane,edges_star_methane]=histcounts(J_star_methane,round(sqrt(Nrun)),'Normalization','pdf');
% plot(mJ1_methane*[1 1], [0 max(z_star_methane)],'k','LineWidth',2);
% legend('Histogram',['Mean value = ' num2str(mJ1_methane)]);
% xlabel('Total cost (methane) [euro]');
% ylabel('Probability density');
% title(['Optimal policy 1 - Total cost distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
% grid;

% figure
% hold on
% histogram(J_star_comfort,round(sqrt(Nrun)),'Normalization','pdf','FaceColor','b');
% [z_star_comfort,edges_star_comfort]=histcounts(J_star_comfort,round(sqrt(Nrun)),'Normalization','pdf');
% plot(mJ1_comfort*[1 1], [0 max(z_star_comfort)],'k','LineWidth',2);
% legend('Histogram',['Mean value = ' num2str(mJ1_comfort)]);
% xlabel('Total cost (comfort)');
% ylabel('Probability density');
% title(['Optimal policy 1 - Total cost distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
% grid;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TOTAL COST Heuristic policy 1
% Total cost for each run
J_h1=sum(gt_h1,1);
J_h1_methane=sum(gt_h1_methane,1);
J_h1_comfort = sum(gt_h1_comfort,1);

% Sample mean
mJ2=mean(J_h1);
mJ2_methane=mean(J_h1_methane);
mJ2_comfort=mean(J_h1_comfort);

figure
hold on
histogram(J_h1,round(sqrt(Nrun)),'Normalization','pdf','FaceColor','b');
[z_h1,edges_h1]=histcounts(J_h1,round(sqrt(Nrun)),'Normalization','pdf');
plot(mJ2*[1 1], [0 max(z_h1)],'k','LineWidth',2);
legend('Histogram',['Mean value = ' num2str(mJ2)]);
xlabel('Total cost');
ylabel('Probability density');
title(['Heuristic policy 1 - Total cost distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
grid;
% 
% figure
% hold on
% histogram(J_h1_methane,round(sqrt(Nrun)),'Normalization','pdf','FaceColor','b');
% [z_h1_methane,edges_h1_methane]=histcounts(J_h1_methane,round(sqrt(Nrun)),'Normalization','pdf');
% plot(mJ2_methane*[1 1], [0 max(z_h1_methane)],'k','LineWidth',2);
% legend('Histogram',['Mean value = ' num2str(mJ2_methane)]);
% xlabel('Total cost (methane) [euro]');
% ylabel('Probability density');
% title(['Heuristic policy 1 - Total cost distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
% grid;
% 
% figure
% hold on
% histogram(J_h1_comfort,round(sqrt(Nrun)),'Normalization','pdf','FaceColor','b');
% [z_h1_comfort,edges_h1_comfort]=histcounts(J_h1_comfort,round(sqrt(Nrun)),'Normalization','pdf');
% plot(mJ2_comfort*[1 1], [0 max(z_h1_comfort)],'k','LineWidth',2);
% legend('Histogram',['Mean value = ' num2str(mJ2_comfort)]);
% xlabel('Total cost (comfort)');
% ylabel('Probability density');
% title(['Heuristic policy 1 - Total cost distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
% grid;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TOTAL COST Heuristic policy 2
% Total cost for each run
J_h2=sum(gt_h2,1);
J_h2_methane=sum(gt_h2_methane,1);
J_h2_comfort = sum(gt_h2_comfort,1);

% Sample mean
mJ3=mean(J_h2);
mJ3_methane=mean(J_h2_methane);
mJ3_comfort=mean(J_h2_comfort);

figure
hold on
histogram(J_h2,round(sqrt(Nrun)),'Normalization','pdf','FaceColor','b');
[z_h2,edges_h2]=histcounts(J_h2,round(sqrt(Nrun)),'Normalization','pdf');
plot(mJ3*[1 1], [0 max(z_h2)],'k','LineWidth',2);
legend('Histogram',['Mean value = ' num2str(mJ3)]);
xlabel('Total cost');
ylabel('Probability density');
title(['Heuristic policy 2 - Total cost distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
grid;
% 
% figure
% hold on
% histogram(J_h2_methane,round(sqrt(Nrun)),'Normalization','pdf','FaceColor','b');
% [z_h2_methane,edges_h2_methane]=histcounts(J_h2_methane,round(sqrt(Nrun)),'Normalization','pdf');
% plot(mJ3_methane*[1 1], [0 max(z_h2_methane)],'k','LineWidth',2);
% legend('Histogram',['Mean value = ' num2str(mJ3_methane)]);
% xlabel('Total cost (methane) [euro]');
% ylabel('Probability density');
% title(['Heuristic policy 2 - Total cost distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
% grid;
% 
% figure
% hold on
% histogram(J_h2_comfort,round(sqrt(Nrun)),'Normalization','pdf','FaceColor','b');
% [z_h2_comfort,edges_h2_comfort]=histcounts(J_h2_comfort,round(sqrt(Nrun)),'Normalization','pdf');
% plot(mJ3_comfort*[1 1], [0 max(z_h2_comfort)],'k','LineWidth',2);
% legend('Histogram',['Mean value = ' num2str(mJ3_comfort)]);
% xlabel('Total cost (comfort)');
% ylabel('Probability density');
% title(['Heuristic policy 2 - Total cost distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
% grid;


%% Comparison 

figure
hold on

% Compute the center of the bins
bins_star=edges_star(1:end-1)+diff(edges_star);
bins_h1=edges_h1(1:end-1)+diff(edges_h1);
bins_h2=edges_h2(1:end-1)+diff(edges_h2);

bar(bins_h1,z_h1,'b');
bar(bins_h2,z_h2,'g');
bar(bins_star,z_star,'r');
legend('Heuristic 1','Heuristic 2','Optimal')
xlabel('Total cost');
ylabel('Probability density');
title(['Total cost distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
grid;

figure
hold on
bar3(bins_star,[zeros(size(z_star)); zeros(size(z_star)); z_star]','r');
bar3(bins_h2,[zeros(size(z_h2)); z_h2; zeros(size(z_h2))]','g');
bar3(bins_h1,[z_h1; zeros(size(z_h1)); zeros(size(z_h1))]','b');
xlabel('Policy');
ylabel('Total cost');
zlabel('Probability density');
title(['Total cost distribution: heuristic 1 (blue), heuristic 2 (green) and optimal (red)']);
grid;
view([105 30]);

figure
hold on
[F_star, xi_star] = ecdf(J_star);
[F_h1, xi_h1] = ecdf(J_h1);
[F_h2, xi_h2] = ecdf(J_h2);
plot(xi_h1,F_h1,'b','LineWidth',2)
plot(xi_h2,F_h2,'g','LineWidth',2)
plot(xi_star,F_star,'r','LineWidth',2)
legend('Heuristic 1','Heuristic 2','Optimal','Location','SouthEast')
xlabel('Total cost');
ylabel('Probability distribution');
title(['Empirical CDF from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
grid;