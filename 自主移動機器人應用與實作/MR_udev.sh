# CP2102 serial number 0002 Set the alias to wheeltec_controller
echo  'KERNEL=="ttyUSB*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60",ATTRS{serial}=="0002", MODE:="0777", GROUP:="dialout", SYMLINK+="wheeltec_controller"' >/etc/udev/rules.d/wheeltec_controller.rules
# CH9102, with corresponding driver installed Serial number 0002 Set the alias to wheeltec_controller
echo  'KERNEL=="ttyCH343USB*", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="55d4",ATTRS{serial}=="0002", MODE:="0777", GROUP:="dialout", SYMLINK+="wheeltec_controller"' >/etc/udev/rules.d/wheeltec_controller2.rules
# CH9102, with no corresponding driver installed Serial number 0002 Set the alias to wheeltec_controller
echo  'KERNEL=="ttyACM*", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="55d4",ATTRS{serial}=="0002", MODE:="0777", GROUP:="dialout", SYMLINK+="wheeltec_controller"' >/etc/udev/rules.d/wheeltec_controller3.rules


# CP2102 serial number 0001 Set the alias to wheeltec_lidar
echo  'KERNEL=="ttyUSB*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60",ATTRS{serial}=="0001", MODE:="0777", GROUP:="dialout", SYMLINK+="wheeltec_laser"' >/etc/udev/rules.d/wheeltec_lidar.rules
# CH9102, with corresponding driver installed Serial number 0001 Set the alias to wheeltec_lidar
echo  'KERNEL=="ttyCH343USB*", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="55d4",ATTRS{serial}=="0001", MODE:="0777", GROUP:="dialout", SYMLINK+="wheeltec_laser"' >/etc/udev/rules.d/wheeltec_lidar2.rules
# CH9102, with no corresponding driver installed Serial number 0001 Set the alias to wheeltec_lidar
echo  'KERNEL=="ttyACM*", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="55d4",ATTRS{serial}=="0001", MODE:="0777", GROUP:="dialout", SYMLINK+="wheeltec_laser"' >/etc/udev/rules.d/wheeltec_lidar3.rules

# CP2102 serial number 0003 Set the alias to wheeltec_FDI_IMU_GNSS
echo  'KERNEL=="ttyUSB*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60",ATTRS{serial}=="0003", MODE:="0777", GROUP:="dialout", SYMLINK+="wheeltec_FDI_IMU_GNSS"' >/etc/udev/rules.d/wheeltec_fdi_imu_gnss.rules
# CH9102, with corresponding driver installed Serial number 0003 Set the alias to wheeltec_FDI_IMU_GNSS
echo  'KERNEL=="ttyCH343USB*", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="55d4",ATTRS{serial}=="0003", MODE:="0777", GROUP:="dialout", SYMLINK+="wheeltec_FDI_IMU_GNSS"' >/etc/udev/rules.d/wheeltec_fdi_imu_gnss2.rules
# CH9102, with no corresponding driver installed Serial number 0003 Set the alias to wheeltec_FDI_IMU_GNSS
echo  'KERNEL=="ttyACM*", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="55d4",ATTRS{serial}=="0003", MODE:="0777", GROUP:="dialout", SYMLINK+="wheeltec_FDI_IMU_GNSS"' >/etc/udev/rules.d/wheeltec_fdi_imu_gnss3.rules

echo  'SUBSYSTEM=="video4linux",ATTR{name}=="GENERAL WEBCAM",ATTR{index}=="0",MODE:="0777",SYMLINK+="RgbCam"' >>/etc/udev/rules.d/camera.rules
echo  'SUBSYSTEM=="video4linux",ATTR{name}=="GENERAL WEBCAM: GENERAL WEBCAM",ATTR{index}=="0",MODE:="0777",SYMLINK+="RgbCam"' >>/etc/udev/rules.d/camera.rules
echo  'SUBSYSTEM=="video4linux",ATTR{name}=="Astra Pro HD Camera: Astra Pro ",ATTR{index}=="0",MODE:="0777",SYMLINK+="Astra_Pro"' >>/etc/udev/rules.d/camera.rules
echo  'SUBSYSTEM=="video4linux",ATTR{name}=="USB 2.0 Camera: USB Camera",ATTR{index}=="0",MODE:="0777",SYMLINK+="Astra_Dabai"' >>/etc/udev/rules.d/camera.rules
echo  'SUBSYSTEM=="video4linux",ATTR{name}=="USB 2.0 Camera",ATTR{index}=="0",MODE:="0777",SYMLINK+="Astra_Gemini"' >>/etc/udev/rules.d/camera.rules
echo  'SUBSYSTEM=="video4linux",ATTR{name}=="Intel(R) RealSense(TM) Depth Ca",ATTR{index}=="0",MODE:="0777",SYMLINK+="realsense"' >>/etc/udev/rules.d/camera.rules

service udev reload
sleep 2
service udev restart
