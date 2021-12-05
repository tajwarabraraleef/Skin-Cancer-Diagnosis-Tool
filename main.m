function varargout = main(varargin)
%Defining the global variables to be used by all the functions in the GUI
global temp; 
global image; 
global edit;
global pos;
global bright;
global idx;
global flag;
global flag2;
global flag4;
global contrastimg;
global res;
global patientidx;

temp = {};


% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 10-Jan-2018 17:04:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

%For displaying continous output from the webcam as a preview before
%capturing image
handles.video = videoinput('winvideo', 1);
set(handles.video,'TimerPeriod', 0.1, ...
'TimerFcn',['if(~isempty(gco)),'...
'handles=guidata(gcf);'... % Update handles
'image(flip(getsnapshot(handles.video),2));'... % Get picture using GETSNAPSHOT and put it into axes using IMAGE
'set(handles.axes2,''ytick'',[],''xtick'',[]),'... % Remove tickmarks and labels that are inserted when using IMAGE
'hold on,'...
'rectangle(''Position'',[350,200,570,320],''EdgeColor'',''r'',''LineWidth'',3),'... %Plotting the red region of interest boundary
'hold off,'...
'else '...
'delete(imaqfind);'... % Clean up - delete any image acquisition objects
'end']);
triggerconfig(handles.video,'manual');
handles.video.FramesPerTrigger = Inf; % Capture frames until we manually stop it


% Update handles structure
%Turning off all the GUI buttons and axes that are not from the homepage
guidata(hObject, handles);
set(handles.axes2,'ytick',[],'xtick',[])
set(handles.axes3,'Visible','off')
set(handles.edit1,'Visible','off')
set(handles.edit2,'Visible','off')
set(handles.edit4,'Visible','off')
set(handles.edit5,'Visible','off')
set(handles.edit6,'Visible','off')
set(handles.edit7,'Visible','off')
set(handles.next,'Visible','off')
set(handles.text2,'Visible','off')
set(handles.text3,'Visible','off')
set(handles.text5,'Visible','off')
set(handles.text6,'Visible','off') 
set(handles.text7,'Visible','off')
set(handles.text8,'Visible','off')
set(handles.text9,'Visible','off')
set(handles.edit9,'Visible','off')
set(handles.finish,'Visible','off')
set(handles.sendemail,'Visible','off')
set(handles.takepicture,'Visible','off')
set(handles.camera,'Visible','off')
set(handles.loadpic,'Visible','off')
set(handles.results,'Visible','off')
set(handles.back,'Visible','off')
set(handles.back,'Visible','off')
set(handles.back2,'Visible','off')
set(handles.back3,'Visible','off')
set(handles.back4,'Visible','off')
set(handles.back5,'Visible','off')
set(handles.selectarea,'Visible','off')
set(handles.crop,'Visible','off')
set(handles.brightness,'Visible','off')
set(handles.slider1,'Visible','off')
set(handles.contrast,'Visible','off')
set(handles.slider2,'Visible','off')
set(handles.next2,'Visible','off')
set(handles.showresults,'Visible','off'); 
set(handles.back6,'Visible','off'); 
set(handles.finish2,'Visible','off'); 
set(handles.finalresults,'Visible','off'); 
set(handles.finalresults2,'Visible','off'); 
set(handles.finish3,'Visible','off'); 

%setting up the background 
I = imread('home.JPG');
axes(handles.axes2);
imshow(I);  
uiwait(handles.figure1);
 
% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.output = hObject;
varargout{1} = handles.output;

% --- Executes on button press in Sign In.
function signin_Callback(hObject, eventdata, handles)
% hObject    handle to signin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Initializing the starting parameters
handles.bright =0;
handles.flag=1;
handles.flag2=1;

%Opening login dialog that outputs the username and password inputted
[user, pass] = logindlg;
%Loading the saved information details of the patients
patients = load('patients.mat');
patients = patients.patients;

%looking for the correct match of user name and password
idx = strfind(patients(:,2),user);
match=0;
for i=1:length(idx)
    if idx{i}==1
        index = i;
        match = strfind(patients{index,3},pass);
    end
end

%Showing warning dialog in case of incorrect input
if( match~=1)
h = errordlg('Incorrect password or user name');
else
handles.patientidx = index; %store the index of the patient for later retrival of the information

