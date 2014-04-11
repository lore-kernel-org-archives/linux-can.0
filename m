From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Destination address corruption
Date: Fri, 11 Apr 2014 10:35:15 +0200
Message-ID: <20140411083515.GC449@vandijck-laurijssen.be>
References: <loom.20140409T155830-71@post.gmane.org>
 <20140409195225.GE15221@vandijck-laurijssen.be>
 <loom.20140410T043630-197@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:64332 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755673AbaDKIfT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:35:19 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140410T043630-197@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

Hey,

On Thu, Apr 10, 2014 at 02:49:21AM +0000, swapnil wrote:
> Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:
> 
> > 
> > Hey,
> > 
> > part 2 ...
> > 
> > On Wed, Apr 09, 2014 at 02:17:11PM +0000, swapnil wrote:
> > > Hi All,
> > > 
> > >         Hey Kurt I am using the J1939 stack on begalbone 
> > > I am halfway through. I am getting some issue while testing with 
> different 
> > > engine control modules
> > > 
> > 
> > [...]
> > 
> > > 
> > > 2.if There is only one device connected on the bus like 
> Begalbone(address -
> > > f9) and Engine control module(address -00) 
> > >      if i send a message to address 01 or 02 on can bus i see message 
> for 01 
> > > is converted to address 00 
> > > like i amsending 18EF01F9#FF000000000002FF
> > > but in candump i got
> > > (1387762810.854139) can0 18EF00F9#FA000000000002FF
> > > (1387762810.854762) can0 18EFF900#FB0000024733FFFF
> > 
> > Are you sure you send 18EF01F9?
> > Can you show the output of "ip addr show can0" & "ip link show can0"?
> > Maybe that gives me a clue.
> 
> ubuntu@arm:~/can-j1939-utils$ ip addr show can0
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 
> 10
>     link/can
>     can-j1939 0xf9 scope link
> 
> ubuntu@arm:~/can-j1939-utils$ ip link show can0
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 
> 10
>     link/can
>     j1939 on
> 
> I am transmitting   00112233445566 from F9 to 01
> 
> on ./candump -L can0
> (1387763283.287747) can0 18EF00F9#00112233445566

To be honest, I have no clue yet.
Can you verify the bind() & sendto() related code, so to make sure
you actually apply destination address 01?

Next stop would be to try my j1939 test program that I sent you earlier.

Kind regards,
Kurt
