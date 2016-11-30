From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: wrong CAN frame order in network layer due to SMP?
Date: Wed, 30 Nov 2016 08:23:41 +0100
Message-ID: <2577568.MH2UfL0Ils@ws-stein>
References: <1864402.pXgGBBp51L@ws-stein> <5633679.WId9jP25Qd@ws-stein> <45353231-7efa-7feb-b52d-569a88317cdf@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:37297 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751566AbcK3HXw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Nov 2016 02:23:52 -0500
In-Reply-To: <45353231-7efa-7feb-b52d-569a88317cdf@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Daniel =?ISO-8859-1?Q?Kr=FCger?= <daniel.krueger@systec-electronic.com>

On Tuesday 29 November 2016 20:48:09, Oliver Hartkopp wrote:
> Hello Alexander,
> 
> On 11/29/2016 11:30 AM, Alexander Stein wrote:
> > On Monday 28 November 2016 21:36:09, Oliver Hartkopp wrote:
> >> IIRC Wireshark puts the PF_PACKET socket into some special 'tpacket'
> >> mode and I don't know whether this has any impact on frame ordering.
> >> 
> >> At least you may check for:
> >> https://github.com/linux-can/can-tests/blob/master/tst-packet.c
> >> 
> >> ... if there's a difference between PF_PACKET and PF_CAN with your OOO
> >> setup.
> > 
> > Nope, apparently there is no difference. Got similar results.
> > 
> > On a side note: I captured an 30 seconds iperf3 run with wireshark 2.2.2
> > using the "ASIX Electronics Corp. AX88179 Gigabit Ethernet" adapter
> > (driver: ax88179_178a).
> > AFAICS this driver (well usbnet in the end) doesn't use NAPI either and
> > therefore unsurprisingly I got OOO of TCP frames.
> > IMHO this is not acceptable at all.
> 
> Did you have a TCP socket on the receiving host as endpoint for your
> communication?

Yep. straight iperf3 run. Here is a snippet from the wireshark capture:
  82102 0.759823467    192.168.8.7           192.168.8.128         TCP      34564→5201 [ACK] Seq=79054502 Ack=1 Win=29312 Len=1448 TSval=409657 TSecr=411321992
  82103 0.759823627    192.168.8.7           192.168.8.128         TCP      34564→5201 [ACK] Seq=79055950 Ack=1 Win=29312 Len=1448 TSval=409657 TSecr=411321992
  82104 0.759831475    192.168.8.128         192.168.8.7           TCP      5201→34564 [ACK] Seq=1 Ack=79057398 Win=677760 Len=0 TSval=411321994 TSecr=409657
  82105 0.759823818    192.168.8.7           192.168.8.128         TCP      34564→5201 [ACK] Seq=79057398 Ack=1 Win=29312 Len=1448 TSval=409657 TSecr=411321992
  82106 0.759823894    192.168.8.7           192.168.8.128         TCP      34564→5201 [ACK] Seq=79058846 Ack=1 Win=29312 Len=1448 TSval=409657 TSecr=411321992
  82107 *REF*          192.168.8.128         192.168.8.7           TCP      5201→34564 [ACK] Seq=1 Ack=79060294 Win=677760 Len=0 TSval=411321994 TSecr=409657
  82108 -0.000012137   192.168.8.7           192.168.8.128         TCP      [TCP Out-Of-Order] 34564→5201 [ACK] Seq=78738838 Ack=1 Win=29312 Len=1448 TSval=409657 TSecr=411321992
  82109 0.000003981    192.168.8.128         192.168.8.7           TCP      [TCP Dup ACK 82107#1] 5201→34564 [ACK] Seq=1 Ack=79060294 Win=677760 Len=0 TSval=411321994 TSecr=409657 SLE=78738838 SRE=78740286
  82110 -0.000011999   192.168.8.7           192.168.8.128         TCP      [TCP Out-Of-Order] 34564→5201 [ACK] Seq=78740286 Ack=1 Win=29312 Len=1448 TSval=409657 TSecr=411321992
  82111 0.000007932    192.168.8.128         192.168.8.7           TCP      [TCP Dup ACK 82107#2] 5201→34564 [ACK] Seq=1 Ack=79060294 Win=677760 Len=0 TSval=411321994 TSecr=409657 SLE=78740286 SRE=78741734
  82112 0.000066782    192.168.8.7           192.168.8.128         TCP      [TCP Out-Of-Order] 34564→5201 [ACK] Seq=78741734 Ack=1 Win=29312 Len=1448 TSval=409657 TSecr=411321992
  82113 0.000069480    192.168.8.128         192.168.8.7           TCP      [TCP Dup ACK 82107#3] 5201→34564 [ACK] Seq=1 Ack=79060294 Win=677760 Len=0 TSval=411321995 TSecr=409657 SLE=78741734 SRE=78743182
  82114 0.000066949    192.168.8.7           192.168.8.128         TCP      [TCP Out-Of-Order] 34564→5201 [ACK] Seq=78743182 Ack=1 Win=29312 Len=1448 TSval=409657 TSecr=411321992
  82115 0.000071730    192.168.8.128         192.168.8.7           TCP      [TCP Dup ACK 82107#4] 5201→34564 [ACK] Seq=1 Ack=79060294 Win=677760 Len=0 TSval=411321995 TSecr=409657 SLE=78743182 SRE=78744630

192.168.8.128 is the receiver
192.168.8.128 is the sender
direct connection without any switch
TCP is used
I put a time ref at packet 82107 so you can see more easily the negative relative timestamp of some following packets.

> Maybe this could be named a 'general regression' then. And when this is
> fixed our problem hopefully gets fixed too ;-)

I guess the network guys will also say: Use NAPI. IMHO there shouldn't be an API which allows OOO in the first place.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010

