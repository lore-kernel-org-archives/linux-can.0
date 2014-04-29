From: "Ratheendran S. Rajeshwaran" <ba.rsrajeshwaran@tataelxsi.co.in>
Subject: RE: detect auto baud rate on can bus in linux driver.
Date: Tue, 29 Apr 2014 08:35:15 +0000
Message-ID: <1398760456201.28136@tataelxsi.co.in>
References: <53590FB6.6090707@tataelxsi.co.in>
 <20140427094418.GB28319@griso.site>,<20140427180135.GB21176@vandijck-laurijssen.be>,<1398760380297.91253@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-sg1lp0094.outbound.protection.outlook.com ([207.46.51.94]:47296
	"EHLO APAC01-SG1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932739AbaD2IfU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Apr 2014 04:35:20 -0400
In-Reply-To: <1398760380297.91253@tataelxsi.co.in>
Content-Language: en-IN
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


Thanks John , Kurt  for your valuable support.

I am going ahead with the shell script & iproute2 supported tool testing a set of fixed baud rate from table.

My observations with the existing imx6 flexcan hardware running linux 3.0.x.

Two imx6 board ,both are enabled for FLEXCAN  communication.
CAN dev bring up command with baud rate.
command -> ip link set can0 up type can bitrate 125000
one board run cansend while other end candump--e command


Case 1 both imx6 operate on same CAN baudrate
  cansend can0 -i0x100 11 22 33 44
  on candump terminal I receive  <0x100> [4] 0b 16 21 2c

I do  ip -details -statistics link show can0
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 250000 sample-point 0.866
    tq 266 prop-seg 6 phase-seg1 6 phase-seg2 2 sjw 1
    flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
    clock 30000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          5          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    40         5        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    32         8        0       2       0       0

  Case 2: imx6 CAN on different baud rate.
 received packets( I am not able to interpret the below packet)
 <0x004> [8] 00 04 00 00 00 00 00 00
 ip -details -statistics link show can0
 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT qlen 10
    link/can
    can state ERROR-WARNING (berr-counter tx 0 rx 128) restart-ms 0
    bitrate 250000 sample-point 0.866
    tq 266 prop-seg 6 phase-seg1 6 phase-seg2 2 sjw 1
    flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
    clock 30000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          14         1          0
    RX: bytes  packets  errors  dropped overrun mcast
    144        22       0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0

I am wondering a shell script setting the different baud rate and then checking the can status to decide the correct baud rate.
our custom application need two can bus,one raw and other j1939.in case of j1939 I will use iproute2-j1939 and can-utility for j1939.

is there any better approach to do it,I am open for better Ideas.

Regards,
Ratheendran

________________________________________
From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Sent: 27 April 2014 23:31
To: Ratheendran S. Rajeshwaran
Cc: John Whitmore; linux-can@vger.kernel.org
Subject: Re: detect auto baud rate on can bus in linux driver.

Hey,

On Sun, Apr 27, 2014 at 10:44:22AM +0100, John Whitmore wrote:
> On Thu, Apr 24, 2014 at 06:50:54PM +0530, Ratheendran wrote:
> > Hi All,
> >
> > Need you help in understanding detecting auto baud rate of CAN bus.
> > please share your valuable experience.

The baudrate detection principle is: configure your CAN chip, and if you receive
something, then the baudrate was good. This can only work when there is traffic.
The CAN chip should be set in a mode that does not disturb the bus.
This mode is called 'listen-only' for CAN.

Be sure to read
http://www.can-cia.org/fileadmin/cia/files/icc/9/koppe.pdf
I did only read it quickly, and it appears most items have been explained
a bit.

John Whitmore explained his scenario very well.
I just want to add some comments with special regard to linux.

> >
> > I am using imx6 processor which has flexcan hardware driver
> > implemented as socketcan stack.
> >

Theoretically/ideally, all linux-can drivers behave the same.
Practically, a required feature for baudrate detection on CAN is
the listen-only mode. linux-can provides the API, but not all
drivers/devices support it.
Look into the code for CAN_CTRLMODE_LISTENONLY. My 3.12 tree flexcan driver
seems to support it, but I clearly did not test with real hardware.

>
> I've used auto baud rate detection with the Microchip MCP2515 CAN Controller
> connected to a PIC controller, but not with Linux, as yet.

> I'm working on my
> own CAN Bus network so have control of all the nodes. There is a "Ping"
> Protocol built into the nodes so that if there is no network traffic in a
> certain period of time a random node will fire a "Ping" frame onto the CAN
> Bus. That way I'm guaranteed that there will be network traffic to listen to.
>
> In addition to network traffic my network uses a fixed number of baud rates:
>
> 10K, 20K, 50K, 125K, 250K, 500, 800K, and 1M
>
> Now given all that on the network I simply set the MCP2515 into listen only
> mode at a baud rate of 10K. If the Ping message is set for 10 seconds and I
> listen for 30 Seconds I should at least get 3 CAN Frames. If I've got the
> wrong baud rate I'll get MERRE errors in listen mode. My driver simply, when
> in listen mode, counts received good frames and errors. If after 30 seconds
> I've got good frames and no errors then I've found the baud rate being used by
> the network and I can drop out of listen mode. If there are any errors then
> simply move up to the next baud rate and start listening again.
>
> This all works for me as I'm assured of traffic and have a limited number of
> baud rates to search through.
>
> I keep meaning to look at this on Linux but I've been distracted with other
> work. I'll get back to it. Not sure how it would fit into the Linux can
> architecture.

Autobaud is, IMO, a userspace thing.
The principle has been explained, and with iproute2 & candump piping into
grep or wc, you could even make a shell script for that.

> The Driver code would have to count errors and userspace would
> have to look at the results and change baud rate, or connect.
>
> Hope that's of some help.
>
> > With Regards,
> > Ratheendran

Kurt

