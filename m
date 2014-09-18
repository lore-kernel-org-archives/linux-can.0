From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH 1/4] Consolidate and unify state change handling
Date: Thu, 18 Sep 2014 17:05:08 +0000
Message-ID: <541B10C4.5050206@marel.com>
References: <541B078C.2020007@marel.com>
 <CAHuoermUnpToi9TzMDL9+h_LD4yQtuhdG6M=yhs7Q7vFLjNvKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0079.outbound.protection.outlook.com ([65.55.169.79]:2464
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932117AbaIRRFS (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 18 Sep 2014 13:05:18 -0400
In-Reply-To: <CAHuoermUnpToi9TzMDL9+h_LD4yQtuhdG6M=yhs7Q7vFLjNvKA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Lever <svjeorgia@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org


On fim 18.sep 2014 16:55, Paul Lever wrote:
> +    if (rxerr < rxerr)
> +        return CAN_ERR_DIR_RX;
>
> This doesn't look right. rxerr can't be less than itself.
Whoa! Nice catch. That should be "txerr < rxerr".

This error would be near to impossible to catch in tests because this 
means that the case where "txerr == rxerr" would never happen.

Andri
