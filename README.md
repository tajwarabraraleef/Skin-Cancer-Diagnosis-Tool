# Skin Cancer Diagnosis Tool
<br/>

<p align="center">
  <a href="#"><img src="assests/figures/homepage.png" height=500/></a>
</p>

This was developed as a requirement for e-Health course in Erasmus Mundus+ Joint Master Degree in Medical Imaging and Applications ([MAIA](https://maiamaster.udg.edu/)). 

## Prerequisites
![MTALAB R2019b](https://img.shields.io/badge/MATLAB-2019b-orange.svg)
[![MTALAB Image Acquisition Toolbox](https://img.shields.io/badge/MATLAB-Image_Acquisition_Toolbox-orange.svg)](https://www.mathworks.com/products/image-acquisition.html)
[![MTALAB Deep Learning Toolbox](https://img.shields.io/badge/MATLAB-Deep_Learning_Toolbox-orange.svg)](https://www.mathworks.com/products/deep-learning.html)
[![MTALAB Support Package](https://img.shields.io/badge/MATLAB-Support_Package-orange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/45183-image-acquisition-toolbox-support-package-for-os-generic-video-interface)



## Summary
A toolkit for analyzing RGB skin images and diagnosing the presence of cancer. A minimalistic easy to use UI was developed using MatLab’s built-in GUI designer called GUIDE. This app was designed not to make the final diagnosis but to provide users with a simple tool to take and manage images of suspected skin areas and let their doctor make the final diagnosis. When registering an account, information about the user's doctor is also taken. After images are taken, the initial diagnosis and the image taken are sent to the doctor directly and the doctor then decides the final diagnosis. The toolkit also lets the user to see the results if they would like to. The diagnosis of cancer is based on a pre-trained  AlexNet that was trained using skin cancer data from [ISIC 2017 Challenge](https://challenge.isic-archive.com/landing/2017/). 

## Usage

* Download the pretrained network weights from [here](https://drive.google.com/file/d/1d-uXMO1GISsSch4MHP0MSWwo3LBtmJe2/view?usp=sharing). Or train your own network by modifying `classification_net.m` and save the weights as `Classification_net.mat`. I suggest training your own network as there are much more publicly available data for skin cancer now. 

* Modify the credentials of the email address you would like to use to sent emails on `email_settings.m`

* Run `main.m` to open the homepage of the UI. 

## UI Details

Upon running the `main.m`, the homepage will show up.

<a href="#"><img src="assests/figures/homepage.png" height=300/></a>

For new users, they can sign up by clicking the `New User` button. First, the toolkit will ask for information about the user


<a href="#"><img src="assests/figures/signup.png" height=300/></a>

followed by the information of the user' Doctor.

<a href="#"><img src="assests/figures/signup2.png" height=300/></a>

Now the user can log in by clicking the `Log in` button and using their credentials.

<a href="#"><img src="assests/figures/login.png" height=300/></a>

If the user forgets their password, they can recover it by clicking the `Forget Password?` button and providing their email address.

<a href="#"><img src="assests/figures/forgotpass.png" height=300/></a>

After logging in the user can take a new image, load an image from disk, or view their previous results with images.

<a href="#"><img src="assests/figures/imageinput.png" height=300/></a>

To take a new picture, the `Camera` button needs to be pressed. This will open up their webcam or any other higher-end camera connected to their system. Currently, the code is set up to use the camera with id-0.

<a href="#"><img src="assests/figures/camera.png" height=300/></a>

To load an image from disk, press `Load picture`.

<a href="#"><img src="assests/figures/load.png" height=300/></a>

After the image is selected, the toolkit offers some simple pre-processing which includes adjusting the brightness and contrast of the image. The user can also select a region of interest and crop the image if needed.

<a href="#"><img src="assests/figures/preprocess.png" height=300/></a>

After pressing `Next`, now the toolkit passes the processed image to the backend where the neural network classifies the image. The result page doesn't show the results immediately and prompts the user to contact their Doctor who has received the diagnosis with the image. 

<a href="#"><img src="assests/figures/results.png" height=300/></a>

A snapshot of what the Doctor receives.

<a href="#"><img src="assests/figures/email2.png" height=300/></a>

If the user still wants to see the diagnosis of the toolkit, they can click `Show Results`.

<a href="#"><img src="assests/figures/results2.png" height=300/></a>

Finally, the toolkit has many check functions and warnings that prevent the UI from crashing if incorrect information is provided.

<a href="#"><img src="assests/figures/warnings.png" height=150/></a>


## Contributing & Contact 

Send a pull request if you would like to contribute. If you face any problem using this code then please create an issue in this repository or contact me at [tajwaraleef@ece.ubc.ca](mailto:tajwaraleef@ece.ubc.ca?subject=[GitHub]%20SkinCancerDiagnosisTool%20Issue%20)

## License
MIT

