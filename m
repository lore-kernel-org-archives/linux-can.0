From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: skbuff panic
Date: Fri, 11 Jul 2014 09:27:19 -0400
Message-ID: <53BFE637.2030905@hartkopp.net>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com> <53B7D63B.2060108@hartkopp.net> <CANGgnMYu7DOWr5Zy934GkrGW=+FcaVKRCgZejMcugx0DCyN83A@mail.gmail.com> <53B8504C.4070808@hartkopp.net> <CANGgnMZHumyQNz3Z2ULYJWeNaqnbtenbSaL7gm=OwDjPnfdGcw@mail.gmail.com> <53B93D45.5090505@hartkopp.net> <53B97598.50400@hartkopp.net> <53B9A5AD.8050403@pengutronix.de> <CANGgnMZdKsB6WhorMMnLTNTB=rSq78ZEbMkH69x=FxGE_BXyCw@mail.gmail.com> <CANGgnMbb+2OodO7a4L5CSgn2wKTjwbu1tnZ8wAa=5RME_S_Nyw@mail.gmail.com> <CANGgnMY4+PTnkd9CBUSS4EM6ZjP9r1wp8JYDJ4fYv+P1Qg6-vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:59254 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbaGKN1W (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Jul 2014 09:27:22 -0400
In-Reply-To: <CANGgnMY4+PTnkd9CBUSS4EM6ZjP9r1wp8JYDJ4fYv+P1Qg6-vg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Thanks for testing, Austin!

I'll cook a patch for stable to add these settings.
Even if we do not know why someone requests obviously all netdev skbs and 
treats them to be Ethernet/IP packets we should fix it in our code.

If we fix it somewhere else it will last one year until some of the 
is-there-anything-else-than-ethernet-networking guys will break it again. ;-)

Best regards,
Oliver

On 10.07.2014 13:37, Austin Schuh wrote:
> On Wed, Jul 9, 2014 at 5:07 PM, Austin Schuh <austin@peloton-tech.com> wrote:
>> With Oliver's patch, I'm able to get to 60 reboots and counting, so it
>> looks like that was the problem.  I'll leave it rebooting over night
>> to be sure.
>
> The machine survived 216 reboots with no panics over the night.  Thanks Oliver!
>
> Tested-by: Austin Schuh <austin@peloton-tech.com>
>
