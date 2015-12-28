clc;
clear;

%% Read Log File
filename = ('/home/amax/Documents/07.LandingData/151210.Landing_Rotors_NUDT/RotorsLanding/01.VisionImage(Middle Success)/DataLog.txt');

fid = fopen(filename, 'r');

C = textscan(fid, '%d64 %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fid);
%% Made Structure
log.SystemTime = C{1};
log.LeftPan= C{2};   log.LeftTilt= C{3};
log.TargetLon = C{4};
log.TargetLat  = C{5};
log.TargetAlt = C{6};


% log.UWBDistance = C{7};
% 
% log.EastX = C{8};
% log.EastY = C{9};
% log.EastZ = C{10};
% 
% log.DGPSEastX = C{11};
% log.DGPSEastY = C{12};
% log.DGPSEastZ = C{13};
% 
% C{14}
% C{15}
% C{16}
% C{17}
% C{18}
% C{19}
log.GroundLon = C{34};
log.GroundLat = C{35};
log.GroundAlt = C{36};



%% GPS Coordinate -> WGS84 UTM Coordinate
lat0 = log.TargetLat;
lon0 = log.TargetLon;
h0 = log.TargetAlt;
% wgs84 = wgs84Ellipsoid('meters');
% [targetX, targetY, targetZ] = geodetic2ecef(wgs84,lat,lon,h);


lat = log.GroundLat;
lon = log.GroundLon;
h = log.GroundAlt;
wgs84 = wgs84Ellipsoid('meters');
% [groundX, groundY, groundZ] = geodetic2ecef(wgs84,lat,lon,h);
SPHEROID = referenceEllipsoid('wgs84', 'm'); % // Reference ellipsoid. You can enter 'km' or 'm'
[xNorth,yEast,zDown] = geodetic2ned(lat,lon,h,lat0,lon0,h0,SPHEROID);

az = azimuth(lat, lon, lat0, lon0, SPHEROID,'degrees');


aimAngle = 155.0;

m_Pan_Left_Calibration = 88.0723596723;
m_Title_Left_Calibration = 1.72642252935;

% plot3(targetX-groundX, targetY-groundY, targetZ-groundZ,'o');
plot3(xNorth, yEast, zDown,'-o');
hold on;
plot3(0,0,0,'ro');
grid on;
axis equal;

