Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855068;
	b=FGji3WqaFtez+6yZVxoXYhnPshODp8zBc8CT5jbXDPNYGviUBE51jCehVBaPJh8G4b2q
	 mta1FoieEmyvEm3u3QzriUN5FQEjRgSQC6ze5NIUIIiUQ0GgjiM6/8YUgCzdIejTp66I5
	 NwnFvOR+Qv5Pmq7uDnXir3Qmyeh7pTPelnLQD1Q2lxPjKr/fk/E7qAd4VmvoFlDAnzx5y
	 Wv561lZcBaiagTXnlp8Hhud0g8+mUR1l8g30zPMEp/bgY3k9nD2XyqK7r1cwI6amP9cjv
	 uHwkHhr3FuAJSpLp1kX6vJeztSl8HR2QcSTapU+704qxgA7cOwwz2/OTPeTIc61x56A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855068;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fPjuZ95aldOCVUpvxaQe1MRfmQx8bQpbWuALkokIV1o=;
	b=pnapjdyb1tcIOI4anrvmf0d8FWpsU7E/uOWT4dyEi5/VX7NmgA3+ahWisiYaOHyPEFR7
	 m4xzLy51Ly0UIb7BpMOJ8n9RQpOYPprqtBFU6rGInJ8wpZ4Dk1VT7mhyfeqBc1yiXAP0T
	 v+mMXdBeUCVIeiB0PTkvoDzees0X02bLrVqQDtQy1llBozcBlPctTrmi8alxNz0Gk1Vaj
	 DGa226yJ51+TP5Kgzc+Ynd6z0wqJnjRjti3wU5UaGunYOFDSa33zgF2dgyYuNkY6ZQpy/
	 S1/+mTIxUo2vLzRQXQ5mJ4OjLbj5ZCvr8ko7GJ+Jp0GmA4ItDgtGhe8isQCgXOVdi+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qo8Qj7IP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1FC606A31C
	for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qo8Qj7IP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9EA1F000C9;
	Mon, 16 Nov 2026 18:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855068;
	bh=fPjuZ95aldOCVUpvxaQe1MRfmQx8bQpbWuALkokIV1o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qo8Qj7IP7I7CWWiwl21L+Do84OgWh3lcz5Lf01aC8wfVnIxWxI2vWLCsMHV0j6yMs
	 n21zc/ZSyaAqCUSwE1Hl5YLCBFgIGFYFlz27QmKyZV3tbhlJlDxOI2PyUYw2JJfw4I
	 Ipdr6GH2P8j1+EFdmu1zbQ8oVMqLOzQf7dIOvJT0cX9Mtboq6gYSM7qV/t+TJzyg74
	 j4RJPAp4K5zL/h2n7Qzto7yUCuOZnE6E4GkKgjiPYrZ6yA2U8Erk0FFFiJlTKe/me4
	 SYSDP5TK2HEklEDJUwMuzwznSkRr67jNxfZAyGz4tdtf3UhGF8pAtB0ivcYXruHGoZ
	 liZf847tiE/Bw==
Subject: Re: [PATCH v13 3/6] can: j1939: fix possibility of list corruption in
 __j1939_ecu_release()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Mon, 16 Nov 2026 18:51:07 +0000
Message-ID: <179485506755.3132.13332798408962944370@kernel.org>
In-Reply-To: <1885f3ed-e560-4cbf-aa0e-96cb1718b394@I-love.SAKURA.ne.jp>
References: <1885f3ed-e560-4cbf-aa0e-96cb1718b394@I-love.SAKURA.ne.jp>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message understates the bug being fixed.
- [Low] This patch leaves a cross-file comment out of date.

--

can: j1939: fix possibility of list corruption in __j1939_ecu_release()

This patch moves the release of struct j1939_ecu into a work item on
j1939_wq. The work item does list_del(&ecu->list) with priv->lock held
for write. Readers of priv->ecus and priv->ents[] now skip ECUs whose
kref has already dropped to zero, using kref_get_unless_zero() and
kref_read().

