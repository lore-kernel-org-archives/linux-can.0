From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v4] can/peak_usb: add support for PEAK new CANFD USB adapters
Date: Wed, 07 Jan 2015 18:37:28 +0100
Message-ID: <54AD6ED8.2020808@hartkopp.net>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com> <54AD66C5.10908@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:40841 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbbAGRhp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Jan 2015 12:37:45 -0500
In-Reply-To: <54AD66C5.10908@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

On 07.01.2015 18:03, Marc Kleine-Budde wrote:
> On 01/06/2015 11:00 AM, Stephane Grosjean wrote:
>> Add support for the following new PEAK-System technik CANFD USB adapters:
>>
>> PCAN-USB FD             single CANFD channel USB adapter
>> PCAN-USB Pro FD         dual CANFD channels USB adapter
>
> Can you please work out the correct ISO/non-ISO for CAN-fd with Oliver.
> If you need CAN_CTRLMODE_FD_NON_ISO make your patch based on
>
>      https://gitorious.org/linux-can/linux-can.git testing
>

Good idea.

@Stephane: Do you already have the latest UCAN IP core from Philipp which 
supports the ISO/non-ISO switching? (I don't have it)

The question is if it makes sense to provide a driver for the current UCAN IP 
core and later provide a separate patch when the new (switchable) UCAN IP core 
is available.

But in this case we need to check for the UCAN revision whether it is fixed to 
non-ISO or if it is switchable.

Maybe it makes sense to support ONLY the latest (== switchable) UCAN revision 
for the mainline driver. The update to the latest UCAN revision is mandatory 
anyway.

What is your suggestion?

Regards,
Oliver