%turn off hompage
set(handles.signin,'Visible','off')
set(handles.newuser,'Visible','off')
set(handles.forgotpass,'Visible','off')
cla(handles.axes2)
set(handles.axes2,'Visible','off')

%turn on image aquizition page
set(handles.camera,'Visible','on')
set(handles.loadpic,'Visible','on')
set(handles.results,'Visible','on')
set(handles.back3,'Visible','on')

%update the background
cla(handles.axes2)
set(handles.axes2,'Visible','on')
I = imread('input.JPG');
axes(handles.axes2);
imshow(I); 

guidata(hObject, handles);
end
% --- Executes on button press in New User.
function newuser_Callback(hObject, eventdata, handles)
% hObject    handle to newuser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
%turn off hompage
set(handles.signin,'Visible','off')
set(handles.newuser,'Visible','off')
set(handles.forgotpass,'Visible','off')
cla(handles.axes2)

%turn on sign up form
set(handles.axes2,'Visible','on')
I = imread('signup.jpg');
axes(handles.axes2);
imshow(I); 

set(handles.edit1,'Visible','on')
set(handles.edit2,'Visible','on')
set(handles.edit4,'Visible','on')
set(handles.edit5,'Visible','on')
set(handles.next,'Visible','on')
set(handles.text2,'Visible','on')
set(handles.text3,'Visible','on')
set(handles.text5,'Visible','on')
set(handles.text6,'Visible','on') 
set(handles.back,'Visible','on')
set(handles.text7,'Visible','off')
set(handles.text8,'Visible','off')
set(handles.edit6,'Visible','off')
set(handles.edit7,'Visible','off')

guidata(hObject, handles); 

% --- Executes on button press in forgotpass.
function forgotpass_Callback(hObject, eventdata, handles)
% hObject    handle to forgotpass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Turn off home page
set(handles.signin,'Visible','off')
set(handles.newuser,'Visible','off')
set(handles.forgotpass,'Visible','off')
cla(handles.axes2)
set(handles.axes2,'Visible','off')

%Turn on page for forgot password
set(handles.edit9,'Visible','on')
set(handles.text9,'Visible','on')
set(handles.sendemail,'Visible','on')
set(handles.back,'Visible','on')
%set up background
cla(handles.axes2)
set(handles.axes2,'Visible','on')
I = imread('signup.jpg');
axes(handles.axes2);
imshow(I); 


guidata(hObject, handles); 

% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%extract the given information in a temporary variable
handles.temp{1} = get(handles.edit1,'String'); %edit1 being Tag of ur edit box
handles.temp{2} = get(handles.edit2,'String');
handles.temp{3} = get(handles.edit4,'String');
handles.temp{4} = get(handles.edit5,'String');

%Checking if any field is left out
if (isempty(handles.temp{1})||isempty(handles.temp{2})||isempty(handles.temp{3})||isempty(handles.temp{4}))
h = errordlg('Please fill all the information'); 
else
    
% turn off the current page 
set(handles.edit1,'Visible','off')
set(handles.edit2,'Visible','off')
set(handles.edit4,'Visible','off')
set(handles.edit5,'Visible','off')
set(handles.text2,'Visible','off')
set(handles.text3,'Visible','off')
set(handles.text5,'Visible','off')
set(handles.text6,'Visible','off') 
set(handles.next,'Visible','off');
set(handles.back,'Visible','off')

%set neww background
cla(handles.axes2)
set(handles.axes2,'Visible','on')
I = imread('signup.jpg');
axes(handles.axes2);
imshow(I); 


%Turn on page for doctors information
set(handles.back2,'Visible','on')
set(handles.text7,'Visible','on')
set(handles.text8,'Visible','on')
set(handles.edit6,'Visible','on')
set(handles.edit7,'Visible','on')
set(handles.finish,'Visible','on');
guidata(hObject, handles);
end


% --- Executes on button press in finish.
function finish_Callback(hObject, eventdata, handles)
% hObject    handle to finish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%store information extracted from the fields about doctor
handles.temp{5} = get(handles.edit6,'String'); %edit1 being Tag of ur edit box
handles.temp{6} = get(handles.edit7,'String');

%check if any field is empty
if (isempty(handles.temp{5})||isempty(handles.temp{6}))
   h = errordlg('Please fill all the information');
else
    
