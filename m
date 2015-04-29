From: Leo Stan <leo.stanislas@qut.edu.au>
Subject: Re: kvaser leaf and SocketCAN
Date: Wed, 29 Apr 2015 04:39:36 +0000 (UTC)
Message-ID: <loom.20150429T063429-693@post.gmane.org>
References: <loom.20150422T090300-352@post.gmane.org> <553755E8.20704@pengutronix.de> <loom.20150429T040002-878@post.gmane.org> <CANGgnMbtZz2M=-7ydV6iSFtCskTeXnKsWVB9rqnwX1M+SE1AAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33644 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbbD2Ejo (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 29 Apr 2015 00:39:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1YnJmg-0007bK-8X
	for linux-can@vger.kernel.org; Wed, 29 Apr 2015 06:39:43 +0200
Received: from nocproxy03-b.net.qut.edu.au ([131.181.251.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 29 Apr 2015 06:39:42 +0200
Received: from leo.stanislas by nocproxy03-b.net.qut.edu.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 29 Apr 2015 06:39:42 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Austin Schuh <austin <at> peloton-tech.com> writes:

> 
> $ ifconfig -a
> can0      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>           Interrupt:18
> 
> Austin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Hi Austin, thanks for your reply.

My ifconfig -a returns : 

eth0      Link encap:Ethernet  HWaddr 44:8a:5b:6d:50:8d  
          inet addr:131.181.70.9  Bcast:131.181.70.255  Mask:255.255.255.0
          inet6 addr: fe80::468a:5bff:fe6d:508d/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3869 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1783 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:1268663 (1.2 MB)  TX bytes:481256 (481.2 KB)
          Interrupt:19 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:228 errors:0 dropped:0 overruns:0 frame:0
          TX packets:228 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:37579 (37.5 KB)  TX bytes:37579 (37.5 KB)

wlan0     Link encap:Ethernet  HWaddr e8:2a:ea:de:3b:ae  
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

So I don't think it detected the Leaf...

Now that I check my /dev/ folder there is actually leaf0 in it. Maybe 
installing the drivers from Kvaser prevents me from using SocketCan?

Also I have all of these modules running that a related to the leaf :

can_raw                17159  0 
can                    45043  1 can_raw
kvaser_usb             22385  0 
can_dev                21659  1 kvaser_usb
leaf                   43136  1 

Thank you for your help

Leo



