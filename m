From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 09 Jul 2012 19:08:37 +0200
Message-ID: <4FFB1015.2000507@hartkopp.net>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <201207091519.04235.pisa@cmp.felk.cvut.cz> <20120709144042.GA2671@vandijck-laurijssen.be> <23562188.349Ls0e8RT@ws-stein> <CABMxt4iBB4aP6STAbYcgCYyvOx-JAPnP48P1k=EMGsjQPmWN-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:36186 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab2GIRIb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 13:08:31 -0400
In-Reply-To: <CABMxt4iBB4aP6STAbYcgCYyvOx-JAPnP48P1k=EMGsjQPmWN-Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Wolfgang Grandegger <wg@grandegger.com>, Linux-CAN <linux-can@vger.kernel.org>

On 09.07.2012 17:39, Mohamed HAMZAOUI wrote:

>> I compared itimer with clock_nanosleep on an ARM board and noticed the signal
>> overhead of itimer is much bigger, resulting in a higher CPU usage, than
>> clock_nanosleep upon hrtimer.
>> So I ended up using clock_nanosleep adding a constant to the last timeout.
> 
> but my problem is that when i specify 1 ms of period i have 1.3ms and
> the problem is how to eliminate the 0.3ms. If i substitute 0.3 ms from
> all payload, what's the assurance that it does not change with CPU
> load  change ?
> 


Hello Mohamed,

have you ever tried your test with a virtual CAN interface?

http://lxr.linux.no/#linux+v3.4.4/Documentation/networking/can.txt#L606

#> modprobe vcan
#> ip link add dev vcan0 type vcan
#> ifconfig vcan0 up
#> cangen vcan0

gives on my second terminal somthing like this:

#> candump -td any
 (000.000000)  vcan0  595  [3] ED 26 C7
 (000.200149)  vcan0  105  [1] CF
 (000.200149)  vcan0  346  [8] F7 4F 39 1D AD F5 76 30
 (000.200184)  vcan0  1BC  [8] DC E8 0E 19 26 9C 7E 33
 (000.200142)  vcan0  685  [4] 52 9B 56 50
 (000.200147)  vcan0  446  [2] 5F FF
 (000.200149)  vcan0  208  [8] F5 42 36 0C 5E CD AD 4A
 (000.200141)  vcan0   8D  [2] 0F 22
 (000.200143)  vcan0  4D5  [8] 2E 87 7E 11 DA ED 43 61
 (000.200143)  vcan0  38E  [8] 67 AD 44 27 D4 1E B0 0B
(..)

cangen generates a frame every 200ms (see cangen -?) and 'candump -td any'
prints the delta timestamps. As cangen arms the timer after the frame has been
sent, the cycle is ~145 us away from the default of 200ms.


When using the in-kernel hrtimers by utilizing the broadcast manager (can_bcm)
with the tst-bcm-cycle test tool
(see http://svn.berlios.de/wsvn/socketcan/trunk/test/tst-bcm-cycle.c)

it looks like this:

#> candump -td any
 (000.000000)  vcan2   42  [8] EF BE AD DE EF BE AD DE
 (000.004206)  vcan2   42  [8] EF BE AD DE EF BE AD DE
 (000.500061)  vcan2   42  [8] EF BE AD DE EF BE AD DE
 (000.500068)  vcan2   42  [8] EF BE AD DE EF BE AD DE
 (000.500059)  vcan2   42  [8] EF BE AD DE EF BE AD DE
 (000.500057)  vcan2   42  [8] EF BE AD DE EF BE AD DE
 (000.500072)  vcan2   42  [8] EF BE AD DE EF BE AD DE
 (000.500062)  vcan2   42  [8] EF BE AD DE EF BE AD DE
 (000.500070)  vcan2   42  [8] EF BE AD DE EF BE AD DE
(..)

so with the bcm you have a delay of ~60us.

Here also the timer is armed after the frame is send with bcm_tx_op() see:
http://lxr.linux.no/#linux+v3.4.4/net/can/bcm.c#L356

Additionally the tasklet is invoked by the hrtimer in bcm_tx_timeout_handler()
some lines below.

But both of these offsets is are far away from your measurements.

Can you confirm these values with the virtual CAN interface on your system?
FYI my values have been picked on a core i7 M 640 @ 2.80GHz notebook ...

Regards,
Oliver
