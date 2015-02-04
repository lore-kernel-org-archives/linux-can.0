From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Standard CAN over IP
Date: Thu, 05 Feb 2015 10:43:32 +1100
Message-ID: <54D2AEA4.30405@optusnet.com.au>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:44498 "EHLO
	mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754702AbbBDXng (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Feb 2015 18:43:36 -0500
In-Reply-To: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mike Purvis <mpurvis@clearpathrobotics.com>, linux-can@vger.kernel.org

On 05/02/15 07:27, Mike Purvis wrote:
> Hi all,
>
> I'm interested in providing low-cost CAN connectivity to a standard
> Mini-ITX PC=E2=80=94 so USB, Ethernet, RS232, PCIe connectivity is av=
ailable,
> but not I2C or SPI (at least easily).

The obvious approach is to use a PCAN-USB. I guess you want something c=
heaper=20
(these are 195 Euros each). Effectively you're making one of these:

http://www.peak-system.com/PCAN-Ethernet-Gateway-DR.330.0.html?&L=3D1

So you have the "Mini-ITX" presumably running Linux, and you want to br=
idge=20
CAN over Ethernet to a Microcontroller that has one or more physical CA=
N ports=20
on it. I would guess the latter doesn't have to run Linux.

I've implemented that sort of thing, but the other way around. We have =
a micro=20
not running Linux with two CAN ports on it. It communicates over UDP wi=
th a=20
small embedded Linux system. The latter provides three CAN ports that a=
re=20
bridged over Ethernet to appear to be "physical" ports on the first one=
=2E Two=20
of those ports are physical ones on the Linux micro, and the third is a=
=20
virtual VCAN port.

So the first micro thinks it has 5 CAN ports. The VCAN bus on the Linux=
 micro=20
allows us to run multiple Linux user programs which can each be configu=
red to=20
either run on a physical CAN port (for some product configurations) or =
on the=20
VCAN bus when they need to be controlled by the other micro over Ethern=
et.

So then you have the question - which device is now in charge of settin=
g the=20
baud rate and the time quanta for these bridged ports? In our case we l=
et the=20
first micro set this up, so there has to be an "Open port and configure=
 it=20
this way" message in the UDP packets together with the Receive and Tran=
smit=20
framing of CAN messages.

We also signal CAN error states back over UDP, so we have Open, Close,=20
Configure, Receive, Transmit and Status messages (and "Transmit Multipl=
e").

You can open one UDP port for all the available CAN buses on a unit, on=
e UDP=20
port for each separate CAN port or a separate UDP port for each CAN ID =
on each=20
bus (which requires setting filters). It all depends on how and where (=
in=20
software) you want to demultiplex the CAN IDs to the relevant programs,=
 and=20
whether you want to pack multiple CAN frames in one UDP packet.

We found it easiest to let VCAN do the demultiplexing, as that's what t=
he=20
SocketCAN interface is very good at.

So we have a user "Bridge" program that receives the UDP frames, interp=
rets=20
them and simply receives and sends to the two physical CAN ports and th=
e VCAN=20
port. The user application programs on the Linux box open connections t=
o the=20
VCAN bus with the appropriate ID filters.

We open one UDP connection with a "port selector" field in each encapsu=
lated=20
CAN message in the UDP packet. That allows us to pack multiple CAN mess=
ages=20
for multiple ports in the one UDP packet. It creates too much overhead =
for=20
both CPUs to put one 8-bytes-of-data CAN message in a=20
1500-bytes-available-with-60-bytes-overhead UDP packet.

Another consideration is that at the hardware level, CAN is a reliable=20
protocol. The message got through or it didn't (unless a software bug o=
r=20
buffer overflow dropped the packet in the receiving device). UDP is the=
=20
UNRELIABLE Datagram Protocol. If this is a problem for your usage you m=
ight=20
want CAN over TCP or you might want to add some error handling or packe=
t retry=20
layer (in other words, try to reinvent TCP all over again).

Another problem is that transmission and reception on physical CAN port=
s can=20
often be timestamped to the microsecond. Some uses of CAN rely on this.=
 When=20
you bridge over Ethernet (and with all the Linux non-real-time problems=
) you=20
get some pretty bad latencies, or at least worse ones than the physical=
 ports=20
provide.

If you have a very busy 1MBit/sec physical CAN bus and you want to conn=
ect=20
your PC to it over the Ethernet bridge, and the PC program is only send=
ing or=20
receiving messages at a low rate, then you probably don't want everythi=
ng on=20
that busy bus to be dumped onto a VCAN bus inside the PC. In that case =
you=20
would want a connection that allows CAN filters on the physical port. H=
ow=20
would you configure that if you needed to?

We're finding that a single 43% busy bridged CAN bus can take up 13% of=
 the=20
total CPU time on our 800MHz ARM CPU.

 > I noticed an interesting past discussion on this topic:

That suggested a user program receiving all packets on VCAN and sending=
 them=20
over UDP and vice versa. That's pretty much what we have.

Tom

