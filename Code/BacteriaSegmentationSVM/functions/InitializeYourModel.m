function [SVMModel,model_name]  = InitializeYourModel(red_name,green_name,blue_name)
%
% This function builds a 2 classes SVM model based on selected object's
% pixels and background pixels. The user should manually mark areas of the image which contain 
% pixels that belong to the object to segment (e.g. bacteria, toxoplasma)
% and areas of the image which contain background, i.e. everything which is not the object.
%
% HINT: the more pixels of the object are selected the more robust the model
%       will be.
% 
% 
% Usage:          [SVMModel,model_name]  = InitializeYourModel(red_name,green_name,blue_name)
%
% Input: red_name    full path to the image which contains red color of the data.  
%                    e.g. red_name = [~/Data/20180503_Antibiotic02/1/section_004_01.tif'];
%        green_name  full path to the image which contains green color of the data.  
%                    e.g. green_name = [~/Data/20180503_Antibiotic02/2/section_004_01.tif'];
%        blue_name   full path to the image which contains blue color of the data.  
%                    e.g. blue_name = [~/Data/20180503_Antibiotic02/3/section_004_01.tif'];
%
%                 
%
% Output: SVMModel   SVM model that is used to segment objects with a
%                    specific color. It can be a plane or paraboloid in RGB space
%                    that separates the color of the selected object from
%                    the background color.
%       model_name   name of the SVM model which can be given to
%                    AllBacteriaSegmentation function.
%
% See also: guiModelBuild, AllBacteriaSegmentation, SVMsegmentation
%
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
% Author: Chicherova Natalia, 2019
%         University of Basel  

% 2D image median filter was added; by Jiagui Li 2019
% Add re-usage of selected background and bacteria regions 
%By Jiagui Li Basel 2020

% load slices
RED1 = imread(red_name); 
GREEN1 = imread(green_name); 
BLUE1 = imread(blue_name); 

RED = medfilt2(RED1); 
GREEN = medfilt2(GREEN1); 
BLUE = medfilt2(BLUE1); 

% dialog for check the exist data.
    Impr = 1
    prompt = 'Do you already have a Model but need to be improved? Please copy them into the present folder.';
    choice = input(prompt,'s');
    switch choice
        case {'Yes','yes','y'}
            Impr = 0;
        case {'No','no','n'}
            Impr = 1;
    end

if Impr    
 % build a new model
[SVMModel,model_name]  = guiModelBuild(RED, GREEN, BLUE);
end

% Imrpove a exist model

[SVMModel,model_name]  = guiModelBuild(RED, GREEN, BLUE); 
    
    
