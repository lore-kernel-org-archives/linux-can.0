From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/3] flexcan: Use a regulator to control the CAN transceiver
Date: Fri, 14 Jun 2013 00:55:53 -0300
Message-ID: <CAOMZO5Ar02mNhsgCpTWiHdtHy1f2Z-foyo51qFR66vqjOCJLpQ@mail.gmail.com>
References: <1370916778-4406-1-git-send-email-festevam@gmail.com>
	<1370916778-4406-2-git-send-email-festevam@gmail.com>
	<51B84224.2040807@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:36386 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab3FNDzy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Jun 2013 23:55:54 -0400
Received: by mail-ve0-f180.google.com with SMTP id pa12so91492veb.11
        for <linux-can@vger.kernel.org>; Thu, 13 Jun 2013 20:55:53 -0700 (PDT)
In-Reply-To: <51B84224.2040807@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Marc,

On Wed, Jun 12, 2013 at 6:40 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 06/11/2013 04:12 AM, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Instead of using a GPIO to turn on/off the CAN transceiver, it is better to
>> use a regulator as some systems may use a PMIC to power the CAN transceiver.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> Marc/Shawn,
>>
>> Only boot tested. I haven't tested CAN operation.
>
> Can you test on real hardware? I don't have access to an evk until Monday.

I am currently working on another customer issue and not able to work
on this during this week.

Regards,

Fabio Estevam
