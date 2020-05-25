From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Date: Mon, 25 May 2020 15:12:05 +0200
Message-ID: <a663d610-56d8-1c2d-90ad-4d128a2fa3a8@pengutronix.de>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
 <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
 <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
 <e0f641bc-5473-792d-fea9-0a2e81fe1e38@pengutronix.de>
 <20200525113106.GB4544@sirena.org.uk>
 <a337c8ea-66e2-13c2-f625-fbe93e367d44@pengutronix.de>
 <20200525125743.GF4544@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388738AbgEYNMR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 May 2020 09:12:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD90C061A0E
        for <linux-can@vger.kernel.org>; Mon, 25 May 2020 06:12:17 -0700 (PDT)
In-Reply-To: <20200525125743.GF4544@sirena.org.uk>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>, open list <linux-kernel@vger.kernel.org>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, =?UTF-8?Q?Timo_Schl=c3=bc=c3=9fler?= <schluessler@krause.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-spi@vger.kernel.org, Jan Glauber <jglauber@marvell.com>, Robert Richter <rrichter@marvell.com>

On 5/25/20 2:57 PM, Mark Brown wrote:
> On Mon, May 25, 2020 at 02:41:31PM +0200, Marc Kleine-Budde wrote:
>> On 5/25/20 1:31 PM, Mark Brown wrote:
> 
>>> This isn't something that every individual driver should be doing, such
>>> rewriting should happen in the core so that everything sees the benefit.
> 
>> The core could merge several half duplex transfers (until there's as cs_change)
>> into a single full duplex transfer.
> 
> Yes, that is what I am suggesting.

Where in the SPI stack do you see such a "merge" function? One point to clarify
is when and where to allocate and free the memory for the contiguous full duplex
buffers.

>> I think it's not easy to detect and reliable to split a full duplex transfer
>> into half duplex ones. How can you tell, if the controller is supposed to tx 0x0
>> or actually receive.
> 
> I don't understand how that could possibly work or why it would make
> sense?

ACK, I was just thinking loud about options.

>> I think spi_write_then_read() can be extended to generate one full duplex
>> transfer instead on two half duplex ones it does a memcpy() anyways.
> 
> This has the same problem as doing it in any other driver code - it
> causes a needless incompatibility with three wire and single duplex
> devices.  

What about the note "portable code should never use this for more than 32 bytes"
in spi_write_then_read()? The CAN driver in question may read more than 32 bytes
of data.

>> To get a feeling for the use cases, this is what I do in the regmap read
>> function of a (not yet mainlined) CAN SPI driver.
> 
> Like I say it's probably better if code like this gets pushed into the
> SPI core where we've got more information about what the controller can
> do and there's more win from doing the tuning since more devices and
> systems can take advantage of it.

ACK

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
