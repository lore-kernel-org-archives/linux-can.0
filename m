From: Francesco Giovannini <francesco.giovannini@iit.it>
Subject: Can't start ESD CAN-USB/2
Date: Fri, 31 Jan 2014 17:09:49 +0100
Message-ID: <52EBCACD.9080906@iit.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.iit.it ([90.147.26.161]:44537 "EHLO es400ra02.iit.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033AbaAaQJr (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 31 Jan 2014 11:09:47 -0500
Received: from es400ra02.iit.it (127.0.0.1) id htf5cm0171s7 for <linux-can@vger.kernel.org>; Fri, 31 Jan 2014 17:09:46 +0100 (envelope-from <prvs=1108748f8e=Francesco.Giovannini@iit.it>)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi guys!

I am running OpenSuse 12.2, kernel 3.4.63-2.44-desktop. I downloaded and 
installed libsocketcan v0.0.9 and canutils v4.0.6. I then compiled the 
esd_can2 module and modprobed it correctly. When i plug in my CAN-USB/2 
device i get the following from dmesg:

    [186823.262021] usb 1-10: new high-speed USB device number 22 using
    ehci_hcd
    [186823.826031] usb 1-10: device not accepting address 22, error -71
    [186823.877025] hub 1-0:1.0: unable to enumerate USB device on port 10
    [186827.879018] usb 1-10: new high-speed USB device number 24 using
    ehci_hcd
    [186827.995429] usb 1-10: New USB device found, idVendor=0ab4,
    idProduct=0010
    [186827.995432] usb 1-10: New USB device strings: Mfr=1, Product=2,
    SerialNumber=3
    [186827.995435] usb 1-10: Product: USB2292
    [186827.995438] usb 1-10: Manufacturer: esd electronic system design
    gmbh (www.esd-electronics.com)
    [186827.995440] usb 1-10: SerialNumber: GM001950
    [186827.997824] esd_usb2 1-10:1.0: can0: device can0 registered

The device appears to be correctly recognised and the can0 interface is 
ready to be used. I then set the bitrate and several other paramters with:

    # canconfig can0 bittiming  prop-seg 2 phase-seg1 12 phase-seg2 5
    sjw 1 brp 3 tq 50

    can0 bittiming:
         tq: 50, prop-seq: 2 phase-seq1: 12 phase-seq2: 5 sjw: 1, brp: 3
    can0 bitrate: 1000000, sample-point: 0.750

However when i try to start the interface with # ifconfig can0 up, I get 
the following error:

    SIOCSIFFLAGS: Invalid argument

If I look at the details for the can0 interface it seems that all the 
configuration parameters I sent earlier are not taken into account:

    # ip -d link show can0
    16: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT qlen 10
         link/can
         can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
         bitrate 0 sample-point 0.000
         tq 0 prop-seg 0 phase-seg1 0 phase-seg2 0 sjw 0
         esd_usb2: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
         clock 60000000

Also, for reference sake, my kernel is compiled with 
CONFIG_CAN_CALC_BITTIMING=y. I am of course running all of these 
commands as root.

I must say this is a very weird behaviour. I have been struggling 
without being able to see the light and I really hope one of you guys 
might have a clue about what is going on.


Thanks a lot!
Francesco
-- 
*Francesco Giovannini*
Research Fellow
iCub Facility
*Istituto Italiano di Tecnologia*
Via Morego, 30 16163 Genova
/email:/ francesco.giovannini@iit.it <mailto://francesco.giovannini@iit.it>
www.iit.it <http://www.iit.it>
