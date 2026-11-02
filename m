Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635309;
	b=V5Y0u71IWDyE0sJ4mzAjJrk/KQZ2Fyw5tVf0l6Jdgje0S6g4dLRiCZ8S27LMn/zGeIOA
	 lS9bWwsusnrOCdMlWZflDa2TFpl60T5np7zf0D0iF1IZ3qq5lj+w1yJxzXtnj0kHcn2ol
	 FMPypAzbYjsbfZ08ZwqZCYhxiAHs2Lf+I+wiNL2856y4uhbuHm5EK/1ZiVUpQI1M0ZuKj
	 fuMsbcrLPlGi8yZdHR476o9OTHkagpgjbHwdChLMYuvve6ul6ddhz7etvpTiBmluxAgWl
	 mstLtoC0WwS5TvMqGTvZ8JeEN8EAO3v+ZrHfvfDdiWLaCwHVI88aE1JV7h0AOZbcIQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ESWkqGTIhab5jC/IQdFT3w7WCcFwwHCysvVp7HIJ1As=;
	b=Vrpj3MSqUQiSmGzLZeQxOgEoe7yFhwUhbgHJM9h1qbJG6V2GFsAZwx4y1yPX4f168oEU
	 abXMTUv4Jag7x1Bc6X06NXIBpRpVtT+Y+jT1jJ3TQtIUO6H4H5mzXX/hvLruhbNefJ5Y+
	 Tw8KwuGI4LRRNg2+zW9CcEdqEUf93IqVIQjoArn6X5XvDdl24E3K0+GtBjlQ18hvT3wnv
	 1oYphTUCan1jNrSpPdW61VGq/y5NR2V82zSY1kJd43BZ/ojc6ZrLs5zkwz/m4xE5KaHFl
	 PbmdJl/caDfYjAbP/WtGTecILXXQ38LCGqGI5bqAwFOP20ow7fliIfsYxDleyMvztWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yj6ubjIc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C44606A5A7
	for <linux-can@vger.kernel.org>; Mon,  2 Nov 2026 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yj6ubjIc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F001F00A16;
	Mon,  2 Nov 2026 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793635308;
	bh=ESWkqGTIhab5jC/IQdFT3w7WCcFwwHCysvVp7HIJ1As=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yj6ubjIcax/xahmOg/qOc+FZ641WzV4jIWw/Wmg1bH+oPJZaGKghvucnlaDs7dQ8G
	 PLFQWh890ISphOx+aTsfNOv7BJQ4JkgCrmbhdYBkQ+dx4qQdD8R3gHSO9uQ8h533w9
	 TQAWuBXZb3/OXjtRrEZpT/+sfgVdVJZfQnMIGM9TJ2+fFl+DbBft26GRKNUOe8BLdR
	 kIyyGcnzKN4R7Lf5f2vAUA82TWsgiRgEqA8HYLwpIsLP7xK/0RlMlWwCCwLM4m4BQ8
	 iAG5oEucugYLftTXAY0R7e77N1/2HxW35WID4g9L+Sf0/BZnRgAhi+b7TQj8Uh2T33
	 2/PNbimUIx9mg==
Message-ID: <sashiko-outbox-193720@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: j1939: fix skb refcount underflow in session
 teardown paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261102155345.1267524-1-tristan@talencesecurity.com>
References: <20261102155345.1267524-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 16:01:47 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: j1939: skb and sock leak in j1939_session_destroy() and j1939=
_session_skb_drop_old()
--

commit 48d3734ee23304ec7eb1426db9d761018f0ff9d3
Author: Tristan Madani <tristmd@gmail.com>

can: j1939: fix skb refcount underflow in session teardown paths

This commit removes the explicit skb_unref() calls before kfree_skb() in
j1939_session_destroy() and j1939_session_skb_drop_old() to avoid a
refcount underflow.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..3173936bd6f6e 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -277,11 +277,8 @@ static void j1939_session_destroy(struct j1939_sessi=
on *session)
>  	WARN_ON_ONCE(!list_empty(&session->sk_session_queue_entry));
>  	WARN_ON_ONCE(!list_empty(&session->active_session_list_entry));
> =20
> -	while ((skb =3D skb_dequeue(&session->skb_queue)) !=3D NULL) {
> -		/* drop ref taken in j1939_session_skb_queue() */
> -		skb_unref(skb);
> +	while ((skb =3D skb_dequeue(&session->skb_queue)) !=3D NULL)
>  		kfree_skb(skb);
> -	}
>  	__j1939_session_drop(session);
>  	netdev_put(session->priv->ndev, &session->priv_dev_tracker);
>  	j1939_priv_put(session->priv);
> @@ -342,8 +339,6 @@ static void j1939_session_skb_drop_old(struct j1939_s=
ession *session)
> =20
>  	if ((do_skcb->offset + do_skb->len) < offset_start) {
>  		__skb_unlink(do_skb, &session->skb_queue);
> -		/* drop ref taken in j1939_session_skb_queue() */
> -		skb_unref(do_skb);
>  		spin_unlock_irqrestore(&session->skb_queue.lock, flags);
> =20
>  		kfree_skb(do_skb);

[Severity: High]
Does removing skb_unref() in j1939_session_destroy() and
j1939_session_skb_drop_old() leak every session-queued sk_buff and its
associated socket reference?

Every sk_buff queued into session->skb_queue starts with skb->users set to 1
from allocation (via alloc_skb() in j1939_session_fresh_new() for RX
sessions, or j1939_sk_alloc_skb() in j1939_sk_send_loop() for TX sessions).

When the initial skb is queued in j1939_session_new(), it takes a second
reference while callers do not drop the initial allocation reference on
success:

net/can/j1939/transport.c:j1939_session_new() {
	...
	skb_queue_head_init(&session->skb_queue);
	skb_queue_tail(&session->skb_queue, skb_get(skb));
	...
}

net/can/j1939/transport.c:j1939_session_fresh_new() {
	...
	skb =3D alloc_skb(size + sizeof(struct can_skb_priv), GFP_ATOMIC);
	...
	session =3D j1939_session_new(priv, skb, size);
	if (!session) {
		kfree_skb(skb);
		return NULL;
	}

	/* alloc data area */
	skb_put_zero(skb, size);
	/* skb is recounted in j1939_session_new() */
	return session;
}

Similarly, in net/can/j1939/socket.c, j1939_sk_send_loop() allocates each TX
segment skb with skb->users =3D=3D 1 and passes it to j1939_tp_send() ->
j1939_session_new() or to j1939_session_skb_queue(), which also increments
skb->users to 2 without the caller dropping the initial reference:

net/can/j1939/transport.c:j1939_session_skb_queue() {
	...
	skb_get(skb);
	skb_queue_tail(&session->skb_queue, skb);
	...
}

Because transient users of the queued skbs (such as j1939_session_tx_dat(),
j1939_simple_txnext(), j1939_session_completed(), and
j1939_xtp_rx_dat_one()) acquire their own reference via
j1939_session_skb_get_by_offset() or j1939_session_skb_get() and balance it
with consume_skb() or kfree_skb(), every skb resting in session->skb_queue
has a refcount of 2.

Without the skb_unref() calls in j1939_session_destroy() and
j1939_session_skb_drop_old() (or alternatively removing the extra skb_get()
in j1939_session_new() and j1939_session_skb_queue()), won't kfree_skb()
only decrement skb->users from 2 to 1, leaking the sk_buff and preventing
sock_wfree() from ever releasing sk->sk_wmem_alloc and the struct sock
reference on TX sessions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102155345.1267=
524-1-tristan@talencesecurity.com?part=3D1
