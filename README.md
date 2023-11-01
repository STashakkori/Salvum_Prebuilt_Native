# Salvum_Prebuilt_Native
This is the package deployed for Appalachian State University to support interactive cybersecurity education (CS3760) taught by Dr. T

It is a boon to all who wish to learn the security arts.

Native Ubuntu 20 LTS+ installer. For cross-platform Salvum, see containerized versions.

Setup Instructions:

Create a directory in ~ called salvum

Copy install_salvum.sh and slm.tgz to ~/salvum directory

From the ~/salvum directory, execute the following command:
```
sudo ./install_salvum.sh
```
Installation will create an slm/ directory that will contain the salvum binary and everything needed. Inside slm/ you can then run:
```
sudo ./salvum test
```
That command will verify installation was successful. Should pass tests, feel free to create issues for any that don't.

Then can run salvum with:
```
sudo ./salvum
```
Don't have to run as su but not much will work without privilege.

Yara and PXE functionality have been excluded from this this distribution along with the QVLx FCC db.

This made the image way smaller and easier to work with. Servf should also not work as its been commented.

In conclusion, this installable package is smaller than the full 300+ app version by design but still super powerful.

![asu_art](https://github.com/STashakkori/Salvum_Prebuilt_Native/assets/4257899/49cdcad0-1157-4be9-b630-cd21217f1f4c)