%Turn off the current screen
set(handles.text7,'Visible','off')
set(handles.text8,'Visible','off')
set(handles.edit6,'Visible','off')
set(handles.edit7,'Visible','off')
set(handles.finish,'Visible','off');
set(handles.back2,'Visible','off');

%Turn on the home screen
set(handles.signin,'Visible','on')
set(handles.newuser,'Visible','on')
set(handles.forgotpass,'Visible','on')
set(handles.axes2,'ytick',[],'xtick',[])
set(handles.axes2,'Visible','on')
I = imread('home.JPG');
axes(handles.axes2);
imshow(I); 

%turn on dialog of successfull sign up  
h = msgbox('Sign Up succesfull, please log in to continue');
guidata(hObject, handles);

%update information in the patients files and overwrite it 
patients = load('patients.mat');
patients = patients.patients;
patients = [patients; handles.temp];
save('patients','patients');

%login to gmail account created for this project and pinging the gmail
%server
email_settings;
%Sending confirmation of account creation to the patient
str = "Dear " + string(get(handles.edit1,'String')) + ","+ newline + newline + "Your account has been succesfully created. Please save the following details: " + newline + newline + "User ID: " + string(get(handles.edit2,'String'))+ newline + newline + "Password: " + string(get(handles.edit4,'String')) + newline + newline + "Thank you";
sendmail(get(handles.edit5,'String'),'Account Created',str) ;
guidata(hObject, handles);
end
 
 % --- Executes on button press in sendemail.
function sendemail_Callback(hObject, eventdata, handles)
% hObject    handle to sendemail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%loading the saved accounts and looking for the email that is inputted
patients = load('patients.mat');
patients = patients.patients;
idx = strfind(patients(:,4),get(handles.edit9,'String'));
index=0;
for i=1:length(idx)
    if idx{i}==1
        index = i;
    end
end
 
%If no such email adress is registered then an error message is shown
if( index==0)
h = errordlg('No such email registered');
else
    %otherwise if its a mathc, the corresponding password is extracted
    email =patients(index,4);
    pass = patients(index,3);
    email_settings;
    
    %Next email is sent with the password and email address
    str = "Dear " + string(patients(index,1)) + ","+ newline + newline + "Your password is " + "'"+string(pass)+"'" + newline + newline + "Thank you";
    sendmail(email,'Recovery of Password',str) ;
    set(handles.edit9,'Visible','off')
 set(handles.text9,'Visible','off')
 set(handles.sendemail,'Visible','off')  
 set(handles.back,'Visible','off')  
 
 %turn on home page and background image
 set(handles.signin,'Visible','on')
 set(handles.newuser,'Visible','on')
 set(handles.forgotpass,'Visible','on')
 set(handles.axes2,'Visible','on')
 set(handles.axes2,'ytick',[],'xtick',[])
 set(handles.back,'Visible','off')
 set(handles.back2,'Visible','off')
 I = imread('home.JPG');
 axes(handles.axes2);
 imshow(I); 
 %dialog for showing if the password was sent successfully
 h = msgbox('Recovery password sent, please log in to continue');
 guidata(hObject, handles);
end


% --- Executes on button press in camera.
function camera_Callback(hObject, eventdata, handles)
% hObject    handle to camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%starts streaming video from the webcam with the red bounding box
axes(handles.axes2)
start(handles.video)
set(handles.axes2,'ytick',[],'xtick',[])
%turn on take picture and back button
set(handles.takepicture,'Visible','on')
set(handles.back4,'Visible','on')

%Turn off image aquizition page
set(handles.camera,'Visible','off')
set(handles.loadpic,'Visible','off')
set(handles.results,'Visible','off')
set(handles.back3,'Visible','off')   

guidata(hObject, handles);
% --- Executes on button press in takepicture.
function takepicture_Callback(hObject, eventdata, handles)
% hObject    handle to takepicture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%store the current snapshot from the webcam in a temporary variable and
%then stop streaming the webcam
img =flip(getsnapshot(handles.video),2);
stop(handles.video);
%crop image around the red bounding box
handles.image = imcrop(img,[350,200,550,320]);
%turn off current page
set(handles.takepicture,'Visible','off');
cla(handles.axes2);
set(handles.axes2,'Visible','off');
set(handles.back4,'Visible','off');

