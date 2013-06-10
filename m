From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] flexcan: Enable/Disable the CAN regulator in probe/remove
Date: Mon, 10 Jun 2013 17:49:14 -0300
Message-ID: <CAOMZO5BdBr_ms1M61-k4hEmV3HnhAd6hOuUvAx6krxG95+c_Sg@mail.gmail.com>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com>
	<1370460445-15386-2-git-send-email-festevam@gmail.com>
	<51B606C0.1070407@pengutronix.de>
	<CAOMZO5CEWHTyw3s+vLtOVMdWmNWUndOZ3E4ohpCyTFXiz+VEOQ@mail.gmail.com>
	<51B63974.2000100@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:38606 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab3FJUtP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 16:49:15 -0400
Received: by mail-vc0-f180.google.com with SMTP id gf11so2792703vcb.11
        for <linux-can@vger.kernel.org>; Mon, 10 Jun 2013 13:49:14 -0700 (PDT)
In-Reply-To: <51B63974.2000100@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Mon, Jun 10, 2013 at 5:39 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:

>> It will turn off the transceiver here, which means that can1 will not
>> be able to operate.
>>
>> Currently this situation is properly handled inside mach-mxs by only
>> disabling the CAN transceiver when both CAN ports are not used.
>
> Why don't you enable the regulator in can1, too?

Since they use the same regulator (the same GPIO pin control both CAN
ports on mx28evk), I can not have regulator disabled for can0 and
regulator enabled for can1.
