From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH] can-j1939: fix ecu allocation at bad time
Date: Thu, 9 Mar 2017 11:06:39 +0100
Message-ID: <20170309100639.GC32600@airbook.vandijck-laurijssen.be>
References: <20170309093304.31542-1-maxime.jayat@mobile-devices.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:42947 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbdCIKHL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Mar 2017 05:07:11 -0500
Content-Disposition: inline
In-Reply-To: <20170309093304.31542-1-maxime.jayat@mobile-devices.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maxime Jayat <maxime.jayat@mobile-devices.fr>
Cc: linux-can@vger.kernel.org

Hey Mark,

When you resume your j1939 mainline work, please add this patch.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

--- Original message ---
> Date:   Thu,  9 Mar 2017 10:33:04 +0100
> From: Maxime Jayat <maxime.jayat@mobile-devices.fr>
> To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> Cc: linux-can@vger.kernel.org, Maxime Jayat <maxime.jayat@mobile-devices.fr>
> Subject: [PATCH] can-j1939: fix ecu allocation at bad time
> X-Mailer: git-send-email 2.9.3
> 
> In _j1939_ecu_get_register, create_if_necessary was ignored, which
> lead to memory corruption (because of a bad refcount) when rebinding a
> socket to a NAME corresponding to an ecu which had been unregistered
> by an external address claim.
> 
> During the bind, in j1939_name_local_put, the ecu was reallocated, added
> to the list of ecus and then freed immediately. So the list contained an
> invalid item.
> 
> For instance, this created the problem:
> 
> - Bind a J1939 socket to source address 0x80 with name
>     0x7777777777777777
> - Send an address claim for this source address
> - Another "external" ECU sends an address claim for 0x80 with name
>     0x1111111111111111 (which has higher priority, so "wins" the source
>     address).
> - Re-bind the J1939 socket to source address 0x81.
> 
> Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
> ---
> 
> After mentioning the problem on the mailing list six months ago
> without much interest, I fixed it, but forgot to share the patch.
> Sorry about that!
> 
> This applies on top of j1939d-v4.7 but it is probably necessary for
> all j1939d branches.
> 
>  net/can/j1939/bus.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 651de574a3c5..a4d5877c8e0a 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -62,6 +62,10 @@ struct j1939_ecu *_j1939_ecu_get_register(struct j1939_priv *priv, name_t name,
>  		if (dut->name == name)
>  			return dut;
>  	}
> +
> +	if (!create_if_necessary) {
> +		return ERR_PTR(-ENODEV);
> +	}
>  	/* alloc */
>  	ecu = kzalloc(sizeof(*ecu), gfp_any());
>  	if (!ecu)
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
