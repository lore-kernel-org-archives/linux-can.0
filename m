From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: [PATCH v2 00/11] RFC: cleanup flexcan driver, introduce and make
 use of IRQ offloading
Date: Mon, 22 Feb 2016 16:16:15 +0100
Message-ID: <CAJ=nTsv39BL85Tbgp86CzMS-fUhGx0627POVKTXaRMETNoAnDA@mail.gmail.com>
References: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
	<87egdf5eca.fsf@gmail.com>
	<569D6180.8030906@pengutronix.de>
	<569D82BE.1000007@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33992 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbcBVPQQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Feb 2016 10:16:16 -0500
Received: by mail-lf0-f49.google.com with SMTP id j78so95660455lfb.1
        for <linux-can@vger.kernel.org>; Mon, 22 Feb 2016 07:16:16 -0800 (PST)
In-Reply-To: <569D82BE.1000007@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Holger Schurig <holgerschurig@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, kernel@pengutronix.de, bhupesh.sharma@freescale.com

2016-01-19 1:26 GMT+01:00 Tom Evans <tom_usenet@optusnet.com.au>:
> On 19/01/16 09:04, Marc Kleine-Budde wrote:
>>
>> On 01/18/2016 12:14 PM, Holger Schurig wrote:
>>>
>>> Marc Kleine-Budde <mkl@pengutronix.de> writes:
>>>
>>>> Testing and feedback welcome.
>>>
>>>
>>> And here it is, albeit a bit late:
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 0 at
>>> /home/schurig/d/mkarm/linux-4.4/drivers/net/can/rx-fifo.c:203
>>> can_rx_fifo_irq_offload+0x214/0x264()
>>> can_rx_fifo_irq_offload: No messages found, RX-FIFO out of sync?
>>> Modules linked in: bnep btusb btrtl btbcm btintel bluetooth smsc95x=
x
>>> usbnet mii imx_sdma flexcan dlog(O)
>>> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O    4.4.0 #1
>>> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)

Applied this patch series to my 4.1.5 kernel and for what it is worth
I get the same error on VF610 after approximately 500 k frames.

[  118.751463] WARNING: CPU: 0 PID: 0 at drivers/net/can/rx-fifo.c:205
can_rx_fifo_irq_offload+0x2dc/0x30c()         [  118.761065]
can_rx_fifo_irq_offload: No messages found, RX-FIFO out of sync?
                                              [  118.768137] Modules
linked in: mx4_pic(O) mcp251x [last unloaded: mx4_pic]
                                        [  118.775108] CPU: 0 PID: 0
Comm: swapper Tainted: G           O
4.1.15-00058-gd84a5e156db7-dirty #1               [  118.784355]
Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)

--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
