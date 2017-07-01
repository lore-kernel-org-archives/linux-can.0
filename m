From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Getting manufacturer/product name for CAN interface
Date: Sat, 1 Jul 2017 17:57:37 +0200
Message-ID: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:51049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbdGAP5l (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 1 Jul 2017 11:57:41 -0400
Received: from [192.168.2.107] ([87.187.211.128]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpwZn-1du59J3W0l-00fklS for
 <linux-can@vger.kernel.org>; Sat, 01 Jul 2017 17:57:38 +0200
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi SocketCAN experts and developers,

I'm one of the QtSerialBus [1] developers and added a function to scan
for available devices [2] some month ago.

For now this function reads the sysfs to create a list like this:

can0
can1
vcan0
vcan1

What I wanted to have now, is the corresponding hardware description for
each of these interfaces. For the virtual devices this would be just 
something like "Virtual CAN 0". For real hardware I'd like to get the 
manufacturer and product strings.

This information is available in dmesg when a device is connected:

[48395.500029] usb 1-4: new full-speed USB device number 7 using xhci_hcd
[48395.641496] usb 1-4: New USB device found, idVendor=0878, idProduct=1105
[48395.641501] usb 1-4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[48395.641504] usb 1-4: Product: USB-CANmodul2
[48395.641507] usb 1-4: Manufacturer: SYS TEC electronic GmbH

But not even ifconfig shows this:

can0      Link encap:UNSPEC  Hardware Adresse 00-01-B0-BD-...-00
           NOARP  MTU:16  Metrik:1
           RX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Fenster:0
           TX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Träger:0
           Kollisionen:0 Sendewarteschlangenlänge:10
           RX-Bytes:0 (0.0 B)  TX-Bytes:0 (0.0 B)

can1      Link encap:UNSPEC  Hardware Adresse 00-01-B0-BD--...-00
           NOARP  MTU:16  Metrik:1
           RX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Fenster:0
           TX-Pakete:0 Fehler:0 Verloren:0 Überläufe:0 Träger:0
           Kollisionen:0 Sendewarteschlangenlänge:10
           RX-Bytes:0 (0.0 B)  TX-Bytes:0 (0.0 B)

Now the question: Is there a way to query manufacturer/device
information for a given interface name canX from C/C++?

Thanks in advance,
André

[1] http://code.qt.io/cgit/qt/qtserialbus.git
[2] http://doc.qt.io/qt-5/qcanbus.html#availableDevices
