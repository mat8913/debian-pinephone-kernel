cd ..; rm *.deb; rm -r linux-5.10.70; apt source linux; cd linux-5.10.70; rm -r debian; cp -r ../linux/debian .
