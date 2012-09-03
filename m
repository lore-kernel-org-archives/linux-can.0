From: =?UTF-8?B?QmVub8OudA==?= <benoit@pouic.eu>
Subject: Re: [PATCH] can: mcp251x: avoid repeated frame bug
Date: Mon, 03 Sep 2012 20:09:48 +0200
Message-ID: <5044F26C.1070701@pouic.eu>
References: <1346674649-10181-1-git-send-email-mkl@pengutronix.de> <5044E54F.7020507@pouic.eu> <5044F018.50808@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pouic.eu ([109.190.18.85]:52882 "EHLO smtp.pouic.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483Ab2ICSJu (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 3 Sep 2012 14:09:50 -0400
In-Reply-To: <5044F018.50808@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 09/03/2012 07:59 PM, Marc Kleine-Budde wrote:
>> By the way, about using spi_write()instead of mcp251x_spi_trans(): I
>> innocently thought it would make less function call nesting,
>> trying to improve response time of the driver particularly on my
>> Raspberry Pi.
> Ahh, I see. but the mcp251x_spi_trans() function takes does the setup
> thats needed for DMA.
Very good argument indeed.

Best Regards,

Beno=C3=AEt.

