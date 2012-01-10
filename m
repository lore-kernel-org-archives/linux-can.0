From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Possible bug in ac_msg_is_request_for_ac
Date: Tue, 10 Jan 2012 16:01:58 +0100
Message-ID: <20120110150158.GB2524@e-circ.dyndns.org>
References: <1326198848.2189.9.camel@osblap120.dev.osb-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:23065 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752239Ab2AJPC1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2012 10:02:27 -0500
Content-Disposition: inline
In-Reply-To: <1326198848.2189.9.camel@osblap120.dev.osb-ag.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Felix Obenhuber <felix@obenhuber.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Felix,

Thanks for pointing out this issue.

By a second look, this function is only used to decide if a request
from source address 0xfe may be sent out.
I'm sure my intent is conform to the specification, but I'm
not sure anymore taht I should enforce such policy inside the kernel.

I may as well delete the function completely ...

Any opinion?

Kurt

On Tue, Jan 10, 2012 at 01:34:08PM +0100, Felix Obenhuber wrote:
> Hi Kurt,
> 
> just wondered about the last line in ac_msg_is_request_for_ac
> https://gitorious.org/~kurt-vd/linux-can/can-j1939-modules/blobs/master/net/can/j1939/address-claim.c
> 
> static inline int ac_msg_is_request_for_ac(struct sk_buff *skb)
> {
>         [...]
> 	req_pgn = skb->data[0] | (skb->data[1] << 8) | (skb->data[2] << 16);
> 	return req_pgn = PGN_ADDRESS_CLAIMED;
>                     ^^^^^^
> 
> Think here's a equal sign missing cause you always return
> PGN_ADDRESS_CLAIMED.
> 
> Cheers,
> 
> Felix
>               
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
