From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can-utils: Add exact CAN frame length calculation (including
 bitstuffing)
Date: Sat, 25 Jan 2014 16:19:53 +0100
Message-ID: <52E3D619.4070702@hartkopp.net>
References: <1390571983-16040-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:11119 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbaAYPT4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 25 Jan 2014 10:19:56 -0500
In-Reply-To: <1390571983-16040-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Sojka <sojkam1@fel.cvut.cz>, linux-can@vger.kernel.org

Hello Michal,

On 24.01.2014 14:59, Michal Sojka wrote:
> This adds an algorithm for calculating the exact number of bits a CAN
> frame occupies on the bus and uses this algorithm in canbusload.


> +++ b/canframelen.h
> @@ -0,0 +1,8 @@
> +#ifndef CANFRAMELEN_H
> +#define CANFRAMELEN_H
> +
> +#include <linux/can.h>
> +
> +unsigned can_frame_length(struct can_frame *frame);
> +
> +#endif
> 

I would suggest two things:

1. Add some comment about the function (e.g. that it returns the length in
bits with/without inter frame gap).

2. I would prefer to add some calculation mode identifier here and provide all
calculation modes in canframelen.c

Including this stuff and it's comments:

https://gitorious.org/linux-can/can-utils/source/canbusload.c#L375

E.g. some

enum {
	NO_BITSTUFFING, /* plain bit calculation without bitstuffing */
	BITSTUFFING, /* with bitstuffing following Tindle estimation */
	PRECISE, /* precise calculation including bitstuffing in CRC */
}

To be future proof with CAN I would suggest to add some CAN / CAN FD switch.

E.g.

unsigned can_frame_length(struct canfd_frame *cfd, int mode, int mtu);

Where mtu is CAN_MTU or CANFD_MTU to distinguish the frame types.
In the first step supporting CAN_MTU would be sufficient.
As a return value of zero always shows a problem this can be used to indicated
unsupported calculation modes/frame types.

Regards,
Oliver
