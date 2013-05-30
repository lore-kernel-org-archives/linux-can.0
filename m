From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: RxFilter issues vcan
Date: Thu, 30 May 2013 06:58:18 +0200
Message-ID: <51A6DC6A.7020609@hartkopp.net>
References: <51A66B55.6080506@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:55483 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab3E3E6V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 May 2013 00:58:21 -0400
In-Reply-To: <51A66B55.6080506@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hi Sebastian,

On 29.05.2013 22:55, Sebastian Haas wrote:
> Hello everybody,
> 
> I played a bit with the RxFilters and noticed that they are behaving somewhat
> strange.
> 
> If I start candump this way:
> sh@helios:~/workspace/node-can$ candump vcan0,100~7ff,101~7ff
>  I want to receive any messages except 100h and 101h.
> 
> When I send a message which matches the filter, it is received twice:
> sh@helios:~/workspace/node-can$ cansend vcan0 1ff#22
>   vcan0  1FF   [1]  22
>   vcan0  1FF   [1]  22
> 
> When I send a message which should not received at all, it is received:
> sh@helios:~/workspace/node-can$ cansend vcan0 100#22
>   vcan0  100   [1]  22
> 
> Did I misunderstood the filter here?

The filters are independent and therefore "logical OR".

The 1st filter stops 100
The 2nd filter stops 101

But the second filter lets 100 pass.

If you want to remove 100 and 101, try:

candump vcan0,100~7FE

Or even better

candump vcan0,100~C00007FE

If you want to make sure to get only SFF frames without RTR.

Regards,
Oliver


