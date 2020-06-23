% Load the data
acrylic_data = xlsread("Acrylic_GR3.xlsx");
aluminum_data = xlsread("Aluminum_GR3.xlsx");
steel_data = xlsread("Steel_GR3.xlsx");
copper_data = xlsread("Copper_GR3.xlsx");

% Find any NaN values
[r_ac c_ac] = find(isnan(acrylic_data));
[r_al c_al] = find(isnan(aluminum_data));
[r_st c_st] = find(isnan(steel_data));
[r_co c_co] = find(isnan(copper_data));

% Acrylic
ac_time = acrylic_data(:,1); % Cycle Elapsed Time
ac_pos = acrylic_data(:,7); % Position in mm
ac_load = acrylic_data(:,8); % Load in kN
ac_ext = acrylic_data(:,9); % Extension from Extensometer in mm

% Aluminum
al_time = aluminum_data(:,1); % Cycle Elapsed Time
al_pos = aluminum_data(:,7); % Position in mm
al_load = aluminum_data(:,8); % Load in kN
al_ext = aluminum_data(:,9); % Extension from Extensometer in mm

% Steel
st_time = steel_data(:,1); % Cycle Elapsed Time
st_pos = steel_data(:,7); % Position in mm
st_load = steel_data(:,8); % Load in kN
st_ext = steel_data(:,9); % Extension from Extensometer in mm

% Copper
cu_time = copper_data(:,1); % Cycle Elapsed Time
cu_pos = copper_data(:,7); % Position in mm
cu_load = copper_data(:,8); % Load in kN
cu_ext = copper_data(:,9); % Extension from Extensometer in mm

% Cross-sectional area calculations, all in square mm (h x w)
ac_area = 13.5 * 3.2;
al_area = 13.5 * 3.2;
st_area = 13.5 * 3.25;
cu_area = 13.5 * 3.2;

% Calculate Normal Tensile Stress 
ac_stress = calcstress(ac_load, ac_area);
al_stress = calcstress(al_load, al_area);
st_stress = calcstress(st_load, st_area);
cu_stress = calcstress(cu_load, cu_area);

% Calculate Strain (length of substance is 80 mm)
ac_strain = calcstrain(ac_ext);
al_strain = calcstrain(al_ext);
st_strain = calcstrain(st_ext);
cu_strain = calcstrain(cu_ext);

% Initial figures to get idea of how data looks
figure
plot(ac_strain, ac_stress, 'k.')
title('Acrylic')
xlabel('Strain')
ylabel('Stress (GPa)')

figure
plot(al_strain, al_stress, 'k.')
title('Aluminum')
xlabel('Strain')
ylabel('Stress (GPa)')

figure
plot(st_strain, st_stress, 'k.')
title('Steel')
xlabel('Strain')
ylabel('Stress (GPa)')

figure
plot(cu_strain, cu_stress, 'k.')
title('Copper')
xlabel('Strain')
ylabel('Stress (GPa)')

% Plot with all four superimposed
figure
plot(ac_strain, ac_stress, 'k.')
title('Stress vs. Strain of All Materials')
xlabel('Strain')
ylabel('Stress (GPa)')
hold on
plot(al_strain, al_stress, 'b.')
hold on
plot(st_strain, st_stress, 'r.')
hold on
plot(cu_strain, cu_stress, 'g.')
legend('Acrylic', 'Aluminum', 'Steel', 'Copper', "Location", "northwest")
axis([0 0.0125 0 0.6])
hold off

% Acrylic Plot with 0.2% Offset
figure
plot(ac_strain, ac_stress, 'k.')
title('Acrylic: Stress vs. Strain')
xlabel('Strain')
ylabel('Stress (GPa)')
axis([0 0.0200 0 0.0500])
% Add trendline (using first 500 data points)
ac_trend = polyfit(ac_strain(1:500), ac_stress(1:500), 1);
ac_xtrend = linspace(0, 0.02, 2000);
ac_ytrend = polyval(ac_trend, ac_xtrend);
hold on
plot(ac_xtrend, ac_ytrend, 'r-.')
hold on
plot(ac_xtrend + 0.002, ac_ytrend, 'b-.')
hold on
plot(linspace(0, 0.01534,5), ones(1,5).*0.0430, 'b:')
legend('Raw Data', 'Linear Best Fit', '0.2% Offset', 'Yield Strength: 0.0430 GPa', "Location", "southeast")
hold off
print_mod('Acrylic', ac_trend(1))
print_eq('Acrylic',ac_trend(1), ac_trend(2))

