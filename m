From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Several patches mainline status
Date: Fri, 14 Apr 2017 17:48:31 +0200
Message-ID: <92ee7e98-d08a-54bc-7f12-9c85ce77142d@hartkopp.net>
References: <c764c3d1-6248-0273-5c20-b401051c818a@hartkopp.net>
 <11876946-e619-3141-af51-b1c98ac3ace5@hartkopp.net>
 <7bd99678-d8f5-390e-833a-7bb2738caec7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:25053 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdDNPsf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Apr 2017 11:48:35 -0400
In-Reply-To: <7bd99678-d8f5-390e-833a-7bb2738caec7@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 04/14/2017 05:22 PM, Marc Kleine-Budde wrote:
> On 04/11/2017 03:53 PM, Oliver Hartkopp wrote:

>> And now (brandnew):
>> [PATCH] can: introduce CANFD_FDF flag for mixed content in struct
>> canfd_frame
>> STATUS: Was sitting for some time on my box. NVIDIA is doing similar
>> stuff in their BSP for their Drive PX2
>> http://marc.info/?l=linux-can&m=149191823322125&w=2
>
> Please explain the usecase more, I don't get it.

It's a convenience bit reservation for CAN application programmers.

Maybe we could name it CANFD_FDRES instead of CANFD_FDF - but I've 
already seen code (from NVIDIA) where people introduce this bit for 
their own to simplify their user space code.

If you would have done CAN FD programming on your own you probably would 
have felt the pain yourself ...

Or what is your concrete concern I can try to explain better?

Regards,
Oliver
