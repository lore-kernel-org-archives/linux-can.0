From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Thu, 15 Nov 2012 22:16:48 +0100
Message-ID: <50A55BC0.7030208@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <CABgkGoGYGpefppHUCnBZQQRX8Nn5_AnVdDPQ-gHs4H7vyVOVXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:51151 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab2KOVcn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Nov 2012 16:32:43 -0500
In-Reply-To: <CABgkGoGYGpefppHUCnBZQQRX8Nn5_AnVdDPQ-gHs4H7vyVOVXQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Casper Mogensen <casper.mogensen@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Michael Pellegrini <mikep86@gmail.com>, linux-can@vger.kernel.org, tomoya.rohm@gmail.com, Bhupesh SHARMA <bhupesh.sharma@st.com>, Alexander Stein <alexander.stein@systec-electronic.com>, federico.vaga@gmail.com, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Hi Casper,

On 11/15/2012 05:32 PM, Casper Mogensen wrote:
> Hi all
> 
> I have been working with the eg20t chipset and the pch_can driver a
> lot up until January this year, where the project i was working on
> unfortunately was shut down. There is a bug in the implementation,
> which causes the transmit buffers to fill up and all become
> unavailable. It happens randomly, but is easily triggered with a high
> load. I experienced the same problems as Michael.
> 
> I have not been working on it for a long time, so i don't recall the
> problem precisely, but as i remember there is two memory areas which
> is used for communication between the processor and the can core. One
> is used for receive, and one is used for transmit in the pch_can
> driver. When initiating a transmit, a flag is indicating that an
> interrupt must be generated upon transmit receive, if a transmit
> interrupt is handled during an ongoing transmit, then problems can
> occur.
> 
>>From pch_xmit in pch_can
> on line 940 in pch_can.c: can_put_echo_skb is called, which occupies
> the skb(which to my best knowledge, is the reason that you get a
> buffer overflow)
> on line 943 in pch_can.c: The transmit complete interrupt flag is
> written to the internal register (but not writing to the can core yet)
> on line 946 in pch_can.c: pch_can_rw_msg_obj is issued, which writes
> the internal registers to can core.
> 
> If the transmit completed handler has been running between lines 943
> or 946, the pch_tx_complete routine will clear the transmit interupt
> enable flag in priv->regs->ifregs[1] (same register is used in both),
> then you end up writing something the message to the core without
> transmit completed interrupt enabled, and with an occupied skb, then
> you eventually runs out of transmit buffers, as the skb's are free'd
> in pch_tx_complete, which is triggered by a transmit completed
> interrupt
> 
> I am a little rusty in this issue, as it is quite a long time ago i
> was working with it, but i hope the description is understandable :-)

Thanks for your info. This confirms that there is there is a bug
somewhere in the driver. Instead of chasing it, I prefer switching to
the C_CAN driver first.

Wolfgang.

