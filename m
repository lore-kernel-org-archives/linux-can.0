From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: [PATCH v2 00/11] RFC: cleanup flexcan driver, introduce and make
 use of IRQ offloading
Date: Tue, 19 Jan 2016 11:26:38 +1100
Message-ID: <569D82BE.1000007@optusnet.com.au>
References: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
 <87egdf5eca.fsf@gmail.com> <569D6180.8030906@pengutronix.de>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:58096 "EHLO
	mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755517AbcASA0j (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jan 2016 19:26:39 -0500
In-Reply-To: <569D6180.8030906@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Holger Schurig <holgerschurig@gmail.com>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, bhupesh.sharma@freescale.com

On 19/01/16 09:04, Marc Kleine-Budde wrote:
> On 01/18/2016 12:14 PM, Holger Schurig wrote:
>> Marc Kleine-Budde <mkl@pengutronix.de> writes:
>>
>>> Testing and feedback welcome.
>>
>> And here it is, albeit a bit late:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 0 at /home/schurig/d/mkarm/linux-4.4/drivers/net/can/rx-fifo.c:203 can_rx_fifo_irq_offload+0x214/0x264()
>> can_rx_fifo_irq_offload: No messages found, RX-FIFO out of sync?
>> Modules linked in: bnep btusb btrtl btbcm btintel bluetooth smsc95xx usbnet mii imx_sdma flexcan dlog(O)
>> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O    4.4.0 #1
>> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>
> Thanks for testing, this driver triggers what we think a hardware bug,
> resulting in packages are not beeing filled into the correct order into
> the hardware. There are some people at fsl/nxp looking into this issue
> at the hardware level.

Very unlikely, but I'd like to check that this isn't a similar driver bug to 
the one Freescale had in the 2.6.35 FlexCAN driver in the FIFO handling code.

The one line description of the problem is that the driver cleared the FIFO 
interrupt and THEN read the FIFO, which is the opposite of what the manual 
says to do.

The above and the following link should be enough information to check to see 
if there's an obvious problem like this, otherwise could someone please email 
me the source of the driver or a link to same so I can check?

https://community.freescale.com/thread/381075

Tom

