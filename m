From: David Jander <david@protonic.nl>
Subject: Re: MCP2515 implementation is slow
Date: Thu, 27 Nov 2014 08:33:46 +0100
Message-ID: <20141127083346.79d4a5af@archvile>
References: <84a1d29551f84f5494b309e1ad1e0840@SGPMBX1004.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:26800 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbaK0Hdq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Nov 2014 02:33:46 -0500
In-Reply-To: <84a1d29551f84f5494b309e1ad1e0840@SGPMBX1004.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Pankajkumar Misra (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, gianluca <gianlucarenzi@eurekelettronica.it>

On Tue, 25 Nov 2014 16:19:33 +0000
"Pankajkumar Misra (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com> wrote:

> I have compiled MCP251x.c kernel driver module for Olimex A20-Olinuxino
> Micro.
> 
> The device is working fine for one frame at a time at 500ms. If I send two
> or more frame at the same time, CAN is going to bus-off due to overrun
> errors. Even if I send one frame at faster rate say, 100ms,results in
> bus-off.

I tend to think there is something other wrong with your setup. Maybe you are
missing bus-termination/biasing? Chip-clock?
The device should never go in bus-off mode if there are RX-overruns. If it
goes into bus-off, there is something wrong in the hardware.

> I am communicating with module with ip commands, cansend & candump.
> Also my SPI module is working only at 250K baud, not any other baud.

We use a MCP2515 with this driver at 250kbit/s receiving back-to-back messages
without loss on a i.MX51. Please note, that it won't work reliably at any
higher bitrate and system load is quite high.

The MCP2515 is a very bad design, but the driver performance has improved a lot
since spi-bitbang started using a kthread instead of a work-queue.

> Any suggestions.
> 
> Best Regards,
> Pankaj
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Best regards,

-- 
David Jander
Protonic Holland.
