From: max <max.jacob@alternalab.it>
Subject: kvaser leaf and SocketCAN
Date: Wed, 22 Apr 2015 07:31:22 +0000 (UTC)
Message-ID: <loom.20150422T090300-352@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46857 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934150AbbDVHfL (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 22 Apr 2015 03:35:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1YkpBY-0004JT-4b
	for linux-can@vger.kernel.org; Wed, 22 Apr 2015 09:35:04 +0200
Received: from adsl-ull-249-9.41-151.net24.it ([151.41.9.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 22 Apr 2015 09:35:04 +0200
Received: from max.jacob by adsl-ull-249-9.41-151.net24.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 22 Apr 2015 09:35:04 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I'm trying to connect to a Kvaser Leaf Light V2 (product_id=15) adapter on 
linux from python3.4, and for that purpose I've planned to use SocketCAN. 

I have downloaded and compiled the kvaser drivers v.5.9, my kernel is a 
3.13.0-49-generic, and according to the information I've fund so far, the 
system requirements should all be met. 

And in fact, when I connect the adapter, the leaf kernel module is 
correctly loaded (I see it in lsmod) and the /usr/sbin/leaf.sh is started 
(I desume this from the fact that if I try to start it manually it tells me 
it has already been started), and also the /dev/leaf0 device is created. 

So far so good. But what's next? What I have understood is that at this 
point there should be the kvaser_usb module that comes into play for 
mapping the device to a network interface that can be brought up and used 
by SocketCAN. 

But the kvaser_usb module is not loaded automatically, and if I modprobe it 
manually, nothing seems to happen.

Here is what goes on in the kernel log when connecting the adapter:

[46464.671385] usb 3-2: new high-speed USB device number 4 using xhci_hcd
[46464.689616] usb 3-2: New USB device found, idVendor=0bfd, idProduct=0120
[46464.689627] usb 3-2: New USB device strings: Mfr=0, Product=2, 
SerialNumber=0
[46464.689633] usb 3-2: Product: Kvaser Leaf Light v2
[46467.738639] usbcore: registered new interface driver leaf

And this when I modprobe the kvaser_usb module:

[46545.271520] usbcore: registered new interface driver kvaser_usb

If I invert the order of the two operations, it is exactly the same. I've 
also tryed with and without an actual can device connected to the other end 
of the adapter, but this doesn't change anything either.

So, it looks I am still missing something... Can anyone tell me what 
further steps are necessary to finally get a can0 interface to show up?

Thank's a lot for any hint pointing me to the right direction...

Max