%Turn on preprocessing screen 
set(handles.back5,'Visible','on')
set(handles.selectarea,'Visible','on')
set(handles.crop,'Visible','on')
set(handles.brightness,'Visible','on')
set(handles.slider1,'Visible','on')
set(handles.contrast,'Visible','on')
set(handles.slider2,'Visible','on')
set(handles.next2,'Visible','on')

%Turn on background
cla(handles.axes2)
set(handles.axes2,'Visible','on')
I = imread('signup2.jpg');
axes(handles.axes2);
imshow(I); 

%Display the cropped images in the new pre processing page
set(handles.axes3,'ytick',[],'xtick',[])
set(handles.axes3,'Visible','on'); 
axes(handles.axes3);
imshow(handles.image);  
 
guidata(hObject, handles);
 
% --- Executes on button press in loadpic.
function loadpic_Callback(hObject, eventdata, handles)
% hObject    handle to loadpic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%the filename and path of the file chosen in recorded to temporary variable
[filename,pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Load image',...
          'E:\Girona\E-Health\Testing\0');
%read the image from the path and turn off the current page
normal= imread([pathname filename]);   
handles.image = uint8(normal);
set(handles.camera,'Visible','off')
set(handles.loadpic,'Visible','off')
set(handles.results,'Visible','off')
cla(handles.axes2)
set(handles.axes2,'Visible','off')
set(handles.back3,'Visible','off')

%turn on pre-processing page
set(handles.back5,'Visible','on')
set(handles.selectarea,'Visible','on')
set(handles.crop,'Visible','on')
set(handles.brightness,'Visible','on')
set(handles.slider1,'Visible','on')
set(handles.contrast,'Visible','on')
set(handles.slider2,'Visible','on')
set(handles.next2,'Visible','on')

%Set background
cla(handles.axes2)
set(handles.axes2,'Visible','on')
I = imread('signup2.jpg');
axes(handles.axes2);
imshow(I); 
%show the loaded image
set(handles.axes3,'ytick',[],'xtick',[])
set(handles.axes3,'Visible','on'); 
axes(handles.axes3);
imshow(handles.image);  

guidata(hObject, handles);

% --- Executes on button press in results.
function results_Callback(hObject, eventdata, handles)
% hObject    handle to results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%check if any previous image from image aquizition is available for the respected patient are saved
%if exists then load the image and turn off current screen
if exist([num2str(handles.patientidx) '.png'])==2 
set(handles.camera,'Visible','off')
set(handles.loadpic,'Visible','off')
set(handles.results,'Visible','off')
cla(handles.axes2)
set(handles.axes2,'Visible','off')
set(handles.back3,'Visible','off')
handles.image=imread([num2str(handles.patientidx) '.png']);

%turn on image pre processing page
set(handles.back5,'Visible','on')
set(handles.selectarea,'Visible','on')
set(handles.crop,'Visible','on')
set(handles.brightness,'Visible','on')
set(handles.slider1,'Visible','on')
set(handles.contrast,'Visible','on')
set(handles.slider2,'Visible','on')
set(handles.next2,'Visible','on')

%show background and loaded image
cla(handles.axes2)
set(handles.axes2,'Visible','on')
I = imread('signup2.jpg');
axes(handles.axes2);
imshow(I); 
set(handles.axes3,'ytick',[],'xtick',[])
set(handles.axes3,'Visible','on'); 
axes(handles.axes3);
imshow(handles.image);  
else
%showing warning if no previous scans exits    
h = errordlg('No previous diagnosis exists');
end

guidata(hObject, handles);

% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
%turn off current screen
set(handles.axes3,'Visible','off')
set(handles.edit1,'Visible','off')
set(handles.edit2,'Visible','off')
set(handles.edit4,'Visible','off')
set(handles.edit5,'Visible','off')
set(handles.edit6,'Visible','off')
set(handles.edit7,'Visible','off')
set(handles.next,'Visible','off')
set(handles.text2,'Visible','off')
set(handles.text3,'Visible','off')
set(handles.text5,'Visible','off')
set(handles.text6,'Visible','off') 
set(handles.text7,'Visible','off')
set(handles.text8,'Visible','off')
set(handles.text9,'Visible','off')
set(handles.edit9,'Visible','off')
set(handles.finish,'Visible','off')
set(handles.sendemail,'Visible','off')
set(handles.takepicture,'Visible','off')
set(handles.camera,'Visible','off')
set(handles.loadpic,'Visible','off')
set(handles.results,'Visible','off')
set(handles.back,'Visible','off')
set(handles.back2,'Visible','off')

