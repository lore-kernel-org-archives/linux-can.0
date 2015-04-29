From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: kvaser leaf and SocketCAN
Date: Wed, 29 Apr 2015 06:45:28 -0400
Message-ID: <20150429104528.GA5712@linux>
References: <loom.20150422T090300-352@post.gmane.org>
 <553755E8.20704@pengutronix.de>
 <loom.20150429T040002-878@post.gmane.org>
 <CANGgnMbtZz2M=-7ydV6iSFtCskTeXnKsWVB9rqnwX1M+SE1AAg@mail.gmail.com>
 <loom.20150429T063429-693@post.gmane.org>
 <55406A03.9060105@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34020 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422665AbbD2Kpc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Apr 2015 06:45:32 -0400
Received: by wgso17 with SMTP id o17so23540570wgs.1
        for <linux-can@vger.kernel.org>; Wed, 29 Apr 2015 03:45:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55406A03.9060105@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Leo Stan <leo.stanislas@qut.edu.au>, linux-can@vger.kernel.org

On Wed, Apr 29, 2015 at 07:20:03AM +0200, Marc Kleine-Budde wrote:
> On 04/29/2015 06:39 AM, Leo Stan wrote:
> > Hi Austin, thanks for your reply.
> > 
> > My ifconfig -a returns : 
> > 
> > eth0      Link encap:Ethernet  HWaddr 44:8a:5b:6d:50:8d  
> >           inet addr:131.181.70.9  Bcast:131.181.70.255  Mask:255.255.255.0
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

Yes, per their release notes, the Kvaser out-of-tree driver scripts
blacklists the in-tree SocketCAN driver to prevent it from auto-loading:

   http://www.kvaser.com/software/7330130980754/relnotes/relnotes_linuxcan.txt

> 
> This can be the problem. Please try with the mainline drivers only.
> 

Exactly.

Regards,
Darwish
