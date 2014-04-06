From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2 3/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Sun, 06 Apr 2014 21:42:03 +0200
Message-ID: <5341AE0B.4090101@hartkopp.net>
References: <1395757822-22283-1-git-send-email-sbabic@denx.de> <1395757822-22283-4-git-send-email-sbabic@denx.de> <534170AD.50506@grandegger.com> <5341A497.9090409@hartkopp.net> <5341A966.5080202@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:22177 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaDFTmL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 6 Apr 2014 15:42:11 -0400
In-Reply-To: <5341A966.5080202@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "Max S." <max@schneidersoft.net>

On 06.04.2014 21:22, Wolfgang Grandegger wrote:
> On 04/06/2014 09:01 PM, Oliver Hartkopp wrote:
>> On 06.04.2014 17:20, Wolfgang Grandegger wrote:

>>> This driver is rather special in various
>>> respects. As I see it, it does not support:
>>>
>>>   - loopback (echo_skbs)
>>>   - error state handling
>>>   - any error reporting (CAN error messages)
>>>   - any error counting (net and CAN stats)
>>>   - recovery from bus-off
>>>
>>> Any chance to improve on that? At least some kind of error reporting
>>> would be nice otherwise the app does not realize any problems. Or how
>>> does your app handle error cases.
>>
>> You are right on asking this.
>>
>> On the other had I suggested to name it "spi_can" in all places to make it a
>> generic driver to attach micro controllers which have CAN and SPI in a common way.
> 
> But it depends on the firmware running on the micro controller. I still
> think that "spi_can" will confuse people. Anyway, just a name.
> 

Thinking about your remark:

The difference to other SPI CAN drivers is, that it does not access the
controller registers via (very short) SPI messages (like the mcp251x) but adds
a message protocol for some kind of 'remove CAN controller'.

With this message protocol some 'intelligence' can probably be moved down to
the attached micro controller (e.g. the error state handling).

But indeed the loopback (IFF_ECHO) handling should be implemented correctly.

AFAIK only the gs_usb driver from Max Schneider

	http://marc.info/?l=linux-can&m=138791254416497&w=2

did this in a correct way. Search for

	"/* echo_id == hf->echo_id */"

in the above patch.

Best regards,
Oliver
