From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: c_can driver sometimes sends first two bytes filled with zeros
Date: Mon, 16 May 2016 13:14:32 -0500
Message-ID: <573A0E08.4010008@opensource.altera.com>
References: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
Reply-To: <tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0068.outbound.protection.outlook.com ([157.56.111.68]:9428
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753856AbcEPSYs (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 16 May 2016 14:24:48 -0400
In-Reply-To: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@gomtec.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Richard,

On 05/12/2016 04:23 AM, Richard Andrysek wrote:
> We can reproduce an issue with the canutils. We send messages in the loop with non-zero bytes and from time to time we get first two bytes of the message with zero values. The test script looks so:
>
> #!/bin/sh
>
> echo "Press [CTRL+C] to stop.."
> while true
> do
>                 cansend can1 --loop=15 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
> done
>
> With CAN analyzer we see normally the right message, but in cycles ~1min we see first two bytes are zero.
>
> If we add some delays between messages, like this:
>
> do
>                 cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
>
> done
>
> It works fine.
>
> We use Altera Cyclone V, where the  c_can driver is used. It runs with Linux kernel 3.16, but I've checked 4.5 version of a driver and it is a same one.
>
> Have somebody idea how to find a reason for that?
>
> Richard
>
How old are your canutils? I had a similar issue on an older version of 
cansend (4.0.6 from the Pengutronix site - with a copyright date of 2009).

There is an old thread (http://comments.gmane.org/gmane.linux.can/2339) 
that suggests adding a delay in the cansend utility to work around a 
poll/select bug.

I added a delay for 4.0.6 but you may want to grab the latest from 
github (https://github.com/linux-can/can-utils).

> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
