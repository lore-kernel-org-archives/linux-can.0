From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: dev: fix crtlmode_supported check
Date: Wed, 28 Jan 2015 16:38:05 +0100
Message-ID: <54C9025D.9040702@hartkopp.net>
References: <1422385920-29763-1-git-send-email-socketcan@hartkopp.net> <54C89CFA.7080606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:26967 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933601AbbA1UiI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Jan 2015 15:38:08 -0500
In-Reply-To: <54C89CFA.7080606@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Zefan Li <lizefan@huawei.com>, Ben Hutchings <ben@decadent.org.uk>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello all,

just in the case you are interested to pick these patches up for 3.2 and 3.4 
stable:

The backported patch for Linux 3.2 ... 3.14 has been queued by GregKH for the 
3.10 kernel here:

http://git.kernel.org/cgit/linux/kernel/git/stable/stable-queue.git/tree/queue-3.10/can-dev-fix-crtlmode_supported-check.patch?id=332373aa9a50a1c18027be7352d6138fa74263d0

Best regards,
Oliver

On 28.01.2015 09:25, Marc Kleine-Budde wrote:
> On 01/27/2015 08:12 PM, Oliver Hartkopp wrote:
>> When changing flags in the CAN drivers ctrlmode the provided new content has to
>> be checked whether the bits are allowed to be changed. The bits that are to be
>> changed are given as a bitfield in cm->mask. Therefore checking against
>> cm->flags is wrong as the content can hold any kind of values.
>>
>> The iproute2 tool sets the bits in cm->mask and cm->flags depending on the
>> detected command line options. To be robust against bogus user space
>> applications additionally sanitize the provided flags with the provided mask.
>>
>> (Backport of upstream commit 9b1087aa5e86448fe6ad40a58964e35f3ba423d5 for
>> Linux 3.2 .. Linux 3.14)
>
> Zefan Li <lizefan@huawei.com> is taking care of v3.4
>
> Marc
>
