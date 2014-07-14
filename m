From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v3 2/2] can: m_can: add Bosch M_CAN controller support
Date: Mon, 14 Jul 2014 13:05:55 +0530
Message-ID: <53C3885B.5020008@gmail.com>
References: <1405074557-5519-1-git-send-email-b29396@freescale.com> <1405074557-5519-2-git-send-email-b29396@freescale.com> <53BFC6CE.9090408@gmail.com> <53BFD28A.5090202@pengutronix.de> <53BFD4DF.7030003@gmail.com> <20140714072146.GD1668@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:37177 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbaGNHhI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Jul 2014 03:37:08 -0400
In-Reply-To: <20140714072146.GD1668@shlinux1.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <b29396@freescale.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com

On 07/14/2014 12:51 PM, Dong Aisheng wrote:
>
> +    dev_dbg(&pdev->dev, "mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0
> 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
> +        priv->mram_base,
> +        priv->mcfg[MRAM_SIDF].off, priv->mcfg[MRAM_SIDF].num,
> +        priv->mcfg[MRAM_XIDF].off, priv->mcfg[MRAM_XIDF].num,
> +        priv->mcfg[MRAM_RXF0].off, priv->mcfg[MRAM_RXF0].num,
> +        priv->mcfg[MRAM_RXF1].off, priv->mcfg[MRAM_RXF1].num,
> +        priv->mcfg[MRAM_RXB].off, priv->mcfg[MRAM_RXB].num,
> +        priv->mcfg[MRAM_TXE].off, priv->mcfg[MRAM_TXE].num,
> +        priv->mcfg[MRAM_TXB].off, priv->mcfg[MRAM_TXB].num);
> +
>>>> dev_dbg() will insert the new lines in b/w. It wont print the values as
>>>> you expected.
>>>> Check this by enabling debug ...
>>> What do you mean by b/w?
>> You are expecting the data to be print in format like:
>> pdev->dev/name: mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d
>>
>> But when we use the dev_dbg()/pr_debug()... It will put data like:
>> pdev->dev/name: mram_base %p sidf 0x%x
>> 0x%x %d rxf0 0x%x
>> rxf1 0x%x %d rxb
>> ....
>>
>> check this by enable DEBUG...
>>
> My test showed the format is:
> root@imx6qdlsolo:~# uname -a
> Linux imx6qdlsolo 3.16.0-rc2-next-20140627-00006-gd55dd62-dirty #373 SMP Fri Jul 11 18:12:31 CST 2014 armv7l GNU/Linux
> root@imx6qdlsolo:~# dmesg | grep m_can
> m_can 20e8000.can: mram_base c0990000 sidf 0x0 0 xidf 0x0 0 rxf0 0x0 32 rxf1 0x200 0 rxb 0x200 0 txe 0x200 0 txb 0x200 1
> m_can 20e8000.can: m_can device registered (regs=c0988000, irq=146)
> m_can 20f0000.can: mram_base c09a0000 sidf 0x400 0 xidf 0x400 0 rxf0 0x400 32 rxf1 0x600 0 rxb 0x600 0 txe 0x600 0 txb 0x600 1
> m_can 20f0000.can: m_can device registered (regs=c0998000, irq=147)
>
I think you got the expected result.

I faced the above problem when i use pr_debug(). Can you check with this....?

This is good. Thanks for clarification.

>
> Regards
> Dong Aisheng
>
-- 
Regards,
Varka Bhadram.

