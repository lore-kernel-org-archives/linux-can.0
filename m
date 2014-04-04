From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/10] can: c_can : Disable rx split as workaround
Date: Fri, 4 Apr 2014 20:55:34 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404042055020.14882@ionos.tec.linutronix.de>
References: <20140404134816.751883017@linutronix.de> <20140404134858.173427806@linutronix.de> <533EEEC8.3090905@hartkopp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42724 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbaDDSzY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 14:55:24 -0400
In-Reply-To: <533EEEC8.3090905@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

On Fri, 4 Apr 2014, Oliver Hartkopp wrote:

> 
> -------- Original Message --------
> Subject: [patch 10/10] can: c_can : Disable rx split as workaround
> 
> (..)
> 
> +config CAN_C_CAN_NO_RX_SPLIT
> +	bool "Disable RX Split buffer"
> +	---help---
> +	  RX Split buffer prevents packet reordering but can cause packet
> +	  loss. Select the less of the two evils.
> +
> 
> Can you try to use something more understandable for the Kconfig option?
> 
> AFAICS there are the options:
> 
> 1. Frames are in order but may get lost.
> 2. Frames do not get lost but may be disordered.
> 
> No user/kernel builder knows about "rx split buffers" ...
> 
> What about
> 
> +config CAN_C_CAN_STRICT_FRAME_ORDERING
> +	bool "Force a strict RX CAN frame order (may cause frame loss)"
> +	---help---
> +	  The RX split buffer prevents packet reordering but can cause packet
> +	  loss. Only enable this option when you accept to lose CAN frames
> +	  in favor of getting the received CAN frames in the correct order.
> +

Way better :)