> Since j1939_ac_recv() and j1939_ac_fixup() are calling j1939_ecu_put()
> without priv->lock held for write, list corruption might happen if the
> last user called j1939_ecu_put() without priv->lock held for write.

[Severity: Low]
Does "list corruption" cover the whole bug? Before this patch,
__j1939_ecu_release() did list_del(), netdev_put() and kfree(ecu) in
one go, with no lock held.

In steady state, the only ref on a mapped ECU is the priv->ents[]
mapping ref. net/can/j1939/address-claim.c:j1939_ac_fixup() then does:

    ecu = j1939_ecu_get_by_name(priv, skcb->addr.src_name);  /* ref 2 */
    ...
    if (ecu->addr != skcb->addr.sa)
        j1939_ecu_unmap(ecu);                                 /* ref 1 */
    j1939_ecu_put(ecu);                                       /* ref 0 */

The last put frees the ECU without taking priv->lock. At the same time,
another CPU can be walking priv->ecus under read_lock_bh(&priv->lock):

net/can/j1939/bus.c:j1939_name_to_addr() {
    ...
	read_lock_bh(&priv->lock);
	ecu = j1939_ecu_find_by_name_locked(priv, name);
	if (ecu && j1939_ecu_is_mapped_locked(ecu))
		/* ecu's SA is registered */
		addr = ecu->addr;
    ...
}

That walker can read ecu->name, ecu->addr or ecu->list.next of an ECU
that was just freed. The result is a use-after-free read, or a fault on
LIST_POISON. j1939_ecu_get_by_name() has the same exposure.

The code change in this patch closes this too: the work item does
list_del() under write_lock_bh() before kfree(), and readers check the
kref.

Could the commit message say that the race can also cause a
use-after-free, not only list corruption? Stable backporters will use
that description to judge the patch.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..0aeeee1491e4f 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -14,25 +14,47 @@
>  
>  #include "j1939-priv.h"
>  
> -static void __j1939_ecu_release(struct kref *kref)
> +static void __j1939_ecu_release_work(struct work_struct *work)
>  {
> -	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
> +	struct j1939_ecu *ecu = container_of(work, struct j1939_ecu, release_work);
>  	struct j1939_priv *priv = ecu->priv;
>  
> +	write_lock_bh(&priv->lock);
>  	list_del(&ecu->list);
> +	write_unlock_bh(&priv->lock);
>  	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
>  	kfree(ecu);
>  	j1939_priv_put(priv);
>  }
>  
> +static void __j1939_ecu_release(struct kref *kref)
> +{
> +	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
> +
> +	/* Since not all callers are calling j1939_ecu_put() with priv->lock
> +	 * held for write, defer actual release to WQ context. By deferring to
> +	 * WQ context, readers might find ECUs with ecu->kref == 0. Therefore,
> +	 * readers must validate with j1939_ecu_valid() or j1939_ecu_get().
> +	 */
> +	INIT_WORK(&ecu->release_work, __j1939_ecu_release_work);
> +	queue_work(j1939_wq, &ecu->release_work);
> +}

[Severity: Low]
Should the comment in __j1939_priv_release_work() in
net/can/j1939/main.c be updated as well? Its step (3) still names
j1939_ecu_put() as the path that drops the last priv ref while
priv->lock is held:

	 *   (3) A user who unexpectedly became the last user of "struct j1939_priv"
	 *       indirectly calls j1939_priv_put() via e.g. j1939_ecu_put(ecu).

After this change, j1939_ecu_put()->__j1939_ecu_release() only queues
the work item. The j1939_priv_put() in bus.c now runs only in
__j1939_ecu_release_work(), after write_unlock_bh(&priv->lock).

Other paths may still justify the write_lock_bh()/write_unlock_bh()
barrier there, but the example given in that comment no longer fits.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/7cc08b0f-290e-464b-ab13-0a5ce3c57f4f%40I-love.SAKURA.ne.jp
