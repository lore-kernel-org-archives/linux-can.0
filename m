Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287063;
	b=RYusuKxRWwWfI7Xk/rBIqqaaFOef0ARNAWzSsk3QneE9RwT3Wd2CklKDiIlcf7TXBy5c
	 bF0oXBls48Yks2pnjE7bL7DZg2xCxtD91/u1J1pOjzOrzgHbV1rczAyzou+KxVFcUEzIX
	 bk1PdSqa9kyv1I8IWgjFJZ+8TdRZ3gvu+BrAxOwCjHc9sCVlcpLWIbUirGrAwQ31xyX/r
	 n2qBYJ7ONNW3O3PalsBFU8upWbPvjvQfOCXMt2pstxPx/iZS95LrOG0OBFV2dVZOez/0T
	 Mwaak0nU8hkoQEvMgP4/b/zlHitigo96UtrWJb2qvsjj4hiX4dE3Tflu9oe3OaTwH4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Q2Yn1tisP/OswiGPs+zHZTzs8s2dnxotdAvNysGFK0A=;
	b=z9JO1trJwPXwL6h7+n231Lb3MnAgJW37L4sdsTsqWrwHWY12c4QSkwyFWDGSDH4jHCSh
	 7zSn6L6SIBWwnZzcJCp68gsZEOiT2MUW5MLf1GsV/EcYmGzu2qI6hDViYlWOUYiwN/cza
	 N40a5pSrBQ1QQk9T85DEfjCAXcTJRSIZ8HsqmhZnbjBFQo/s/uJqMnZ0lCNNobcGKzOcp
	 FCk+j9ID1DWYY5cZP76Ib2Tl7ISUE2WT+47FD3qLdtljpxFp44X3WZIfD6RSryD64KJPN
	 ki8d8voF8byqBVuugOKf5dpYHkWyxfcgfM2604b6nsqRacWqPqES60aJUlxG3c6NIYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YgZGq714;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C91606B880
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 05:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6C91606B880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YgZGq714
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2857053eec.0
        for <linux-can@vger.kernel.org>; Mon, 09 Nov 2026 21:04:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794287062; cv=none;
        d=google.com; s=arc-20260327;
        b=bkvtGgOaDgZ1Us0tBDIwvtbYViRiPhB27HvVpxaHCOs6RpibFWARD6SBGQoRrSbLvM
         yh6CsDpmwc9Lx4RLCpL1npkNv8tHggmPZfJYTIJ0WPLnJGIQig5V4LbVEkJgRaBe3y3N
         HM7Xsb47/VMUOIaBJCcW/na6phxikNIjebjzPlSUgsQeVEnlmY4lxNkqSUVy521wygD3
         fU+qjxs4pGbHkBP2c6SgAMTv7OmKgEvyb7SJAvI7cudkdMOleCUFAQWX6KusiqC84JKF
         HX3xQNBc6d+pTh1zhSF/VusN2iheHWnZhwFk5pg6RIYvOvw3AZ0OwljJwLsvYVCteW9w
         t70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q2Yn1tisP/OswiGPs+zHZTzs8s2dnxotdAvNysGFK0A=;
        fh=UDmiFjDUsl58/oI1pbxKLXmAuoEiB7qNSJQzd9c7Gr0=;
        b=TLMZJm6C8V+v6JV2GQ05FZsZnmxy6UpFSSv/4W+K2N/yV0ZN1PqCN4V140vqoNqjmp
         YS2hO6e44zZ0XikExc5Ymy9LAnsAWgrzStn455sIlY4PGtnY1iLkm8eWyzMI4WDEJi9O
         gBkGaCTK/ogQmYfiqAlGT2dNnFgDY2jDCju3DgBw18NM66buxbGH2YQ/0nxbJKrf9tR/
         B+XssEwdxJPZbUF4izOS0fc2WuBBkaISQUjq0LlaiRuHljzQGjp2xUPvp9xT1RLxWTEC
         3b8ONIt2DZhpaEq7dr3rt9qQqlj3C8Lg0gYevfY60Eb/K30ziqvSIeMmI4tkvK/OKBIL
         jzQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794287062; x=1794891862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q2Yn1tisP/OswiGPs+zHZTzs8s2dnxotdAvNysGFK0A=;
        b=YgZGq714ve7yOQDZZOMowxqiubq+ObhP0Jx6+dyx0y6mGMFQsu3GRzShH04NWuzfeD
         8ZqWCd3Pyl0o+mYPwtc96+CGWozCkb+K1sVv/ph4O6JXwxrPgPejiHq34Dxgru7RNgLi
         r3inefZOLQ5emQkdHYUyYwjuk6uf+dL3yZkjJH/0TbEdEN8bluWNmcz5NlGju+UDBcFE
         LrBPrW0ZpReN2JwQvOL9NSI/5/cFImp9wA2zXnZfxtP0hjzMZrruwOyJ+WRb6F+kVY6A
         58aFo8KM6DpxQmrof4T8Eg5U0YDKK4AiB3A7UWRKQskzstQ7NfxRZI6ADuNtzTal6+kz
         F30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794287062; x=1794891862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q2Yn1tisP/OswiGPs+zHZTzs8s2dnxotdAvNysGFK0A=;
        b=wzNeymXzaWWbzcp3rbFdBftJp3mxOckRhwaP+4ojrXFpJ1jFnVB1wGwcbDbXHGSP+F
         0FZ5I1kJNJ56NrZevY8xqMDeRdA0RTqo2PzdBqin9Xc13tYByzffE4Txf0CGCEkQ818c
         7o268lvoCpuKkQYwMUHYA2jpAjUbVr7Fxhwtd/M2/7F3Cg7LSPJwFrBBAwVJlSWh7hYm
         /brXb6ZfirKKNrSHHEBQjCzd1Qp4hAllI8TUCYofqmuGSMDmx65JWL7FGc0o6BDli6uw
         DmsMeFjjobsMgivGUYlEEmqT7RNS5mIViJfgtClYDp3zoPBKM4qex2+vyxmQYHd0+MWs
         M8cA==
