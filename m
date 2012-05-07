From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH RESEND 3/5] can: flexcan: adopt pinctrl support
Date: Mon, 7 May 2012 16:17:49 +0800
Message-ID: <CAAQ0ZWSzrfFm+=m+s8S3FDG5k_OrULN58VUVCBE=fwU0r=ZD+g@mail.gmail.com>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
	<1336352040-28447-4-git-send-email-shawn.guo@linaro.org>
	<4FA78298.4080401@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35424 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab2EGIRw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 May 2012 04:17:52 -0400
Received: by lbbgm6 with SMTP id gm6so3251634lbb.19
        for <linux-can@vger.kernel.org>; Mon, 07 May 2012 01:17:49 -0700 (PDT)
In-Reply-To: <4FA78298.4080401@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sascha Hauer <s.hauer@pengutronix.de>, Dong Aisheng <dong.aisheng@linaro.org>, linux-can@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>

On 7 May 2012 16:06, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> It doesn't compile yet against net-next/master, which is based on v3.4-rc4:
>
> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/flexcan.c: In
> function 'flexcan_probe':
> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/flexcan.c:937:
> error: implicit declaration of function 'devm_pinctrl_get_select_default'
> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/flexcan.c:937:
> warning: assignment makes pointer from integer without a cast
>
> Which tree does this series depend on? If this should go over the
> linux-can tree, I have to ask David first to merge this.
>
Thanks for the response, Marc.  The patch depends on pinctrl tree and
a couple of other patches that will go through arm-soc tree, so I
would like to ask for your ack to have the patch go over arm-soc tree.

Regards,
Shawn
