From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Thu, 9 Jul 2015 10:06:01 +0200
Message-ID: <CAOpc7mHJY58mYWum5KLWDzfYyABWAGf8pieZJRSzYhUm85uwUA@mail.gmail.com>
References: <559D35CA.2050402@uweschneider.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36805 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbbGIIGD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 04:06:03 -0400
Received: by widjy10 with SMTP id jy10so237462866wid.1
        for <linux-can@vger.kernel.org>; Thu, 09 Jul 2015 01:06:02 -0700 (PDT)
In-Reply-To: <559D35CA.2050402@uweschneider.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Torsten Lang <torsten.lang@uweschneider.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

2015-07-08 16:38 GMT+02:00 Torsten Lang <torsten.lang@uweschneider.de>:
> P. S. As mentioned I have some trouble getting the kernel to work on the hardware I use.
> The main remaining problem is that my application no longer receives the CAN messages
> correctly with kernel 4.1 - neither with the original FlexCAN driver nor with mine. As long
> as y Qt application uses the CAN bus alone it only receives single messages about
> every 30..60s (actually the test messages are transmitted every 250ms). As soon
> as I start a candump in parallel my application also receives the test messages. I
> currently have no explanation for this behaviour.

I'm on stable Linux 3.18.17 and do not observe this behavior.

4.1.x migth be whacky, because I once had the serial port hang in some
DMA related code. I "fixed" this with a

+#if 0
+       if (is_imx6q_uart(sport) && !uart_console(port) &&
+           !sport->dma_is_inited)
+               imx_uart_dma_init(sport);
+#endif

... but that was certainly a hack. My $CUSTOMER promply reported my
other things like a stopping touchscreen, GUI app not accepting input
anymore. I was flooded with other work, I want back to savety of
3.18.x :-)