X-Gm-Message-State: APuU4Z+MM9ZZVzK4jBUc1dyD13bK8Nl764p7wh6SrjQE34+j87NegpSu
	xYCU3O4xvfuOdgceRANG0eEtXEndM/uVN9VYFJacF0CS2nhAxLB4GhUm1GbCC2wJ4JO+PtCi2P3
	InQ+i6KfMxMCsEA3OHIOFVo1VIufrCpQ=
X-Gm-Gg: AYBFou02hhXD2EBj4Bz83aV+k1z46fOsNF5yISkp4MwQ2O5YmBYdIt5d6t9T6H9sEnZ
	bzXmQhwliur1FkBS33Rvqx0uEL9ILbQ5k3dA9Pu6OCEHYDMlzUrGJ+D6e7sNIz450NEICftYNzY
	KLyeUAqx6ORxQSODvMhOFosJjNfS9zBw96sem9vQz141QzvZH65c0nBKhvKCfhZXaqvIIMDDIYr
	S0/nKY7DsC91aP8RxarASWNgk61zTvuYuROk7/9zG8mXD2U54ij2lZHS8Vuczc0Tvlw+Xnx/Ai2
	ql3bArpmdPb/c+yyUjsndlboEXyhafnSwLw+ShyFKqniGfjEBuo7sMI2o30HxW+RfGMb1sYLjcL
	GBOKZxBAQKwF/1j3tMfgFD3LEAjGgbcY2Zd/J+b6wRicU/gXW5XBhzqXbKc3HQQVqmGqx
X-Received: by 2002:a05:7301:4d14:b0:375:4f3e:643d with SMTP id
 5a478bee46e88-3754f3e6572mr1366564eec.27.1794287061607; Mon, 09 Nov 2026
 21:04:21 -0800 (PST)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109044911.1163505-1-hj351016@gmail.com> <sashiko-outbox-206243@kernel.org>
In-Reply-To: <sashiko-outbox-206243@kernel.org>
From: khj <hj351016@gmail.com>
Date: Tue, 10 Nov 2026 14:04:08 +0900
X-Gm-Features: AclHuK8NPclpnxbDVfdRuupti_xIrnwGoz-1etxbLKHG71lGSd6n99Oe1ZbDtoQ
Message-ID: <CAGr5VtNkwbhJSg9sFi=Lk67y9SA6ofQnpuBFa2NrKy8=mUecmQ@mail.gmail.com>
Subject: Re: [PATCH v2] can: peak_usb: pcan_usb: shut down restart timer on
 free to avoid use-after-free
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

