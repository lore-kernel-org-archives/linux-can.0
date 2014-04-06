From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 3/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Sun, 06 Apr 2014 21:22:14 +0200
Message-ID: <5341A966.5080202@grandegger.com>
References: <1395757822-22283-1-git-send-email-sbabic@denx.de> <1395757822-22283-4-git-send-email-sbabic@denx.de> <534170AD.50506@grandegger.com> <5341A497.9090409@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:56824 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbaDFTWQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 6 Apr 2014 15:22:16 -0400
In-Reply-To: <5341A497.9090409@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

On 04/06/2014 09:01 PM, Oliver Hartkopp wrote:
> Hello Wolfgang,
> 
> On 06.04.2014 17:20, Wolfgang Grandegger wrote:
>> Hi Stefan,
>>
>> sorry for jumping in late... 
> 
> indeed.
> 
> There were some hints from me which already led to a v3 which would be better
> to review ;-)

Oops, I picked the wrong one.

>> This driver is rather special in various
>> respects. As I see it, it does not support:
>>
>>   - loopback (echo_skbs)
>>   - error state handling
>>   - any error reporting (CAN error messages)
>>   - any error counting (net and CAN stats)
>>   - recovery from bus-off
>>
>> Any chance to improve on that? At least some kind of error reporting
>> would be nice otherwise the app does not realize any problems. Or how
>> does your app handle error cases.
> 
> You are right on asking this.
> 
> On the other had I suggested to name it "spi_can" in all places to make it a
> generic driver to attach micro controllers which have CAN and SPI in a common way.

But it depends on the firmware running on the micro controller. I still
think that "spi_can" will confuse people. Anyway, just a name.

> We already remove the 'specific' naming for the iMX35 and HCS12 to make it a
> generic driver and not a specifc driver for this setup.
> 
> Please check the v3 - any also my comments about the bitrate setting
> configuration to be handled by SocketCAN.
> 
> Your remarks from above just go into the same direction.

Yes, some issues seem to have vanished.

Wolfgang.

