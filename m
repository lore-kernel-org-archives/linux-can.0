From: swapnil <patilswa@gmail.com>
Subject: Re: J1939 Interpacket Delay
Date: Thu, 10 Apr 2014 02:49:21 +0000 (UTC)
Message-ID: <loom.20140410T043630-197@post.gmane.org>
References: <loom.20140409T155830-71@post.gmane.org> <20140409195225.GE15221@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60243 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932996AbaDJCte (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 9 Apr 2014 22:49:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1WY53U-000375-2I
	for linux-can@vger.kernel.org; Thu, 10 Apr 2014 04:49:32 +0200
Received: from 99-153-234-13.lightspeed.iplsin.sbcglobal.net ([99.153.234.13])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 10 Apr 2014 04:49:32 +0200
Received: from patilswa by 99-153-234-13.lightspeed.iplsin.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 10 Apr 2014 04:49:32 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:

> 
> Hey,
> 
> part 2 ...
> 
> On Wed, Apr 09, 2014 at 02:17:11PM +0000, swapnil wrote:
> > Hi All,
> > 
> >         Hey Kurt I am using the J1939 stack on begalbone 
> > I am halfway through. I am getting some issue while testing with 
different 
> > engine control modules
> > 
> 
> [...]
> 
> > 
> > 2.if There is only one device connected on the bus like 
Begalbone(address -
> > f9) and Engine control module(address -00) 
> >      if i send a message to address 01 or 02 on can bus i see message 
for 01 
> > is converted to address 00 
> > like i amsending 18EF01F9#FF000000000002FF
> > but in candump i got
> > (1387762810.854139) can0 18EF00F9#FA000000000002FF
> > (1387762810.854762) can0 18EFF900#FB0000024733FFFF
> 
> Are you sure you send 18EF01F9?
> Can you show the output of "ip addr show can0" & "ip link show can0"?
> Maybe that gives me a clue.

ubuntu@arm:~/can-j1939-utils$ ip addr show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 
10
    link/can
    can-j1939 0xf9 scope link

ubuntu@arm:~/can-j1939-utils$ ip link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 
10
    link/can
    j1939 on

I am transmitting   00112233445566 from F9 to 01

on ./candump -L can0
(1387763283.287747) can0 18EF00F9#00112233445566


> Kind regards,
> Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 




