From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH] can: can_oc: Add driver for CAN_OC cores from Aeroflex
 Gaisler
Date: Wed, 26 Sep 2012 14:55:07 +0200
Message-ID: <5062FB2B.2030700@gaisler.com>
References: <1348552379-3909-1-git-send-email-andreas@gaisler.com> <5062CD27.3090803@pengutronix.de> <5062D13F.1090908@grandegger.com> <5062E99B.8020700@gaisler.com> <5062E9EE.2020300@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:43934 "HELO
	vsp-authed-01-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751300Ab2IZMzo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Sep 2012 08:55:44 -0400
In-Reply-To: <5062E9EE.2020300@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, software@gaisler.com

On 09/26/2012 01:41 PM, Marc Kleine-Budde wrote:
> On 09/26/2012 01:40 PM, Andreas Larsson wrote:
>> On 09/26/2012 11:56 AM, Wolfgang Grandegger wrote:
>>> On 09/26/2012 11:38 AM, Marc Kleine-Budde wrote:
>>>> On 09/25/2012 07:52 AM, Andreas Larsson wrote:
>>>>> This driver is for the sja1000 compatible CAN_OC cores from Aeroflex
>>>>> Gaisler available in the GRLIB VHDL IP core library.
>>>>
>>>> Why don't you describe a single sja1000 compatible core with an OF
>>>> device? The devices have indipendent address spaces and IRQs. With a
>>>> proper abstraction/desciption you would not need this driver.
>>>
>>> Right, at least I do not see anything special. The following DTS entry
>>> should do the jobs:
>>> [...]
>>
>> I'll look into this. Note that this is a SPARC device and not a PowerPC
>> device.
>
> The driver doesn't care about your processor :)

The driver doesn't care per se, but how the device tree is generated 
differs compared to how it is done in PowerPC, at least for Leon SPARC.

I'll look into it. At the very least the Kconfig entry for 
sja1000_of_platform could not solely depend on PPC_OF, but the more 
important issue is the device tree differences.

Cheers,
Andreas

