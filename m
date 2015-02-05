From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: usb_8dev: Initialisation issue with powered USB 2.0 hub
Date: Thu, 05 Feb 2015 19:03:29 +0100
Message-ID: <54D3B071.4040705@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:57029 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbbBESDr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Feb 2015 13:03:47 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Bernd,

i got an error report from a colleague today who is using the USB2CAN from
8devices behind a self powered USB2.0 hub.

The way to get into the problem:

1. Connect a self powered USB hub with attached USB2CAN to the host:


[  502.464008] usb 3-2: new high-speed USB device number 8 using xhci_hcd
[  502.593336] usb 3-2: New USB device found, idVendor=05e3, idProduct=0608
[  502.593339] usb 3-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[  502.593341] usb 3-2: Product: USB2.0 Hub
[  502.593863] hub 3-2:1.0: USB hub found
[  502.594124] hub 3-2:1.0: 4 ports detected
[  502.864710] usb 3-2.1: new full-speed USB device number 9 using xhci_hcd
[  502.955087] usb 3-2.1: New USB device found, idVendor=0483, idProduct=1234
[  502.955097] usb 3-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  502.955102] usb 3-2.1: Product: USB2CAN converter
[  502.955106] usb 3-2.1: Manufacturer: edevices
[  502.955110] usb 3-2.1: SerialNumber: ED000215
[  502.956739] usb_8dev 3-2.1:1.0 can0: firmware: 1.5, hardware: 255.255

(everything is fine - USB2CAN LED is RED)

# ip -det link show can0
21: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0 
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0 
	  usb_8dev: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
	  clock 32000000
# ip link set can0 type can bitrate 500000
# ifconfig can0 up

(still everything is fine - USB2CAN LED is GREEN)

Adapter works as expected. It can send and receive CAN frames.

2. Now unplug the powered hub from the PC:

[  680.841130] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
[  680.841212] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
[  680.841252] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
[  680.841308] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
[  680.841352] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
[  680.841377] usb 3-2: USB disconnect, device number 8
[  680.841385] usb 3-2.1: USB disconnect, device number 9
[  680.841388] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
[  680.843607] usb_8dev 3-2.1:1.0 can0: device disconnected
[  680.843634] usb_8dev 3-2.1:1.0 can0: sending command message failed
[  680.843639] usb_8dev 3-2.1:1.0 can0: couldn't stop device

The USB2CAN LED remains GREEN - as the adapter is still powered.

3. Now plug the powered hub into the PC again:

[  705.799101] usb 3-2: new high-speed USB device number 10 using xhci_hcd
[  705.928881] usb 3-2: New USB device found, idVendor=05e3, idProduct=0608
[  705.928891] usb 3-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[  705.928895] usb 3-2: Product: USB2.0 Hub
[  705.929871] hub 3-2:1.0: USB hub found
[  705.930191] hub 3-2:1.0: 4 ports detected
[  706.203831] usb 3-2.1: new full-speed USB device number 11 using xhci_hcd
[  706.294249] usb 3-2.1: New USB device found, idVendor=0483, idProduct=1234
[  706.294259] usb 3-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  706.294264] usb 3-2.1: Product: USB2CAN converter
[  706.294268] usb 3-2.1: Manufacturer: edevices
[  706.294271] usb 3-2.1: SerialNumber: ED000215
[  706.296097] usb_8dev 3-2.1:1.0 can0: firmware: 1.5, hardware: 255.255

The USB2CAN LED remains GREEN - as the adapter is still powered.
But the CAN netdevice is not configured:

# ip -det link show can0
21: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0 
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0 
	  usb_8dev: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
	  clock 32000000

After setting the bitrate again & putting the interface up:

# ip link set can0 type can bitrate 500000
# ifconfig can0 up

The USB2CAN LED remains GREEN.

But from this point the USB2CAN adapter can only *send* CAN frames but it can not
receive any frames. Btw. the CAN controller inside the USB2CAN properly acknowledges
the CAN frames on the bus (without making them visible on the host).

Any idea how to fix the initialization in this warm start scenario?

My colleague also reported kernel crashes which I wasn't able to reproduce.
I used a 3.19.0-rc7 here - don't know what my colleague was using.

Best regards,
Oliver