%turn on homepage
set(handles.signin,'Visible','on')
set(handles.newuser,'Visible','on')
set(handles.forgotpass,'Visible','on')
set(handles.axes2,'ytick',[],'xtick',[])
set(handles.axes2,'Visible','on')

I = imread('home.JPG');
axes(handles.axes2);
imshow(I); 

guidata(hObject, handles);

 function back3_Callback(hObject, eventdata, handles)
%turn off current screen 
set(handles.axes3,'Visible','off')
set(handles.edit1,'Visible','off')
set(handles.edit2,'Visible','off')
set(handles.edit4,'Visible','off')
set(handles.edit5,'Visible','off')
set(handles.edit6,'Visible','off')
set(handles.edit7,'Visible','off')
set(handles.next,'Visible','off')
set(handles.text2,'Visible','off')
set(handles.text3,'Visible','off')
set(handles.text5,'Visible','off')
set(handles.text6,'Visible','off') 
set(handles.text7,'Visible','off')
set(handles.text8,'Visible','off')
set(handles.text9,'Visible','off')
set(handles.edit9,'Visible','off')
set(handles.finish,'Visible','off')
set(handles.sendemail,'Visible','off')
set(handles.takepicture,'Visible','off')
set(handles.camera,'Visible','off')
set(handles.loadpic,'Visible','off')
set(handles.results,'Visible','off')
set(handles.back,'Visible','off')
set(handles.back2,'Visible','off')
set(handles.back3,'Visible','off')

%turn on homepage
set(handles.signin,'Visible','on')
set(handles.newuser,'Visible','on')
set(handles.forgotpass,'Visible','on')
set(handles.axes2,'ytick',[],'xtick',[])
set(handles.axes2,'Visible','on')

I = imread('home.JPG');
axes(handles.axes2);
imshow(I); 

guidata(hObject, handles);

% --- Executes on button press in back2.
function back2_Callback(hObject, eventdata, handles)
% hObject    handle to back2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%turn off current screen
set(handles.axes3,'Visible','off')
set(handles.edit1,'Visible','off')
set(handles.edit2,'Visible','off')
set(handles.edit4,'Visible','off')
set(handles.edit5,'Visible','off')
set(handles.edit6,'Visible','off')
set(handles.edit7,'Visible','off')
set(handles.next,'Visible','off')
set(handles.text2,'Visible','off')
set(handles.text3,'Visible','off')
set(handles.text5,'Visible','off')
set(handles.text6,'Visible','off') 
set(handles.text7,'Visible','off')
set(handles.text8,'Visible','off')
set(handles.text9,'Visible','off')
set(handles.edit9,'Visible','off')
set(handles.finish,'Visible','off')
set(handles.sendemail,'Visible','off')
set(handles.takepicture,'Visible','off')
set(handles.camera,'Visible','off')
set(handles.loadpic,'Visible','off')
set(handles.results,'Visible','off')
set(handles.back,'Visible','off')
set(handles.back2,'Visible','off')

%turn on previous sign up page
set(handles.edit1,'Visible','on')
set(handles.edit2,'Visible','on')
set(handles.edit4,'Visible','on')
set(handles.edit5,'Visible','on')
set(handles.next,'Visible','on')
set(handles.text2,'Visible','on')
set(handles.text3,'Visible','on')
set(handles.text5,'Visible','on')
set(handles.text6,'Visible','on') 
set(handles.back,'Visible','on')
 
guidata(hObject, handles);

% 
% --- Executes on button press in back4.
function back4_Callback(hObject, eventdata, handles)
% hObject    handle to back4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% stop video streaming and current page
stop(handles.video);
set(handles.takepicture,'Visible','off');
set(handles.back4,'Visible','off'); 
cla(handles.axes2)
set(handles.axes2,'Visible','on')
% turn on the background 
I = imread('input.JPG');
axes(handles.axes2);
imshow(I); 
cla(handles.axes3);
set(handles.axes3,'Visible','off');

%turn on image aquizition page
set(handles.camera,'Visible','on')
set(handles.loadpic,'Visible','on')
set(handles.results,'Visible','on')
set(handles.back3,'Visible','on')

guidata(hObject, handles);

