From: Ed Spiridonov <edo.rus@gmail.com>
Subject: Re: [PATCH] can: mcp251x: add some messages to mcp251x_can_probe()
Date: Fri, 17 Jun 2016 23:41:08 +0300
Message-ID: <CACm0Nn3L0fqtRMNJCJrPhnrM0JRaEn+g=3i5CSMvRLkKEAjkJQ@mail.gmail.com>
References: <1464487156-20858-1-git-send-email-edo.rus@gmail.com> <9e944b22-b63b-dc72-c060-b2c21f124569@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33739 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbcFQUla convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 16:41:30 -0400
Received: by mail-lf0-f68.google.com with SMTP id l188so763820lfe.0
        for <linux-can@vger.kernel.org>; Fri, 17 Jun 2016 13:41:29 -0700 (PDT)
In-Reply-To: <9e944b22-b63b-dc72-c060-b2c21f124569@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org

17.06.2016 12:22 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=
=D0=B5=D0=BB=D1=8C "Marc Kleine-Budde" <mkl@pengutronix.de> =D0=BD=D0=B0=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
>
> > @@ -1156,6 +1158,8 @@ static int mcp251x_can_probe(struct spi_devic=
e *spi)
> >
> >       devm_can_led_init(net);
> >
> > +     netdev_info(net, "successfully initialized.\n");
>
> I'll remove this hunk, as we try to make the CAN devices as silent as
> possible in case of no errors.


Why it is so important to be totally silent? IMHO one line per CAN bus
isn't too much.
But it could help to debug new configuration, e.g. to find wrong
device tree configuration, especially with several CAN buses.

I made this patch because a lot of complains on Raspberry PI forum.
Current module does not produce any message if module initializes
MCP2510/2515 chip successfully or not. It could be confusing.
