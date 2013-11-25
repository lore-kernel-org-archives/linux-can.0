From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v6] can: sja1000: fix {pre,post}_irq() handling and IRQ
 handler return value
Date: Mon, 25 Nov 2013 19:12:08 +0100
Message-ID: <529392F8.6040104@hartkopp.net>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <52931051.90502@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:62000 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab3KYSMM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 13:12:12 -0500
In-Reply-To: <52931051.90502@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, austin@peloton-tech.com



On 25.11.2013 09:54, Marc Kleine-Budde wrote:
> On 11/25/2013 12:03 AM, Marc Kleine-Budde wrote:
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> It has been reported that on PREEMPT_RT enabled system the peak SJA1000
>> hardware can trigger "irq X: nobody cared" errors.

This sentence of the description is not really related to the patch.

We all looked into the sja1000 driver due to the issue Austin reported and
detected the general problem in error handling then.

With PREEMPT_RT there are irq threads which might lead to Austins specific
problem ...

>>
>> This patch fixes the issue that the sja1000_interrupt() function may have
>> returned IRQ_NONE without processing the optional pre_irq() and post_irq()
>> function before. Further the irq processing counter 'n' is moved to the end of
>> the while statement to return correct IRQ_[NONE|HANDLED] values at error
>> conditions.
> 
> Austin, can you test if this patch solves your problem.

Austin should test it, right.

But that should not delay sending this patch to net/stable tree.

Sorry for the confusion. Following the mails must have been hard ;-)

Best regards,
Oliver


