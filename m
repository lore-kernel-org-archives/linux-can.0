From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: can/sja1000: potential issue in sja1000.c?
Date: Fri, 10 Feb 2012 12:56:03 +0100
Message-ID: <4F3505D3.3090701@grandegger.com>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com> <4F2FF9EE.1060301@volkswagen.de> <4F34F8BC.3030903@peak-system.com> <4F34FC8F.4000104@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:43755 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727Ab2BJL4a (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Feb 2012 06:56:30 -0500
In-Reply-To: <4F34FC8F.4000104@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

On 02/10/2012 12:16 PM, Marc Kleine-Budde wrote:
> On 02/10/2012 12:00 PM, Stephane Grosjean wrote:
>> Hi all,
>>
>> While always fighting against pcmcia Oliver (very hot) unplug issue, I
>> decided to have a look to the sja1000 lib, since the pcmcia driver ISR
>> does call "sja1000_interrupt()",
>>
>> Unfortunately, I found that:
>>
>>                 if (isrc & IRQ_RI) {
>>                         /* receive interrupt */
>>                         while (status & SR_RBS) {
>>                                 sja1000_rx(dev);
>>                                 status = priv->read_reg(priv, REG_SR);
>>                         }
>>                 }
>>
>> My problem is, once the card is unplugged, every ioread in its
>> corresponding io space does return 0xff...
>> I just change this potential infinite while() into a corresponding
>> for(;;) loop to test, like this:
>>
>> -                        while (status & SR_RBS) {
>> +                        int i;
>> +                        for (i = 0; (status & SR_RBS) && (i < 10); i++) {
>>
>> And no more PC hang!

Good catch. The loop count should be limited to avoid hanging the system.

Wolfgang.



