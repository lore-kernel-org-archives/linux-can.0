From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: mcp251x: Fix regulators operation without CONFIG_REGULATOR
Date: Mon, 17 Mar 2014 08:07:38 +0100
Message-ID: <53269F3A.1040708@hartkopp.net>
References: <1394786780-24083-1-git-send-email-shc_work@mail.ru> <1394790917.548655659@f79.i.mail.ru> <5322D303.8000601@pengutronix.de> <1394791904.45849417@f382.i.mail.ru> <5322D6B2.90904@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:18650 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbaCQHHp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Mar 2014 03:07:45 -0400
In-Reply-To: <5322D6B2.90904@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

On 14.03.2014 11:15, Marc Kleine-Budde wrote:

> 
> Okay, applied to can-next, that goes via net-next into v3.15.
> 

Hello Marc,

Linus just tagged 3.14-rc7 with a relaxed comment:

	https://lkml.org/lkml/2014/3/16/166

So net-next might close this week.

Just FYI :-)

Regards,
Oliver
