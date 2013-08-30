From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Reading messages that use BAM, or have a DLC larger than 8
Date: Fri, 30 Aug 2013 20:06:26 +0200
Message-ID: <20130830180626.GB571@vandijck-laurijssen.be>
References: <20130829195631.GB538@vandijck-laurijssen.be>
 <zarafa.522065ba.471f.174f0b440938c779@v14647.1blu.de>
 <20130830175758.GA571@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:47947 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756699Ab3H3SGb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Aug 2013 14:06:31 -0400
Content-Disposition: inline
In-Reply-To: <20130830175758.GA571@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Michael,

On Fri, Aug 30, 2013 at 07:57:58PM +0200, Kurt Van Dijck wrote:
> On Fri, Aug 30, 2013 at 11:28:26AM +0200, Michael Luxen wrote:

> > > > 3. What is the normal way to setup the bitrate and the j1939 interface in one 
> > > step? 
> > > > "ip link set can0 type can bitrate 500000" works to set up standard CAN 
> > > interface but "ip link set can0 type j1939 on bitrate 250000" doesn't work 
> > > (Garbage instead of arguments "bitrate ...". Try "ip link help".)
> > > > I've set up the bitrate first with "ip link set can0 type can bitrate 250000" 
> > > and then "ip link set can0 j1939 on"
> > > 
> > > I did my best not to duplicate functionality.
> > > $ ip link set can0 j1939 on type can bitrate 250000
> > > would work.
> > In general yes, but if I do:
> > $ ip link set can0 j1939 on type can bitrate 250000
> > $ ip link set can0 up
> > RTNETLINK answers: Invalid argument
> > 
> > I can't set up the can0 interface with J1939 support 
> > 
> > And if I try to do it afterwards like:
> > $ ip link set can0 down
> > $ ip link set can0 type can bitrate 250000
> > $ ip link set can0 j1939 on
> > RTNETLINK answers: Address family not supported by protocol
> > 
> > After power reset;
> > $ ip link set can0 j1939 on type can bitrate 250000
> > $ ip link set can0 type can bitrate 250000
> > $ ip link set can0 up
> > $ jspy can0
> > jspy: bind(can0): Host is down
> > 
> > 
> > Setting up of the can0 doesn't work correctly IMHO, the only way which is working for me is after a power reset:
> > $ ip link set can0 j1939 on type can bitrate 250000
> > $ ip link set can0 type can bitrate 250000
> > $ ip link set can0 j1939 on up
> > $ jspy can0:00000000e8a9344c,0feca
> >  can0:00000000e8a9344c,0feca - !6 [8] 00ff0000 0000ffff
> >  can0:00000000e8a9344c,0feca - !6 [8] 00ff0000 0000ffff
> >  can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
> >  can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
> >  can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
> > 
> > Is there anything I do in the wrong way?
> 
> Nop. I get the same here. It have worked for a long time, but not today.
> You probably don't do something wrong, but have something changed somewhere
> that my j1939 stack depends on.

Found our problem. I was too fast.
loading can-j1939.ko installs the AF_CAN handlers for some netlink communications.
I don't know how to make it autoprobe.
So, make sure can-j1939 is loaded (compiled in kernel, or module loaded).
Then it'll work.

calling jspy or any other j1939 socket program, will trigger loading can-j1939.

I tried now with vcan0:
$ ip link set vcan0 j1939 on up
and that worked.

Kind regards,
Kurt

