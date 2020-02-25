From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Date: Tue, 25 Feb 2020 14:25:40 -0800
Message-ID: <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com> <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33215 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBYWZw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Feb 2020 17:25:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id w6so1119273otk.0
        for <linux-can@vger.kernel.org>; Tue, 25 Feb 2020 14:25:52 -0800 (PST)
In-Reply-To: <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: open list <linux-kernel@vger.kernel.org>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, =?UTF-8?B?VGltbyBTY2hsw7zDn2xlcg==?= <schluessler@krause.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Tue, Feb 25, 2020 at 1:43 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 2/25/20 7:35 PM, Tim Harvey wrote:
> > Some SPI host controllers such as the Cavium Thunder do not support
> > full-duplex SPI. Using half-duplex transfers allows the driver to work
> > with those host controllers.
>
> There are several transfers left in the driver, where both rx_buf and
> tx_buf are set. How does your host controller driver know which one to
> handle?
>

Marc,

Your right... there is the mcp251x_hw_rx_frame() call that also uses
spi_rx_buf after a synchronous transfer (I didn't see any others).
I'll look at this again.

In general is it an ok approach to switch the driver to half-duplex
for this issue without the need of complicating things with a
module/dt param?

Regards,

Tim
