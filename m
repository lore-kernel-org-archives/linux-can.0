From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can probable bug
Date: Tue, 11 Dec 2012 17:22:09 +0100
Message-ID: <50C75DB1.3080703@grandegger.com>
References: <loom.20121211T155025-697@post.gmane.org> <loom.20121211T165553-739@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:34729 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab2LKQWM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Dec 2012 11:22:12 -0500
In-Reply-To: <loom.20121211T165553-739@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Christian Bendele <Christian.Bendele@gmx.net>
Cc: linux-can@vger.kernel.org

Hi Christian,

On 12/11/2012 05:08 PM, Christian Bendele wrote:
> Well, I just found the most recent patch to the generic c_can driver on this
> list. I had only checked with Kernel 3.7rcSomething before and it didn't seem to
> support the intel eg20t. I failed to check if there was a more recent patch
> available and if that supported the intel chip. I'm really sorry for that.
> 
> I will try if that patch works for me tomorrow, since unfortunatelly my working
> day is almost at its end and I don't have the hardware at home. However, cursery
> skimming the code of c_can.c, c_can_do_rx_poll() it seems to me as if it does
> the same thing here:
> 
> 
> 			if (msg_ctrl_save & IF_MCONT_EOB)
> 				return num_rx_pkts;

Just a quick answer. We know that the pch_can and also the c_can driver
does have issues with tx and rx. Races, out-of-order-receptions, etc. I
have sent patches for the C_CAN drivers to support the PCH as well. But
still the RX handling needs to be improved to avoid out-of-order
reception at high message input rate. I will tell more later today.

Wolfgang.