% Aluminum Plot with 0.2% Offset
figure
plot(al_strain, al_stress, 'k.')
title('Aluminum: Stress vs. Strain')
xlabel('Strain')
ylabel('Stress (GPa)')
axis([0 0.0150 0 0.5700])
% Add trendline (using first 500 data points)
al_trend = polyfit(al_strain(1:500), al_stress(1:500), 1);
al_xtrend = linspace(0, 0.01, 2000);
al_ytrend = polyval(al_trend, al_xtrend);
hold on
plot(al_xtrend, al_ytrend, 'r-.')
hold on
plot(al_xtrend + 0.002, al_ytrend, 'b-.')
hold on
plot(linspace(0, 0.009119,5), ones(1,5).*0.4960, 'b:')
legend('Raw Data', 'Linear Best Fit', '0.2% Offset', 'Yield Strength: 0.4960 GPa', "Location", "southeast")
hold off
print_mod('Aluminum', al_trend(1))
print_eq('Aluminum',al_trend(1), al_trend(2))

% Steel Plot with 0.2% Offset
figure
plot(st_strain, st_stress, 'k.')
title('Steel: Stress vs. Strain')
xlabel('Strain')
ylabel('Stress (GPa)')
axis([0 0.0060 0.02 0.400])
% Add trendline (using first 175 data points)
st_trend = polyfit(st_strain(1:175), st_stress(1:175), 1);
st_xtrend = linspace(0, 0.01, 2000);
st_ytrend = polyval(st_trend, st_xtrend);
hold on
plot(st_xtrend, st_ytrend, 'r-.')
hold on
plot(st_xtrend + 0.002, st_ytrend, 'b-.')
hold on
plot(linspace(0, 0.004294,5), ones(1,5).*0.3326, 'b:')
legend('Raw Data', 'Linear Best Fit', '0.2% Offset', 'Yield Strength: 0.3326 GPa', "Location", "southeast")
hold off
print_mod('Steel', st_trend(1))
print_eq('Steel',st_trend(1), st_trend(2))
 
% Copper Plot with 0.2% Offset
figure
plot(cu_strain, cu_stress, 'k.')
title('Copper: Stress vs. Strain')
xlabel('Strain')
ylabel('Stress (GPa)')
axis([0 0.0080 0.02 0.300])
% Add trendline (using first 100 data points)
cu_trend = polyfit(cu_strain(1:100), cu_stress(1:100), 1);
cu_xtrend = linspace(0, 0.01, 2000);
cu_ytrend = polyval(cu_trend, cu_xtrend);
hold on
plot(cu_xtrend, cu_ytrend, 'r-.')
hold on
plot(cu_xtrend + 0.002, cu_ytrend, 'b-.')
hold on
plot(linspace(0, 0.004608,5), ones(1,5).*0.2624, 'b:')
legend('Raw Data', 'Linear Best Fit', '0.2% Offset', 'Yield Strength: 0.2624 GPa', "Location", "southeast")
hold off
print_mod('Copper', cu_trend(1))
print_eq('Copper',cu_trend(1), cu_trend(2))

function out_stress = calcstress(load, area)
out_stress = load ./ area;
end

function out_strain = calcstrain(ext)
out_strain = ext ./ 80;
end

function print_mod(material, mod)
fprintf('The Modulus of Elasticity for %s is %.4f GPa.\n', material, mod)
end

function print_eq(material, slope, intrcpt)
fprintf('The equation of the linear portion for %s is y = %.3f*x + %.3f.\n', material, slope, intrcpt)
end