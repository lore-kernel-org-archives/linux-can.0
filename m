From: Leo Stan <leo.stanislas@qut.edu.au>
Subject: Re: kvaser leaf and SocketCAN
Date: Wed, 29 Apr 2015 06:15:53 +0000 (UTC)
Message-ID: <loom.20150429T081022-13@post.gmane.org>
References: <loom.20150422T090300-352@post.gmane.org> <553755E8.20704@pengutronix.de> <loom.20150429T040002-878@post.gmane.org> <CANGgnMbtZz2M=-7ydV6iSFtCskTeXnKsWVB9rqnwX1M+SE1AAg@mail.gmail.com> <loom.20150429T063429-693@post.gmane.org> <55406A03.9060105@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37255 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbbD2GQH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 29 Apr 2015 02:16:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1YnLHw-0007gk-By
	for linux-can@vger.kernel.org; Wed, 29 Apr 2015 08:16:04 +0200
Received: from nocproxy03-b.net.qut.edu.au ([131.181.251.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 29 Apr 2015 08:16:04 +0200
Received: from leo.stanislas by nocproxy03-b.net.qut.edu.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 29 Apr 2015 08:16:04 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl <at> pengutronix.de> writes:

> 
> On 04/29/2015 06:39 AM, Leo Stan wrote:
> > Hi Austin, thanks for your reply.
> > 
> > My ifconfig -a returns : 
> > 
> > eth0      Link encap:Ethernet  HWaddr 44:8a:5b:6d:50:8d  
> >           inet addr:131.181.70.9  Bcast:131.181.70.255  
Mask:255.255.255.0
> >           inet6 addr: fe80::468a:5bff:fe6d:508d/64 Scope:Link
> >           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> >           RX packets:3869 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:1783 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:1000 
> >           RX bytes:1268663 (1.2 MB)  TX bytes:481256 (481.2 KB)
> >           Interrupt:19 
> > 
> > lo        Link encap:Local Loopback  
> >           inet addr:127.0.0.1  Mask:255.0.0.0
> >           inet6 addr: ::1/128 Scope:Host
> >           UP LOOPBACK RUNNING  MTU:65536  Metric:1
> >           RX packets:228 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:228 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:0 
> >           RX bytes:37579 (37.5 KB)  TX bytes:37579 (37.5 KB)
> > 
> > wlan0     Link encap:Ethernet  HWaddr e8:2a:ea:de:3b:ae  
> >           UP BROADCAST MULTICAST  MTU:1500  Metric:1
> >           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:1000 
> >           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
> > 
> > So I don't think it detected the Leaf...
> > 
> > Now that I check my /dev/ folder there is actually leaf0 in it. Maybe 
> > installing the drivers from Kvaser prevents me from using SocketCan?
> 
> This can be the problem. Please try with the mainline drivers only.
> 
> Marc
> 


Hello Marc,

I uninstalled the driver and now :

- I don't have the leaf in /dev/ when I plug it, which is a good thing

- I have those modules running :

can_raw                17159  0 
can                    45043  1 can_raw
kvaser_usb             22385  0 
can_dev                21659  1 kvaser_usb


- ifconfig -a shows the CAN :

can0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-
00-00-00  
          NOARP  MTU:16  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

- My kernel log shows :

usb 1-3: new high-speed USB device number 4 using xhci_hcd
[ 1393.767114] usb 1-3: New USB device found, idVendor=0bfd, idProduct=0120
[ 1393.767124] usb 1-3: New USB device strings: Mfr=0, Product=2, 
SerialNumber=0
[ 1393.767128] usb 1-3: Product: Kvaser Leaf Light HS
[ 1393.815801] CAN device driver interface
[ 1393.857896] usbcore: registered new interface driver kvaser_usb

- When I try to run the example from http://en.wikipedia.org/wiki/SocketCAN I get this error :

vcan0 at index 1866752400
Error in socket bind: No such device


Thanks a lot for helping me.

