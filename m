From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 1/2] Add documentation for SPI to CAN driver
Date: Thu, 30 Oct 2014 21:41:46 +0100
Message-ID: <5452A28A.1070401@hartkopp.net>
References: <1406565510-10783-1-git-send-email-sbabic@denx.de> <1406565510-10783-2-git-send-email-sbabic@denx.de> <54514F2C.10108@hartkopp.net> <54526584.3060300@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:17344 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932513AbaJ3Uls (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 Oct 2014 16:41:48 -0400
In-Reply-To: <54526584.3060300@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On 10/30/2014 05:21 PM, Stefano Babic wrote:
> On 29/10/2014 21:33, Oliver Hartkopp wrote:

>> Why is ctrlmode not 32 bit?
>>
>>> +    23-27    clock
>>> +    28-29    Checksum
>>
> 
> I admit this is a limitation on the Slave Controller. I was asked to not
> send a configuration frame bigger as 32 bytes, and I have tried to save
> space in some ways. Indeed, only some bits in the ctrlmode are used.
> 
> Anyway, I was unsure if I can reduce the size for the brp_* fields.
> Using 32bit for brp_min looks like excessive, and I could drop its size
> instead of ctrlmode. Do you think I can use 8bit values for all brp_*
> fields ?

At least for CAN FD these values are increased remarkably. So we should
probably leave it as-is.

> 
>> Some more stuff in the other patch.
> 
> I check it, thanks for review !

Tnx!

Best regards,
Oliver

