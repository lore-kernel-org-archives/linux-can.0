From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v8 0/4] can: Allwinner A10/A20 CAN Controller support
 - Summary
Date: Thu, 17 Sep 2015 20:12:31 +0200
Message-ID: <55FB028F.7070206@hartkopp.net>
References: <1442402482-7118-1-git-send-email-info@gerhard-bertelsmann.de> <20150917175444.GJ4684@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:51296 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbIQSNK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Sep 2015 14:13:10 -0400
In-Reply-To: <20150917175444.GJ4684@lukather>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org



On 17.09.2015 19:54, Maxime Ripard wrote:
> On Wed, Sep 16, 2015 at 01:21:18PM +0200, Gerhard Bertelsmann wrote:
>> Hi,
>>
>> please find attached the next version of my patch set. I have
>> taken all remarks from Maxime Ripard into the new version
>>
>> Please review, test and report bugs if exists.
>>
>> The patchset applies to all recent Kernel versions (4.x, next etc.).
>>
>> [PATCH v8 1/4] Device Tree Binding Documentation
>> [PATCH v8 2/4] Defconfig multi_v7
>> [PATCH v8 3/4] Defconfig sunxi
>> [PATCH v8 4/4] Kernel Module
>
> Applied 3 and 4.

Applied to what tree?

That's not the friendly way when Marc asks you about the documentation about 
the device tree (patch 1) and you commit the CAN driver and the sunxi 
defconfig (patch 3 & 4) that he mainly reviewed to whatever tree.

New CAN drivers go via can-next and net-next into mainline.

So please answer Marcs question and let him queue up the CAN driver via 
can-next himself.

Thanks,
Oliver

