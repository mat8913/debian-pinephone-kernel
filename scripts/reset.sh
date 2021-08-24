cd ..; rm *.deb; rm -r linux-5.10.46; apt source linux; cd linux-5.10.46; rm -r debian; cp -r ../linux/debian .
