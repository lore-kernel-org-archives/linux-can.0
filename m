From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Transport Protocol: example
Date: Tue, 28 Feb 2012 11:46:05 +0100
Message-ID: <20120228104605.GA495@e-circ.dyndns.org>
References: <loom.20120113T122554-557@post.gmane.org>
 <loom.20120116T103812-141@post.gmane.org>
 <20120116133140.GA26427@e-circ.dyndns.org>
 <loom.20120116T153805-349@post.gmane.org>
 <20120116153644.GA7763@e-circ.dyndns.org>
 <loom.20120207T160415-497@post.gmane.org>
 <20120208084602.GA412@e-circ.dyndns.org>
 <loom.20120216T104829-444@post.gmane.org>
 <20120216194911.GA447@e-circ.dyndns.org>
 <loom.20120224T154038-289@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:14381 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab2B1KqK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 28 Feb 2012 05:46:10 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120224T154038-289@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Wagner <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Fri, Feb 24, 2012 at 03:23:10PM +0000, Wolfgang Wagner wrote:
> Hi Kurt,
> 
> I try to bridge a Multi Packet Message. 
> 
> 
> I set can0 on j1939 and started it
> 
> $echo can0 > /proc/net/can-j1939/net
> $ip link set can0 up type can bitrate 500000
> $ip addr add j1939 0x00 dev can0
> 
> I am still working with the simulator software.
> Now sent the TP.CM 0x1CEC009F 0x16 0x00 0xF0 0x30 0xFF 0x00 0xEE 0x00
> 

I setup a demo using $ jsr.
So I did:

$ ip link add vcan0 type vcan
# equivalent of $ echo vcan0 > /proc/net/can-j1939/net on pre-2.6.3? kernel
$ ip link set vcan0 j1939 on
$ ip addr add j1939 0x80 dev vcan0
$ ip addr add j1939 0x00 dev vcan0

I now will send & receive by the same box over a virtual CAN bus.
This was much easier to run a simulation :-)

So I did:
$ jsr vcan0:80,00ee00 :00 < moose.txt (dummy text file)

with candump:
 (000.000000)  vcan  18EC0080  [8] 10 60 00 0E 0E 00 EE 00
 (000.000092)  vcan  18EC8000  [8] 11 0E 01 FF FF 00 EE 00
 (000.000139)  vcan  18EB0080  [8] 01 5C 5F 5C 5F 20 20 20
 (000.000151)  vcan  18EB0080  [8] 02 20 5F 2F 5F 2F 0A 20
 (000.000162)  vcan  18EB0080  [8] 03 20 20 20 5C 5F 5F 2F
 (000.000174)  vcan  18EB0080  [8] 04 0A 20 20 20 20 28 30
 (000.000185)  vcan  18EB0080  [8] 05 30 29 5C 5F 5F 5F 5F
 (000.000196)  vcan  18EB0080  [8] 06 5F 5F 5F 0A 20 20 20
 (000.000207)  vcan  18EB0080  [8] 07 20 28 5F 5F 29 5C 20
 (000.000219)  vcan  18EB0080  [8] 08 20 20 20 20 20 20 29
 (000.000230)  vcan  18EB0080  [8] 09 5C 2F 5C 0A 20 20 20
 (000.000242)  vcan  18EB0080  [8] 0A 20 20 20 20 20 7C 7C
 (000.000253)  vcan  18EB0080  [8] 0B 2D 2D 2D 2D 57 20 7C
 (000.000265)  vcan  18EB0080  [8] 0C 0A 20 20 20 20 20 20
 (000.000275)  vcan  18EB0080  [8] 0D 20 20 7C 7C 20 20 20
 (000.000288)  vcan  18EB0080  [6] 0E 20 20 7C 7C 0A
 (000.000604)  vcan  18EC8000  [8] 13 60 00 0E FF 00 EE 00

I now realize I was a bit fast in my previous post by saying you send
0xf0 bytes, since you tried to send 0xf000 bytes, which is only
possible with the extended transport protocol as defined in
iso11783-6 (and supported by your kernel).

I also used PGN 0x00ee00, which I already said was not a good idea, but
it may not fail the demonstration ...

To make the story complete, I also did a broadcasted transport protocol.
$ jsr vcan0:80,00ee00 < moose.txt
Note the timestamps! A broadcasted session may only send a packet each 50 msec.

 (000.000000)  vcan  18ECFF80  [8] 20 60 00 0E FF 00 EE 00
 (000.050133)  vcan  18EBFF80  [8] 01 5C 5F 5C 5F 20 20 20
 (000.100178)  vcan  18EBFF80  [8] 02 20 5F 2F 5F 2F 0A 20
 (000.150217)  vcan  18EBFF80  [8] 03 20 20 20 5C 5F 5F 2F
 (000.200259)  vcan  18EBFF80  [8] 04 0A 20 20 20 20 28 30
 (000.250298)  vcan  18EBFF80  [8] 05 30 29 5C 5F 5F 5F 5F
 (000.300338)  vcan  18EBFF80  [8] 06 5F 5F 5F 0A 20 20 20
 (000.350379)  vcan  18EBFF80  [8] 07 20 28 5F 5F 29 5C 20
 (000.400423)  vcan  18EBFF80  [8] 08 20 20 20 20 20 20 29
 (000.450465)  vcan  18EBFF80  [8] 09 5C 2F 5C 0A 20 20 20
 (000.500508)  vcan  18EBFF80  [8] 0A 20 20 20 20 20 7C 7C
 (000.550552)  vcan  18EBFF80  [8] 0B 2D 2D 2D 2D 57 20 7C
 (000.600598)  vcan  18EBFF80  [8] 0C 0A 20 20 20 20 20 20
 (000.650642)  vcan  18EBFF80  [8] 0D 20 20 7C 7C 20 20 20
 (000.700688)  vcan  18EBFF80  [6] 0E 20 20 7C 7C 0A

I believe that these examples may answer a lot of your questions :-).

Kurt

> 
> Now it responses with this:
> 0X1CEC9F00 0xFF 0x05 0xFF 0xFF 0xFF 0x00 0xEE 0x00
> 
> and I get this message:
> $j1939xtp_rx_bad_message, pgn 0ee00
> $j1939xtp_rx_abort 2, 0ee00
> 
> 
> I am pretty sure I did something wrong, can you please correct?
> 
> Is it possible if everything is done right to bridge the TP.CM and TP.DT
> directly with the previous implementation?
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
