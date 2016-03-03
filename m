From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH V4 1/4] net: can: ifi: Fix clock generator configuration
Date: Thu, 03 Mar 2016 22:29:48 +0100
Message-ID: <56D8ACCC.1020805@denx.de>
References: <1457034358-5515-1-git-send-email-marex@denx.de> <1457034358-5515-2-git-send-email-marex@denx.de> <56D89C1F.9060504@hartkopp.net> <56D8A41B.80508@denx.de> <56D8A573.4010208@hartkopp.net> <56D8A621.3040404@pengutronix.de> <56D8A65C.7060803@pengutronix.de> <56D8A6F2.5090800@hartkopp.net> <56D8A708.2050805@pengutronix.de> <56D8A744.4030109@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:57060 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbcCCV3v (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Mar 2016 16:29:51 -0500
In-Reply-To: <56D8A744.4030109@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>

On 03/03/2016 10:06 PM, Oliver Hartkopp wrote:
> 
> 
> On 03/03/2016 10:05 PM, Marc Kleine-Budde wrote:
> 
>>> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>
>>> finally seems appropriate :)
>>
>> For all four patches?
> 
> yep.
> 
Whew, thank you :-)

In case I detect some more defects, I will send subsequent patches. I'm
sure there is considerable amount of real-world testing coming for this
driver.

-- 
Best regards,
Marek Vasut
