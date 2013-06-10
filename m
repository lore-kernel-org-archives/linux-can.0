From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] flexcan: Use a regulator to control the CAN transceiver
Date: Mon, 10 Jun 2013 14:03:12 -0300
Message-ID: <CAOMZO5CED14a4e_wN7jkuHt93JFuS=L+8fJ+V_u2Z_r_tyQZwg@mail.gmail.com>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com>
	<51B605E7.6080903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:56557 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab3FJRDN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 13:03:13 -0400
Received: by mail-ve0-f181.google.com with SMTP id db10so4892313veb.26
        for <linux-can@vger.kernel.org>; Mon, 10 Jun 2013 10:03:12 -0700 (PDT)
In-Reply-To: <51B605E7.6080903@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Mon, Jun 10, 2013 at 1:59 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 06/05/2013 09:27 PM, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Instead of using a GPIO to turn on/off the CAN transceiver, it is better to
>> use a regulator as some systems may use a PMIC to power the CAN transceiver.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> I'm preparing a patch to remove the usage of flexcan_platform_data from
> the imx tree. Can you add that patch to your series and remove
> "linux/can/platform/flexcan.h" from the source tree in this patch?

Sure, no problem. I can send your patch as part of my series and work
through your other comments.

Regards,

Fabio Estevam