You're right that timer_shutdown_sync() alone is not sufficient. The
restart URB submitted in pcan_usb_restart() is not anchored, so
peak_usb_unlink_all_urbs() does not kill it, and its completion handler
pcan_usb_restart_pending() can still run after free_candev() and
dereference the freed pcan_usb via mod_timer(&pdev->restart_timer, ...).
Shutting the timer down does not help once the object backing it is gone.

So the complete fix has to stop that URB as well, not just the timer --
e.g. anchor the restart URB so peak_usb_unlink_all_urbs() kills it, and
also cover the probe-error paths you point out (dev_free() being skipped
on a pcan_usb_get_serial() failure, and running before unregister_candev()
on a dev_set_bus() failure, with the restart URB potentially still in
flight because probe failure does not unlink it).

Since that becomes a teardown reorganization in your driver, I'd rather
not guess at the shape. Marc, how would you prefer this handled -- anchor
the restart URB into one of the existing anchors (tx_submitted) or a
dedicated one, and should the register_candev()-before-dev_init() ordering
be part of the same change? I'm happy to send a v3 once the preferred
direction is clear.

Thanks,
Hyunjung

2026=EB=85=84 11=EC=9B=94 10=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 1:49, =
<sashiko-bot@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] can: peak_usb: unanchored restart URB and timer mishandled in
>   pcan_usb_free()
> --
>
> commit 5d0ce26d62347660cb47c1b9c3037c160879b961
> Author: Hyunjung Ko <hj351016@gmail.com>
>
> can: peak_usb: pcan_usb: shut down restart timer on free to avoid use-aft=
er-free
>
> This commit adds a dev_free callback to pcan_usb that calls
> timer_shutdown_sync() on pdev->restart_timer before freeing the device.
>
> > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/=
usb/peak_usb/pcan_usb.c
> > index 8fd058c328564..113b2e7453310 100644
> > --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> > +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> > @@ -882,6 +882,19 @@ static int pcan_usb_start(struct peak_usb_device *=
dev)
> >       return pcan_usb_set_ext_vcc(dev, 0);
> >  }
> >
> > +static void pcan_usb_free(struct peak_usb_device *dev)
> > +{
> > +     struct pcan_usb *pdev =3D container_of(dev, struct pcan_usb, dev)=
;
> > +
> > +     /*
> > +      * The restart timer is armed from the restart-command URB comple=
tion
> > +      * (pcan_usb_restart_pending()), which is not anchored and so out=
lives
> > +      * ndo_stop/unlink_all_urbs. Shut it down -- not just delete it -=
- so a
> > +      * late completion cannot re-arm it after free_candev().
> > +      */
> > +     timer_shutdown_sync(&pdev->restart_timer);
> > +}
>
> [Severity: Medium]
> Can timer_shutdown_sync(&pdev->restart_timer) prevent a use-after-free if
> pcan_usb_restart_pending() runs after free_candev()?
>
> pdev->restart_timer is embedded in struct pcan_usb (allocated inside
> netdev_priv()), so a late pcan_usb_restart_pending() calling
> mod_timer(&pdev->restart_timer, ...) after free_candev() still
> dereferences freed memory.
>
> Also, in peak_usb_create_dev(), register_candev() is called before
> dev_init() and dev_set_bus():
>
> drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_create_dev() {
>     ...
>         err =3D register_candev(netdev);
>     ...
>         if (dev->adapter->dev_init) {
>                 err =3D dev->adapter->dev_init(dev);
>                 if (err)
>                         goto lbl_unregister_candev;
>         }
>
>         /* set bus off */
>         if (dev->adapter->dev_set_bus) {
>                 err =3D dev->adapter->dev_set_bus(dev, 0);
>                 if (err)
>                         goto adap_dev_free;
>         }
>     ...
> adap_dev_free:
>         if (dev->adapter->dev_free)
>                 dev->adapter->dev_free(dev);
>
> lbl_unregister_candev:
>         unregister_candev(netdev);
>     ...
> }
>
> If the registered interface is brought up and triggers a restart while
> probe is still running, a failure in pcan_usb_get_serial() inside
> pcan_usb_init() jumps to lbl_unregister_candev and skips pcan_usb_free()
> completely.  A failure in dev_set_bus() runs pcan_usb_free() before
> unregister_candev(), and because probe failure does not call
> usb_disable_interface() and peak_usb_unlink_all_urbs() does not kill the
> unanchored restart URB, that URB can remain in flight across
> free_candev().
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109044911.11=
63505-1-hj351016@gmail.com?part=3D1