% --- Executes on button press in selectarea.
function selectarea_Callback(hObject, eventdata, handles)
% hObject    handle to selectarea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Extract the positions from the drawn rectangle
h= imrect();
handles.pos = getPosition(h);

%set a flag for other functions to know that cropping was applied
handles.flag4 = 0;

guidata(hObject, handles);

% --- Executes on button press in crop.
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)getPosit

%check if any region of area is selected if not show error
if (handles.flag4 ==1)
       h = errordlg('Please select area first');
else    
%check if contrast enhncement is done, if so update image    
if(handles.flag2==0)
handles.image = handles.contrastimg;
end
%crop based on the selected positions from the select area button
handles.image = imcrop(handles.image,handles.pos);
cla(handles.axes3);
axes(handles.axes3);
imshow(handles.image); 
end

%Reset flags so further cropping and image processing is allowed
handles.flag = 1;
handles.flag2 =1;
handles.bright = 0;


guidata(hObject, handles);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%if contrast enhancement was done, update current image
if(handles.flag2==0)
handles.image = handles.contrastimg;
end
%read previous value of brightness increased
bright1 = handles.bright;

handles.bright = get(hObject,'Value');

%if brightness was changed previously, reset the image to original state
if(handles.flag==0)
handles.image(handles.idx) =handles.image(handles.idx)-bright1;
end
%increase the brightness globally in a temp variable
tempo = uint16(handles.image+handles.bright);
%find index of any pixel values that are going out of bound
handles.idx = ( tempo>0 & tempo <255);

%only enhance the intensities in the range
handles.image(handles.idx) =handles.image(handles.idx)+handles.bright;
%update flag
handles.flag=0;
handles.flag2=1;

%show new enhance image
cla(handles.axes3);
axes(handles.axes3);
imshow(handles.image); 

guidata(hObject, handles);  


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%adjust contrast based on values from the slider 
handles.contrastimg = imadjust(handles.image,[0 0 0; 1-(get(hObject,'Value')) 1-(get(hObject,'Value')) 1-(get(hObject,'Value'))]);
handles.flag2 =0;
cla(handles.axes3);
axes(handles.axes3);
%update contrast enhanced image
imshow(handles.contrastimg,[]); 

guidata(hObject, handles);  

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in back5.
function back5_Callback(hObject, eventdata, handles)
% hObject    handle to back5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%turn off current screen
cla(handles.axes3);
set(handles.axes3,'Visible','off');
set(handles.selectarea,'Visible','off');
set(handles.crop,'Visible','off');
set(handles.brightness,'Visible','off');
set(handles.slider1,'Visible','off');
set(handles.contrast,'Visible','off');
set(handles.slider2,'Visible','off');
set(handles.next2,'Visible','off');
set(handles.back5,'Visible','off');

cla(handles.axes2)
set(handles.axes2,'Visible','on')
I = imread('input.JPG');
axes(handles.axes2);
imshow(I); 

%turn on image aquisition screen
set(handles.camera,'Visible','on')
set(handles.loadpic,'Visible','on')
set(handles.results,'Visible','on')
set(handles.back3,'Visible','on')

%reset all the flags and temporary variables
clear handles.image
clear handles.contrastimg
clear handles.idx
handles.bright =0;
handles.flag=1;
handles.flag2=1;

guidata(hObject, handles);

% --- Executes on button press in next2.
function next2_Callback(hObject, eventdata, handles)
% hObject    handle to next2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Update image if contrast enhancement was done
if(handles.flag2==0)
handles.image = handles.contrastimg;
end

patients = load('patients.mat');
patients = patients.patients;
%write image so it can be called again using Previous results
imwrite(handles.image,[num2str(handles.patientidx) '.png'])

%turn off current screen
set(handles.back5,'Visible','off')
set(handles.selectarea,'Visible','off')
set(handles.crop,'Visible','off')
set(handles.brightness,'Visible','off')
set(handles.slider1,'Visible','off')
set(handles.contrast,'Visible','off')
set(handles.slider2,'Visible','off')
set(handles.next2,'Visible','off')
set(handles.axes3,'Visible','off'); 
cla(handles.axes3);

%turn on result screen
cla(handles.axes2)
set(handles.axes2,'Visible','on')
set(handles.axes2,'ytick',[],'xtick',[])
cla(handles.axes2)
set(handles.axes2,'Visible','on')
I = imread('results.jpg');
axes(handles.axes2);
imshow(I); 

