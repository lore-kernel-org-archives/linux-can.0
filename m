From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: bind() Host is down listening on j1939 interfaces
Date: Wed, 16 Aug 2017 11:40:29 +0200
Message-ID: <20170816094029.GD32670@airbook.vandijck-laurijssen.be>
References: <CAJn4=pX9FczzJSFfQPQ3ghSv+T6Lj1SirSmVH1f8mrOXRux-dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:41553 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbdHPJmS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Aug 2017 05:42:18 -0400
Content-Disposition: inline
In-Reply-To: <CAJn4=pX9FczzJSFfQPQ3ghSv+T6Lj1SirSmVH1f8mrOXRux-dQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lehel Benedek <benedek.lehel@gmail.com>
Cc: linux-can@vger.kernel.org, cosmo@iocurrents.com

Hello,

> 
> Hi all,
> 
> I've found this message in the archives, and bringing this up because
> I'm having this exact same issue as described below on a 2.6.35 kernel
> on an imx53 board.
> Have tried vcan or flexcan modules, both throwing the same EHOSTDOWN
> error on binding.
> However binding to a CAN_RAW socket is working as expected, no problems there.
> 
> Haven't seen any replies to this issue, Cosmo have you managed to get around it?
> 
> Any advice on how to troubleshoot this problem would be greatly appreciated.

I assume that the code was still the old-style can-j1939 support, where
you had to enable the can-j1939 per interface explicitely.
I'll take a look this evening where the legacy documentation is exactly.

Kurt

> 
> Best regards,
> Lehel
> 
> 
> > > Hello,
> > >
> > > I'm having a bit of trouble getting the j1939 CAN support working on a Freescale \
> > > i.MX6 UL.
> > >
> > > We are running Debian 3.14.52 kernel on armv7l patched with j1939 support as per \
> > > http://elinux.org/J1939 and also compiled the latest can-utils from \
> > > git://github.com/kurt-vd/can-utils and test-can-j1939.
> > >
> > > We have a real working can interface on can0 that we start like this:
> > > root@dart3:~# ip link set can0 up type can bitrate 250000
> > >
> > > And also added a vcan interface for testing just in case:
> > > root@dart3:~# ip link add can2 type vcan
> > > root@dart3:~# ip link set can2 up
> > >
> > > root@dart3:~# ifconfig
> > > can0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-> > 00-00-00-00
> > >          UP RUNNING NOARP  MTU:16  Metric:1
> > >          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> > >          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> > >          collisions:0 txqueuelen:10
> > >          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
> > >          Interrupt:142
> > >
> > > can2      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
> > >          UP RUNNING NOARP  MTU:16  Metric:1
> > >          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> > >         TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> > >          collisions:0 txqueuelen:0
> > >          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
> > >
> > > testj1939 cannot listen on either can0 or can2.  The error is: testj1939: bind(): \
> > > Host is down
> > >
> > > root@dart3:~# testj1939 -r can0:
> > > - socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
> > > - bind(, can0:,,, 24);
> > > testj1939: bind(): Host is down
> > >
> > > root@dart3:~# testj1939 -r can2:
> > > - socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
> > > - bind(, can2:,,, 24);
> > > testj1939: bind(): Host is down
> > >
> > > I tested this same scenario on a Debian VM with 3.18 kernel and vcan and it worked \
> > > fine.  Any suggestions?
