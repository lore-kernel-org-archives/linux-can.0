From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 07/14] can: af_can: give variable holding the CAN receiver
 and the receiver list a sensible name
Date: Thu, 24 Aug 2017 15:27:26 +0200
Message-ID: <dcc2b165-e262-d442-d97d-db60b64bc3ae@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-8-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:30732 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdHXN12 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 09:27:28 -0400
In-Reply-To: <20170802174434.4689-8-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
> This patch gives the variables holding the CAN receiver and the receiver
> list a better name by renaming them from "r to "rcv" and "rl" to
> "recv_list".

Comment not consistent to code.

> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Indeed I would suggest 'rcv' and 'rcvlist'

> -		hlist_add_head_rcu(&r->list, rl);
> +		hlist_add_head_rcu(&rcv->list, rcv_list);

would lead to

 > +		hlist_add_head_rcu(&rcv->list, rcvlist);

which looks better to me.

Regards,
Oliver

