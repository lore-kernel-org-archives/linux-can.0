From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: introduce CANFD_FDF flag for mixed content in struct
 canfd_frame
Date: Fri, 14 Apr 2017 16:26:46 +0200
Message-ID: <2d7a3280-97f4-16e4-8422-af289429fa86@hartkopp.net>
References: <20170411134343.3089-1-socketcan@hartkopp.net>
 <be5e8910-a98f-51a8-3c2a-8fd61e676025@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:9709 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbdDNO1X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Apr 2017 10:27:23 -0400
In-Reply-To: <be5e8910-a98f-51a8-3c2a-8fd61e676025@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 04/14/2017 03:04 PM, Marc Kleine-Budde wrote:
> On 04/11/2017 03:43 PM, Oliver Hartkopp wrote:
>> The struct can_frame and struct canfd_frame intentionaly share the same
>> layout to be able to write CAN frame content into a CAN FD frame structure.
>> When this is done the former differentiation via CAN_MTU / CANFD_MTU gets
>> lost. CANFD_FDF allows programmers to mark CAN FD frames in the case of
>> using struct canfd_frame for mixed CAN / CAN FD content (dual use).
>> N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content inside of
>> struct canfd_frame therefore the CANFD_FDF flag is disregarded by Linux.
>
> Sorry, I don't get the usecase. Who will evaluate this bit? The
> userspace, when using vcan? What does it mean, when this bit is set?
> That we have a CAN frame within a struct canfd_frame?

The latter - but the other way around.

I did a SocketCAN presentation at AGL last week

https://wiki.automotivelinux.org/agl-distro/apr2017-f2f

See slides 51 - 55 from this PDF at

https://wiki.automotivelinux.org/_media/agl-distro/agl2017-socketcan-print.pdf

The point is on the last of the five slides

struct canfd_frame cframe;
int s = socket(PF_CAN, SOCK_DGRAM, CAN_RAW);
setsockopt(s, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, ...);
(..)
nbytes = read(s, &cframe, sizeof(struct canfd_frame));

You can get CAN frames and CAN FD frames here.

The distinction is represented in the value of nbytes which can be 
CAN_MTU (16) or CANFD_MTU (72).

The problem is that from this moment you have to take the nbytes value 
*along* with the struct canfd_frame to know what it contains.

E.g. in candump.c a variable maxdlen is used

https://github.com/linux-can/can-utils/blob/master/candump.c#L661

which then has to be passed to all following function calls e.g.

https://github.com/linux-can/can-utils/blob/master/lib.h#L149

Imagine how you can simplify the handling of mixed content stored into 
struct canfd_frame with this new bit.

Of course every CAN(FD) application programmer could define this bit in 
a private way - but you don't know whether the crazy kernel hackers use 
this bit position in a different way some day.

So this is more or less a reservation to help CAN application 
programmers to be able to carry the CANFD format information within the 
struct canfd_frame.

Regards,
Oliver
