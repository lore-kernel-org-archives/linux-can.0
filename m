From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Thu, 09 Jul 2015 10:43:21 +0200
Message-ID: <559E3429.1070507@hartkopp.net>
References: <559D35CA.2050402@uweschneider.de> <CAOpc7mHJY58mYWum5KLWDzfYyABWAGf8pieZJRSzYhUm85uwUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:53848 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbGIInb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 04:43:31 -0400
In-Reply-To: <CAOpc7mHJY58mYWum5KLWDzfYyABWAGf8pieZJRSzYhUm85uwUA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>, Torsten Lang <torsten.lang@uweschneider.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

On 09.07.2015 10:06, Holger Schurig wrote:
> 2015-07-08 16:38 GMT+02:00 Torsten Lang <torsten.lang@uweschneider.de>:
>> P. S. As mentioned I have some trouble getting the kernel to work on the hardware I use.
>> The main remaining problem is that my application no longer receives the CAN messages
>> correctly with kernel 4.1 - neither with the original FlexCAN driver nor with mine. As long
>> as y Qt application uses the CAN bus alone it only receives single messages about
>> every 30..60s (actually the test messages are transmitted every 250ms). As soon
>> as I start a candump in parallel my application also receives the test messages. I
>> currently have no explanation for this behaviour.

Kernel versions 4.1-rc to 4.1.1 (included) have a problem when timestamping is 
not enabled. candump enables the timestamping in your case -> makes it work 
properly.

Please apply this stable patch to the affected 4.1 kernels:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=36c01245eb8046c16eee6431e7dbfbb302635fa8

This fix turned out to be a bit to brutal :-)

So here's the 'nice' rework of that fix:

http://marc.info/?l=linux-can&m=143531273819705&w=2

But the first fix will fix your problem.

Regards,
Oliver



>
> I'm on stable Linux 3.18.17 and do not observe this behavior.
>
> 4.1.x migth be whacky, because I once had the serial port hang in some
> DMA related code. I "fixed" this with a
>
> +#if 0
> +       if (is_imx6q_uart(sport) && !uart_console(port) &&
> +           !sport->dma_is_inited)
> +               imx_uart_dma_init(sport);
> +#endif
>
> ... but that was certainly a hack. My $CUSTOMER promply reported my
> other things like a stopping touchscreen, GUI app not accepting input
> anymore. I was flooded with other work, I want back to savety of
> 3.18.x :-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
