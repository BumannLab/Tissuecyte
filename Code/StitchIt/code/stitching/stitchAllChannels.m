function stitchAllChannels(chansToStitch,stitchedSize,illumChans,combChans)
% Stitch all channels within the current sample directory
%
% function stitchAllChannels(chansToStitch,stitchedSize,combChans,illumChans)
%
%
% Purpose
% Stitches all data from all channels within the current sample directory. 
% Before stitching, this function performs all required pre-processing and builds 
% new illumination images if needed. This is a convenience function. To stitch 
% particular channels or sections see the stitchSection function. 
%
%
% Inputs
% chansToStitch - which channels to stitch. By default it's all available channels. 
% stitchedSize - what size to make the final image. 100 is full size and is 
%              the default. 50 is half size. stitchedSize may be a vector with a
%              range of different sizes to produced. e.g. [25,50,100]
% illumChans - On which channels to calculate the illumination correction if this hasn't 
%             already been done. By default it's the same a the chansToStich. 
% combChans - On which channels we will calculate the comb correction if this hasn't already been done. 
%             by default this is set to zero and no comb correction is done.
%
%
% Examples
% * stitch all available channels at full resolution.
% >> stitchAllChannels
%
% * stitch all available channels at 10% of their original size.
% >> stitchAllChannels([],10)
%
% * stitch only chans 1 and 3
% >> stitchAllChannels([],[],[1,3])
%
%
% Rob Campbell - Basel 2017
%
%
% Also see: stitchSection, generateTileIndex, preProcessTiles, collateAverageImages
%
% Lines to check for whether process before or not where removed
% Jiagui - 2020


%Bail out if there is no raw data directory in the current directory
config=readStitchItINI;
if ~exist(config.subdir.rawDataDir,'dir')
    fprintf('%s can not find raw data directory "%s". Quitting\n', ... 
        mfilename, config.subdir.rawDataDir)
    return
end

%Bail out if we can't determin the acquisition system name
if determineStitchItSystemType<1
    %error message generated by determineStitchItSystemType
    return
end


% Check input arguments
if nargin<1
    chansToStitch=[];
end

if nargin<2 || isempty(stitchedSize)
    stitchedSize=100;
end

if nargin<3 || isempty(illumChans)
    illumChans=chansToStitch;
end

if nargin<4 || isempty(combChans)
    combChans=0;
end


%See which channels we have avilable to stitch if the user didn't define this
if isempty(chansToStitch)
    chansToStitch=channelsAvailableForStitching;
end



%Loop through and stitch all requested channels
generateTileIndex; %Ensure the tile index is present


for thisChan=1:length(chansToStitch)

    stitchSection([],chansToStitch(thisChan),'stitchedSize',stitchedSize) %Stitch all sections from this channels
end