%classify image by using pretrainned alexnet model and assignes the predicted class 
out = classify_net(handles.image);
if(out==categorical(0))
handles.res = ('Benign')
end
if(out==categorical(1))
handles.res = ('Melanoma');
end
if(out==categorical(2))
handles.res = ('Seborrheic')
end

email_settings;
%email the results to the corresponding patients doctor
str = "Dear " + string(patients(handles.patientidx,5)) + ", "+ newline + newline + "Your patient, "+ string(patients(handles.patientidx,1))  +", has just taken a Skin Diagnosis test. The results and the image taken are attached below." + newline + newline + "Result: " + handles.res + newline + newline + "Thank you" + newline + 'Skin Cancer Diagnostic Tool';


sendmail(string(patients(handles.patientidx,6)),'Diagnosis of Patient',str,[num2str(handles.patientidx) '.png']) ;



set(handles.finalresults,'Visible','off'); 
set(handles.finalresults2,'Visible','off'); 
%turn on result screen
set(handles.showresults,'Visible','on'); 
set(handles.back6,'Visible','on'); 
set(handles.finish2,'Visible','on'); 


guidata(hObject, handles);




% --- Executes on button press in showresults.
function showresults_Callback(hObject, eventdata, handles)
% hObject    handle to showresults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%turn off current screen
set(handles.showresults,'Visible','off'); 
set(handles.back6,'Visible','off'); 
set(handles.finish2,'Visible','off'); 

%turn on final result screen
set(handles.finish3,'Visible','on'); 
set(handles.finalresults,'Visible','on'); 
set(handles.finalresults, 'String', ['Type: ' handles.res]);

guidata(hObject, handles);

 
cla(handles.axes2)
set(handles.axes2,'Visible','on')
I = imread('signup.jpg');
axes(handles.axes2);
imshow(I); 

guidata(hObject, handles);

% --- Executes on button press in back6.
function back6_Callback(hObject, eventdata, handles)
% hObject    handle to back6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%turn off current screen
set(handles.showresults,'Visible','off'); 
set(handles.back6,'Visible','off'); 
set(handles.finish2,'Visible','off'); 

%turn on pre processing page
set(handles.back5,'Visible','on')
set(handles.selectarea,'Visible','on')
set(handles.crop,'Visible','on')
set(handles.brightness,'Visible','on')
set(handles.slider1,'Visible','on')
set(handles.contrast,'Visible','on')
set(handles.slider2,'Visible','on')
set(handles.next2,'Visible','on')

cla(handles.axes2)
set(handles.axes2,'Visible','on')
I = imread('signup2.jpg');
axes(handles.axes2);
imshow(I); 


set(handles.axes3,'Visible','on');  
cla(handles.axes3);
axes(handles.axes3);
imshow(handles.image); 

guidata(hObject, handles);


% --- Executes on button press in finish2.
function finish2_Callback(hObject, eventdata, handles)
% hObject    handle to finish2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%turns off current screen
set(handles.finish2,'Visible','off'); 
set(handles.finalresults,'Visible','off'); 
set(handles.showresults,'Visible','off'); 
set(handles.back6,'Visible','off'); 
 
%Turns on homescreen
set(handles.signin,'Visible','on')
set(handles.newuser,'Visible','on')
set(handles.forgotpass,'Visible','on')
cla(handles.axes2)
set(handles.axes2,'Visible','on')
 
I = imread('home.JPG');
axes(handles.axes2);
imshow(I); 
  
guidata(hObject, handles);


% --- Executes on button press in finish3.
function finish3_Callback(hObject, eventdata, handles)
% hObject    handle to finish3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Turn off current screen
set(handles.finish3,'Visible','off'); 
set(handles.finalresults,'Visible','off'); 
set(handles.showresults,'Visible','off'); 
set(handles.back6,'Visible','off'); 

%Turn on home screen
set(handles.signin,'Visible','on')
set(handles.newuser,'Visible','on')
set(handles.forgotpass,'Visible','on')
cla(handles.axes2)
set(handles.axes2,'Visible','on')

I = imread('home.JPG');
axes(handles.axes2);
imshow(I); 

guidata(hObject, handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit2.
function edit2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on edit2 and none of its controls.
function edit2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function main_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to myCameraGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
delete(imaqfind);
