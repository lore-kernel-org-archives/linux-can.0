From: Leo Stan <leo.stanislas@qut.edu.au>
Subject: Re: kvaser leaf and SocketCAN
Date: Wed, 29 Apr 2015 02:01:16 +0000 (UTC)
Message-ID: <loom.20150429T040002-878@post.gmane.org>
References: <loom.20150422T090300-352@post.gmane.org> <553755E8.20704@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59485 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966150AbbD2DaI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 28 Apr 2015 23:30:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1YnIhJ-00034r-6y
	for linux-can@vger.kernel.org; Wed, 29 Apr 2015 05:30:05 +0200
Received: from nocproxy03-b.net.qut.edu.au ([131.181.251.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 29 Apr 2015 05:30:05 +0200
Received: from leo.stanislas by nocproxy03-b.net.qut.edu.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 29 Apr 2015 05:30:05 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl <at> pengutronix.de> writes:

> 
> On 04/22/2015 09:31 AM, max wrote:
> > I'm trying to connect to a Kvaser Leaf Light V2 (product_id=15) adapter 
on 
> > linux from python3.4, and for that purpose I've planned to use 
SocketCAN. 
> > 
> > I have downloaded and compiled the kvaser drivers v.5.9, my kernel is a 
> > 3.13.0-49-generic, and according to the information I've fund so far, 
the 
> > system requirements should all be met. 
> 
> Where do you download the driver from? I suggest to use a recent
> mainline kernel. Support for the Kvaser Leaf v2 was added in v3.16 and a
> _lot_ of bugfixes were added in later versions. Switching to a recent
> ubuntu kernel (v3.19) is probably a good idea.
> 
> > And in fact, when I connect the adapter, the leaf kernel module is 
> > correctly loaded (I see it in lsmod) and the /usr/sbin/leaf.sh is 
started 
> > (I desume this from the fact that if I try to start it manually it 
tells me 
> > it has already been started), and also the /dev/leaf0 device is 
created. 
> 
> A /dev/leaf0 is not created by the mainline driver...
> 
> > So far so good. But what's next? What I have understood is that at this 
> > point there should be the kvaser_usb module that comes into play for 
> > mapping the device to a network interface that can be brought up and 
used 
> > by SocketCAN. 
> > 
> > But the kvaser_usb module is not loaded automatically, and if I 
modprobe it 
> > manually, nothing seems to happen.
> > 
> > Here is what goes on in the kernel log when connecting the adapter:
> > 
> > [46464.671385] usb 3-2: new high-speed USB device number 4 using 
xhci_hcd
> > [46464.689616] usb 3-2: New USB device found, idVendor=0bfd, 
idProduct=0120
> > [46464.689627] usb 3-2: New USB device strings: Mfr=0, Product=2, 
> > SerialNumber=0
> > [46464.689633] usb 3-2: Product: Kvaser Leaf Light v2
> > [46467.738639] usbcore: registered new interface driver leaf
> > 
> > And this when I modprobe the kvaser_usb module:
> > 
> > [46545.271520] usbcore: registered new interface driver kvaser_usb
> > 
> > If I invert the order of the two operations, it is exactly the same. 
I've 
> > also tryed with and without an actual can device connected to the other 
end 
> > of the adapter, but this doesn't change anything either.
> > 
> > So, it looks I am still missing something... Can anyone tell me what 
> > further steps are necessary to finally get a can0 interface to show up?
> > 
> > Thank's a lot for any hint pointing me to the right direction...
> 
> Use a recent mainline kernel, then everything should work out of the
> box, without any external drivers and manual module loading.
> 
> Marc




Hi Marc and Max,

I am also trying to use this device on Ubuntu 14.04 with Linux kernel 
3.19.0-031900-generic. 

When I connect the device I have the kernel log as follow 

[ 3506.638843] usb 1-3: USB disconnect, device number 6
[ 3508.818400] usb 1-3: new high-speed USB device number 7 using xhci_hcd
[ 3508.949596] usb 1-3: New USB device found, idVendor=0bfd, idProduct=0120
[ 3508.949603] usb 1-3: New USB device strings: Mfr=0, Product=2, 
SerialNumber=0
[ 3508.949607] usb 1-3: Product: Kvaser Leaf Light HS

I have installed the drivers from Kvaser for linux therefore I have the 
modules :

kvaser_usb             22385  0 
can_dev                21659  1 kvaser_usb

However nothing appears in /dev folder

I tried the SocketCan example code from this wiki page : 

http://en.wikipedia.org/wiki/SocketCAN

But I get this error :
 
vcan0 at index -571419056
Error in socket bind: No such device



Thanks in advance for any help.

Leo



