From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v6] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Thu, 08 Nov 2012 11:37:53 +0100
Message-ID: <509B8B81.6050501@gaisler.com>
References: <509A5A3E.4090505@gaisler.com> <1352301634-12668-1-git-send-email-andreas@gaisler.com> <509B6D77.3090707@grandegger.com> <509B7B1E.5040509@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:41913 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751928Ab2KHKiB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 Nov 2012 05:38:01 -0500
In-Reply-To: <509B7B1E.5040509@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, software@gaisler.com, devicetree-discuss@lists.ozlabs.org

On 11/08/2012 10:27 AM, Marc Kleine-Budde wrote:
> On 11/08/2012 09:29 AM, Wolfgang Grandegger wrote:
>> On 11/07/2012 04:20 PM, Andreas Larsson wrote:
>>> This driver supports GRCAN and CRHCAN CAN controllers available in the GRLIB
>>> VHDL IP core library.
>>>
>>> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
>>
>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>
>> Looks good now. Thanks for your patience.
>
> I'm still fighting against the flexcan, I'll have a look at the driver
> this afternoon.

Excellent! I have since v6 added a new bit-timing parameter restriction needed 
for the newly added triple sampling mode, so I'll send in a v7.

Cheers,
Andreas

