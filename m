From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 07/10] can: c_can: Simplify buffer reenabling
Date: Fri, 4 Apr 2014 18:33:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404041820321.14882@ionos.tec.linutronix.de>
References: <20140404134816.751883017@linutronix.de> <20140404134857.523481518@linutronix.de> <533EDA82.4020209@hartkopp.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1296208067-1396628947=:14882"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42074 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbaDDQcu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 12:32:50 -0400
In-Reply-To: <533EDA82.4020209@hartkopp.net>
Content-ID: <alpine.DEB.2.02.1404041830170.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1296208067-1396628947=:14882
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.02.1404041830171.14882@ionos.tec.linutronix.de>

On Fri, 4 Apr 2014, Oliver Hartkopp wrote:
> Hello Thomas, hello Alexander,
> 
> I just took a short look into the C_CAN manual.
> 
> -------- Original Message --------
> Subject: [patch 07/10] can: c_can: Simplify buffer reenabling
> 
> (..)
> 
> Instead of writing to the message object we can simply clear the
> NewDat bit with the get method.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/net/can/c_can/c_can.c |   16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> Index: linux-can/drivers/net/can/c_can/c_can.c
> ===================================================================
> --- linux-can.orig/drivers/net/can/c_can/c_can.c
> +++ linux-can/drivers/net/can/c_can/c_can.c
> 
> (..)
> 
>  /* For the high buffers we clear the interrupt bit and newdat */
> -#define IF_COMM_RCV_HIGH	(IF_COMM_RCV_LOW | IF_COMM_TXRQST)
> +#define IF_COMM_RCV_HIGH	(IF_COMM_RCV_LOW | IF_COMM_CLR_NEWDAT)
> 
> 
> I wonder if it generally works correctly, when the interrupt and newdat bits
> are handled separately, as the manual states:
> 
> 4.8.1 Reading from a FIFO Buffer
> When the CPU transfers the contents of Message Object to the IFx Message
> Bugger registers by writing its number to the IFx Command Request Register,
> the corresponding Command Mask Register should be programmed the way that bits
> NewDat and IntPnd are reset to zero
> (TxRqst/NewDat = ¡1¢ and ClrIntPnd = ¡1¢).
> 
> The driver seems to write these bits in different steps.

Well it says should. And the D_CAN manual says in 2.3.1.2

Note: A read access to a Message Object can be combined with the reset
of the the control bits IntPnd and NewDat. The values of these bits
transferred to the IFxMCTR always reflect the status before resetting
them.

I cant find a "must" anywhere.

But yeah, I've got suspicious about the validity of the split RX
buffer approach once I discovered the dropped packets when we reenable
the lower buffers. Note, this is independent of the method. The drop
happens with the old and the new one.

So the last patch in the series lets you use the clear the NewDat bit
right away aproach. That gets rid of the message loss, but opens an
opportunity for potential packet reordering.

Thanks,

	Thomas
--8323329-1296208067-1396628947=:14882--
