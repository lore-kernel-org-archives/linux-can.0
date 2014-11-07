From: Dong Aisheng <b29396@freescale.com>
Subject: Re: M_CAN message RAM initialization AppNote  - was: Re: [PATCH V3
 3/3] can: m_can: workaround for transmit data less than 4 bytes
Date: Fri, 7 Nov 2014 16:15:09 +0800
Message-ID: <20141107081448.GA8037@shlinux1.ap.freescale.net>
References: <1415193393-30023-1-git-send-email-b29396@freescale.com>
 <1415193393-30023-3-git-send-email-b29396@freescale.com>
 <545A3451.2090302@pengutronix.de> <545A692E.40002@hartkopp.net>
 <20141106015716.GB7642@shlinux1.ap.freescale.net>
 <545B1D71.4000408@hartkopp.net>
 <20141106080940.GA22964@shlinux1.ap.freescale.net>
 <545B6AB4.70003@hartkopp.net> <545B6DD8.6010906@pengutronix.de>
 <545BA039.7080108@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0110.outbound.protection.outlook.com ([157.56.111.110]:6848
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750993AbaKGIpQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 7 Nov 2014 03:45:16 -0500
Content-Disposition: inline
In-Reply-To: <545BA039.7080108@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Thu, Nov 06, 2014 at 05:22:17PM +0100, Oliver Hartkopp wrote:
> Hello all, (reduced the CC list a bit)
> 
> thankfully Mr. Hartwich from Bosch followed the mail threads I forwarded to
> him. It turns out that there's only ONE message RAM containing TX Buffers, RX
> Buffers and all the acceptance filter elements.
> 
> Due to our discussion the next M_CAN user manual will contain the attached
> application note (see marked lines in attached PDF).
> 
> Mr Hartwich wrote:
> 
> ---8<--- snip!
> 
> The RAM initialization issue is not limited to Tx Buffers, all RAM words need
> an initialization before they are read. If e.g. the CPU reads an uninitialized
> Rx Buffer before the M_CAN has stored a message into the buffer, that may
> trigger a RAM access error.
> 
> There is only one single Message RAM attached to the M_CAN,  which buffers
> are found where is configured via the registers SIDFC.FLSSA, XIDFC.FLESA,
> RXF0C.F0SA, RXF1C.F1SA, TXBC.TBSA, TXEFC.EFSA. The size of the area needed
> e.g. for the Tx Buffers depends on the number of Buffers and on the size of
> the buffers. Larger buffers are needed for the longer FD frames.
> 
> The M_CAN does not check whether the RAM areas overlap, so this check needs to
> be done in software. It is also possible that several M_CANs share one single
> RAM, so the overlap-check needs to consider also that case.
> 
> RAMs usually do not have a hardware-reset, so the RAM-cells, including the
> parity/ECC-bits (if exist) may be at invalid values. Any write to a RAM word
> will set the parity/ECC-bits to valid values. Therefore the entire RAM should
> be initialized by software after power-on, e.g. (simplistic):
> 
> for (i=RAM_start; i<=RAM_end; i++) RAM[i] = 0x00000000;
> 
> The size of the RAM may differ in different M_CAN implementations, the
> RAM is not part of the M_CAN IP module. There may be RAMs with parity,
> with ECC, or without protection. There may even be RAMs with hardware-reset.
> 
> ---8<--- snip!
> 
> So the recommendation is to initialize the entire message RAM (see PDF).
> 

Thanks for this information.
By the description i agree that it's reasonable and more safe to initialize
the entire message RAM.

Regards
Dong Aisheng

> Regards,
> Oliver
> 


