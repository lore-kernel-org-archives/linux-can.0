From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Destination address corruption
Date: Thu, 17 Apr 2014 22:26:24 +0200
Message-ID: <20140417202624.GB12665@vandijck-laurijssen.be>
References: <loom.20140409T155830-71@post.gmane.org>
 <20140409195225.GE15221@vandijck-laurijssen.be>
 <loom.20140410T043630-197@post.gmane.org>
 <20140411083515.GC449@vandijck-laurijssen.be>
 <loom.20140417T051930-483@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:20858 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750893AbaDQU0a (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 16:26:30 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140417T051930-483@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

On Thu, Apr 17, 2014 at 03:39:35AM +0000, swapnil wrote:
> Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:
> 
> > 
> > Hey,
> > 
> > On Thu, Apr 10, 2014 at 02:49:21AM +0000, swapnil wrote:
> > > Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:
> > > 
> > > > 
> > > > Hey,
> > > > 
> > > > part 2 ...
> > > > 
> > > > On Wed, Apr 09, 2014 at 02:17:11PM +0000, swapnil wrote:
> > > > > Hi All,
> > > > > 
> > > > >         Hey Kurt I am using the J1939 stack on begalbone 
> > > > > I am halfway through. I am getting some issue while testing with 
> > > different 
> > > > > engine control modules
> > > > > 
> > > > 
> > > > [...]
> > > > 
> > > > > 
> > > > > 2.if There is only one device connected on the bus like 
> > > Begalbone(address -
> > > > > f9) and Engine control module(address -00) 
> > > > >      if i send a message to address 01 or 02 on can bus i see 
> message 
> > > for 01 
> > > > > is converted to address 00 
> > > > > like i amsending 18EF01F9#FF000000000002FF
> > > > > but in candump i got
> > > > > (1387762810.854139) can0 18EF00F9#FA000000000002FF
> > > > > (1387762810.854762) can0 18EFF900#FB0000024733FFFF
> > > > 
> > > > Are you sure you send 18EF01F9?
> > > > Can you show the output of "ip addr show can0" & "ip link show can0"?
> > > > Maybe that gives me a clue.
> > > 
> > > ubuntu <at> arm:~/can-j1939-utils$ ip addr show can0
> > > 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN 
> qlen 
> > > 10
> > >     link/can
> > >     can-j1939 0xf9 scope link
> > > 
> > > ubuntu <at> arm:~/can-j1939-utils$ ip link show can0
> > > 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN 
> qlen 
> > > 10
> > >     link/can
> > >     j1939 on
> > > 
> > > I am transmitting   00112233445566 from F9 to 01
> > > 
> > > on ./candump -L can0
> > > (1387763283.287747) can0 18EF00F9#00112233445566
> > 
> > To be honest, I have no clue yet.
> > Can you verify the bind() & sendto() related code, so to make sure
> > you actually apply destination address 01?
> > 
> > Next stop would be to try my j1939 test program that I sent you earlier.
> > 
> > Kind regards,
> > Kurt
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> Yes, I think I am doing something wrong in my code not able to figure out 
> yet .. 
> Following is the output tested by your program which is working correct
>  
> Following is the output from j1939 test program that u send
> 00 is the address of other device on the bus 
> message broadcast by that device is 
> 1.(1387769780.206999) can0 18EEFF00#1122334444332211 address claim request 
> on candump
> 
> 2. can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN 
> qlen10      
>     link/can
>     can-j1939 0xf9 scope link  address claimed by begalbone ( can_j1939 
> linux module)
> 
> 3.root@arm:/home/ubuntu/can-j1939-utils# ./testj1939 -s20 can0:0xf9 
> :0x00,0x12300
> - socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
> - bind(, can0:f9,,, 24);
> - sendto(, <dat>, 20, 0, :00,12300,, 24);
>   candump log
> (1387770757.753292) can0 18EC00F9#1014000303002301
> (1387770757.754066) can0 1CECF900#110301FFFF002301
> (1387770757.754829) can0 18EB00F9#0100000000010000
> (1387770757.755900) can0 18EB00F9#020050ACFBB60000
> (1387770757.756985) can0 18EB00F9#03000000000000
> (1387770757.757681) can0 1CECF900#13140003FF002301
> 
> 4.root@arm:/home/ubuntu/can-j1939-utils# ./testj1939 -s20 can0:0xf9 
> :0x90,0x12300
> - socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
> - bind(, can0:f9,,, 24);
> - sendto(, <dat>, 20, 0, :90,12300,, 24);
> (1387770765.594972) can0 18EC90F9#1014000303002301
> (1387770766.850045) can0 18EC90F9#FF03FFFFFF002301
> 
> Thanks for suggestion to test with ur code 
>   Hens forth i will test it with ur code before sending

You're welcome.
2 brains know more than 1 :-)

> 
> ****
> can u share the document on how to set filters.
> right now i am using my code for filtering the pgn and da
> I tried to use the filters but failed as i am not sure how to set them..

jacd.c in can-utils-j1939 contains an example of PGN filtering.
DA filtering is not supported, since only messages for your node
will be received through a socket, i.e. messages with your SA in DA,
or broadcasted messages.

You can do SA filtering, which works similarly to PGN filtering.
Just take a look at struct j1939_filter.

Kind regards,
Kurt
