From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can: fix sja1000 pre_irq/post_irq handling
Date: Wed, 20 Nov 2013 07:33:21 +0100
Message-ID: <528C57B1.8000006@hartkopp.net>
References: <528A0F9A.6070305@hartkopp.net> <20131118211557.GA3084@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:62646 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab3KTGdZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Nov 2013 01:33:25 -0500
In-Reply-To: <20131118211557.GA3084@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>



On 18.11.2013 22:15, Kurt Van Dijck wrote:
> Oliver,
> 
> On Mon, Nov 18, 2013 at 02:01:14PM +0100, Oliver Hartkopp wrote:
>> The SJA1000 driver provides optional function pointers to handle specific
>> hardware setups at interrupt time.
>>
>> This patch fixes the issue that the sja1000_interrupt() function may have
>> returned IRQ_NONE without processing the post_irq function. Additionally
>> an introduced and documented return value from the pre_irq function is
>> checked to skip the entire interrupt handling on pre_irq function errors.
> 
> You combine fixes and new features in 1 patch.

You are right. The return value is not really a fix.

> Both are tried in addressing the problem with peak_pci,
> but that doesn't make them depend on each other.

It mainly isn't related to peak_pci. It just emerged in the code review when
investigating an issue with the peak_pci driver.

I have no strong opinion about splitting up the patch.

Regards,
Oliver

