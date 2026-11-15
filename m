Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794722468;
	b=0ZN9010ol2rrGpvJTXp3v8np5tZsHYhtfMv+BgkkfjEAImzHc4seaFtQE/fwxsdVgACA
	 zboK5VtgCOr5xXRev2fIOZMwmyAuDi6QgEwosbIQ9qud/M5y3wcgSToArDHtfctvFcWgq
	 Sqf6NZ8EJzPijM1LQchJ2tsiuKt7E+v63H9S3bZ+uj31KVs3YV3kr4bFW9LoFpqc7vAxn
	 Gn270PocvM1nEx2zPUMwzJfUwRRHksb6CnYzxBYszPuOWQ0eSbPGEd9dlegdlKj5pV2aq
	 2LlJE23tF+VNxDdLkXLiQE368CpAfaJur+o/wACHM8ppXXVV5Srbe32k0LrnfFP7K8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794722468;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LrinZphhSJcSFpsIBZVcU58l61eV9indvmAvPOaeYNQ=;
	b=1i6v00OH70S+PHUwKnifTpdcsDOGigbY++2N5WhUUXH9RL73zmFaEABc7dSCb4tuwTmT
	 REmo07YHKUltVdxf4Q3Wa+1MCv1CXeecGGgg6ErwLxN7ivJXcoG62pToO8ztPUiHtO42z
	 IVGFZQOHPShhdD0p9kRCRPfu4XwrKUf5daBggXfeaZ6q+OujjGbJwWKlhk1aaaU3qdDR9
	 OCbAs88UzhUKrQsOUJ4tGdsyuZzlw7XgEx3sOWptde8cggj4ZgPBWJjTtO5kz1JdD6jUN
	 NS2voKCvlzgezHoSqS2b8BpemTVS/U/L+tR2++runCD9Pm5VFHc6ROa5F4BTTsfENVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OR2+Hj1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F5606A32C
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OR2+Hj1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F581F000C4;
	Sun, 15 Nov 2026 06:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794722467;
	bh=LrinZphhSJcSFpsIBZVcU58l61eV9indvmAvPOaeYNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OR2+Hj1BVeAdH3FqPX5/viiCr4Dh2oZLpm/TH+gccSuWs7P4CQ8Qv/x235rXxntiQ
	 0KsxlLSj5rfvZztHBCNKlhEPiTwiHtw13bfo1v1gUP9DhAS9yQ64kCrdZ5A0eUP6CX
	 2IsW0VT/MtuQlFOXT21aRJtjkMOup+tXsgHKgHl0sqkGH3PW/yNUa5dpKzol4D6oCp
	 CgC0bje3wDmeYT3C2OiCP1jmVLv5Q0q/38XA+PJV5p64usd1Q4rlPqIiHlK5OwMNQq
	 GSLEfduPP0XWAbKNe3Q5sDtDiBno5K7D2pigtfxQnPArFJ4wR2v8R/1Wf/vsZMq2vs
	 D1EGonHwcvCsg==
Message-ID: <sashiko-outbox-215239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/6] can: j1939: fix possibility of UAF on module
 unload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <1e3283a1-82f4-42c4-874a-96db238d25e4@I-love.SAKURA.ne.jp>
References: <7cc08b0f-290e-464b-ab13-0a5ce3c57f4f@I-love.SAKURA.ne.jp>
 <1e3283a1-82f4-42c4-874a-96db238d25e4@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 06:01:07 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] can: j1939: premature module_put() in
  __j1939_priv_release_work()
--

commit 9938b84eee258ec84033c319ff76028286604caa
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: fix possibility of UAF on module unload

This commit ties a module reference to each struct j1939_priv and defers
its final release to a dedicated workqueue that is destroyed in
j1939_module_exit().

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index d9384cf0e356f..0b8ac4fe0479d 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
[ ... ]
> @@ -152,9 +159,9 @@ static inline void j1939_priv_set(struct net_device *=
ndev,
>  	can_ml->j1939_priv =3D priv;
>  }
> =20
> -static void __j1939_priv_release(struct kref *kref)
> +static void __j1939_priv_release_work(struct work_struct *work)
>  {
> -	struct j1939_priv *priv =3D container_of(kref, struct j1939_priv, kref);
> +	struct j1939_priv *priv =3D container_of(work, struct j1939_priv, relea=
se_work);
>  	struct net_device *ndev =3D priv->ndev;
> =20
>  	netdev_dbg(priv->ndev, "%s: 0x%p\n", __func__, priv);
> @@ -165,6 +172,22 @@ static void __j1939_priv_release(struct kref *kref)
> =20
>  	netdev_put(ndev, &priv->dev_tracker);
>  	kfree(priv);
> +	/* This is safe, for j1939_module_exit() waits for completion of
> +	 * this callback using destroy_workqueue().
> +	 */
> +	module_put(THIS_MODULE);
> +}
> +
> +static void __j1939_priv_release(struct kref *kref)
> +{
> +	struct j1939_priv *priv =3D container_of(kref, struct j1939_priv, kref);
> +
> +	/* Since synchronously dropping module refcount of self is not safe,
> +	 * defer actual release to WQ context.
> +	 */
> +	INIT_WORK(&priv->release_work, __j1939_priv_release_work);
> +	queue_work(j1939_wq, &priv->release_work);
> +
>  }

[Severity: Medium]
Can __j1939_priv_release_work() drop the final module reference and allow
can-j1939 to be unmapped before the caller of j1939_priv_put() has finished
executing module code?

Later patches in this series defer struct j1939_ecu destruction to
j1939_wq, but struct j1939_session destruction remains synchronous.  An RX
session created by j1939_xtp_rx_rts_session_new() has no associated socket
and holds a reference to priv, so it can outlive all J1939 sockets.  When
its timer expires, j1939_session_destroy() drops the last reference to
priv before freeing the session and returning:

net/can/j1939/transport.c:j1939_session_destroy() {
    ...
	__j1939_session_drop(session);
	netdev_put(session->priv->ndev, &session->priv_dev_tracker);
	j1939_priv_put(session->priv);
	kfree(session);
}

Because j1939_wq is a WQ_HIGHPRI workqueue and destroy_workqueue(j1939_wq)
only waits for work items on j1939_wq, the module can be unloaded while
the timer callback is still unwinding:

CPU0                              CPU1
j1939_tp_rxtimer()
  j1939_session_put()
    j1939_session_destroy()
      j1939_priv_put()
        __j1939_priv_release()
          queue_work(j1939_wq, ...)
  [preempted]
                                  __j1939_priv_release_work()
                                    kfree(priv)
                                    module_put(THIS_MODULE)
                                  delete_module()
                                    j1939_module_exit()
                                      destroy_workqueue(j1939_wq)
                                    free_module()
      kfree(session)  <-- executes unmapped module text

Deferring session destruction (or the j1939_priv_put() call in
j1939_session_destroy()) to j1939_wq as well would ensure
destroy_workqueue(j1939_wq) waits for all module code paths to finish.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/7cc08b0f-290e-464b-=
ab13-0a5ce3c57f4f@I-love.SAKURA.ne.jp?part=3D1
