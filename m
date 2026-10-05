Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B40B4078E8
	for <linux-can@vger.kernel.org>; Mon,  5 Oct 2026 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197559; cv=none; b=DUwH/49smROSKRgRa2A5FqUhigsVEABudTEac69QBtIuGJ1l8gH6ItT2sg0sZ5xqQRcSq+2w6GJGY0x5yqWtKN4E5vQDWdpLTYu/6ajEx8V8oX3FyL/3E4rgiXKPC+zk7sk/f5Wu+sJRicE2GMj0Y7IOui9NGkjueaW9Ifvi7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197559; c=relaxed/simple;
	bh=6rAW56aJzeCMtUKYVi40T4uwwNiNHC46o8/m4FwVqEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C/hGUDXtza0QnupkF1Xn8GegH1t7O6Y0MOWuvF558oOKdhKa6EtDPgJW9mnvVSors9PlHM2Q9zsJAE1kQUQ2ZDEHntv/rbodTkAjYm4H01zKrSiRAHds/TwUONSEyCCvPdTOr6r0K9D9dIILXoXr+Tv3DXQtp9sKopkwKZ8u+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqAWV2lZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqAWV2lZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C731F000FF;
	Mon,  5 Oct 2026 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197557;
	bh=zLl2TIDIVTsec/eXhn8UUcXL3kzDAYjyZYZioEnbejc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dqAWV2lZYsJ3VSuSSU52TM9vCXltAmECuAZOk2/g8VwlsQVjCVi1vgXUDgNgRZgii
	 /nTWed8mgOzKG0Var9mkIWejBQlyULb9QSH7AijHcUeTSuU5hmmMaGWaYFGcrc37i9
	 tmfV6tMEqoT9hz+SqYXBgp/2uREWN/VwJE2gUMQrn2GIfJv31siev35L+/lARvq6Ji
	 63lBcqpt7n0LC2pMFk7EPt++q76DtoLQxVsdfeZ/P4jWBGtpvPY5bDcyn+S9dT7aDr
	 yGurtun9n0Z99us6nPMvZgZguWkz2udaeWSy4kS4Rd2kz5oL975mYt7niOhhGHX7hv
	 xD9JwS7kCiYiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/2] can: mcp251xfd: mcp251xfd_irq(): add call to
 can_rx_offload_threaded_irq_flush()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20261005-upstream-can-rx-offload-batching-alternative-v1-2-4c08ccb516ec@pengutronix.de>
References: <20261005-upstream-can-rx-offload-batching-alternative-v1-0-4c08ccb516ec@pengutronix.de>
 <20261005-upstream-can-rx-offload-batching-alternative-v1-2-4c08ccb516ec@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 10:52:36 +0000
Message-Id: <20261005105237.47C731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] can: mcp251xfd: crash in __skb_cut_position() due to out-of-or=
der timestamps
--

commit b3d8ad3e6e4f0483e24aef1e8fa597af3b315e6a
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: mcp251xfd: mcp251xfd_irq(): add call to can_rx_offload_threaded_irq_fl=
ush()

Under certain load situations, the threaded IRQ handler will not exit
the while loop, resulting in unlimited growth of the skb_irq_queue.
This commit adds a call into the newly added function
can_rx_offload_threaded_irq_flush() to flush parts of the queue.

> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index f441f2265299e..208595c0cc469 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -1615,6 +1615,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev=
_id)
>  			}
>  		}
> =20
> +		can_rx_offload_threaded_irq_flush(&priv->offload);

[Severity: Critical]
Does this new loop expose a regression in the flushing logic when dealing w=
ith
out-of-order timestamps?

The mcp251xfd_irq threaded handler iterates over multiple RX FIFOs
sequentially. Packets from different FIFOs can overlap chronologically,
meaning a newly read packet from FIFO 1 may have an older timestamp than
a previously read packet from FIFO 0.

When can_rx_offload_queue_timestamp() is called, __skb_queue_add_sort()
inserts this older packet before the newer one in the skb_irq_queue:

drivers/net/can/dev/rx-offload.c:__skb_queue_add_sort() {
    ...
    __skb_queue_after(head, insert, new);
    ...
}

However, can_rx_offload_threaded_irq_flush() caches flush_skb and flush_len
as a snapshot:

drivers/net/can/dev/rx-offload.c:can_rx_offload_threaded_irq_flush() {
    ...
    if (!offload->flush_skb) {
        offload->flush_skb =3D skb_peek_tail(&offload->skb_irq_queue);
        offload->flush_len =3D irq_queue_len;
    }
    ...
}

If an older packet is subsequently inserted before flush_skb, the physical
number of elements from the head to flush_skb will exceed the cached
flush_len.

When __skb_cut_position() slices the queue, it uses the stale flush_len:

drivers/net/can/dev/rx-offload.c:__skb_cut_position() {
    ...
    list->qlen =3D qlen;

    WRITE_ONCE(head->next, new_first);
    WRITE_ONCE(new_first->prev, (struct sk_buff *)head);
    head->qlen -=3D qlen;
    ...
}

This leaves skb_irq_queue.qlen under-decremented. Over multiple iterations
of this new while loop, qlen grows artificially large.

Eventually, irq_queue_len exceeds the flush threshold even when the queue is
physically empty, causing skb_peek_tail() to return NULL for flush_skb.
__skb_cut_position() then dereferences entry->next where entry is NULL:

drivers/net/can/dev/rx-offload.c:__skb_cut_position() {
    ...
    struct sk_buff *new_first =3D entry->next;
    ...
}

Can a remote attacker trigger this kernel panic by flooding the CAN bus
with traffic to distribute packets across multiple FIFOs, creating the
out-of-order timestamp scenario?

>  		handled =3D IRQ_HANDLED;
>  	} while (1);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-upstream-c=
an-rx-offload-batching-alternative-v1-0-4c08ccb516ec@pengutronix.de?part=3D2
