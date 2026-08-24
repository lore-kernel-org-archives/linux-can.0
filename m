Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE3426694
	for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578211; cv=none; b=eu1u6shg7VOg0hx8zxSy+doluqwQ+xRqN617VK3r7VjVmFtqa+xlBd62l26xda2TdaJSkQW4uHpMYpCwrz2/UtCzFkqAMN5a0bEpBi83Y/w1mGlip/G/l6c6Rg3FkVJ5FLysOUzuZKKUM66uxHS3n4haZxgf7a1FOLiZSlyz77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578211; c=relaxed/simple;
	bh=q8dzWo6cqaoU0JH0K/tabZqO/kwPphQJpiwifkeV0U0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sKWfjdMfc77fTzr7nVJzapcxmeo4f5F0TP7i3dJUGiTD2JUDHcVqnm5FSROd+lFaR8JtPBGsFdi0gj6hl0wPvZ1sxbGv08Y+44dwJ2/gmSB+oE9R/PadPleid4AFpcr7nYV9vKnN6g4bu2LZ7MBvGY5K4de/Deb/t81/xxW6VIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f52KMwvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f52KMwvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF85A1F00A3A;
	Mon, 24 Aug 2026 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578210;
	bh=+UHK9QTtHveMNfEiQ9SIlD6n3wGbSCVbhcqESXSKVgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f52KMwvs+tUXphNHWPya7lzUqADBxwWdsmwr/jgI7FavgYjshKKZywp9+7bCkYxEC
	 a0B9p/TclzYCx64UNiCVaEbxt+KUf5oTzKvdQCeTL8CnPZwyAXYLAlrzyBfhaCzxuZ
	 neFLdCCsnD06/3zkBkQZ0c140RtQfQml1o4qI7bfBD/MzOBr48UnDNmdwcLoghxISp
	 b5pUeeGf4E6Wl3ZikK7oelaDvTfLrbJCftzhb+ONe8w/SavvstPjo218T54/2h4OSD
	 uDnHULOnqNaWMpjHWTWJX1KpMQsj9uM5sQz0dI7fAGIgOymoZZQ/rHm9w6rn+zMHed
	 zPzrkPJv9drrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size
 mismatch
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmktWmUgSG9uZyAoUGV0ZXIgSG9uZyk=?= <peter_hong@fintek.com.tw>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw>
References: <20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:30:09 +0000
Message-Id: <20260824133009.CF85A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Improper teardown order in `f81604_close()` allows asynchronous wo=
rk to be scheduled after `cancel_work_sync`, leading to a Use-After-Free on=
 device disconnect.
--

--- Patch [1]: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size=
 mismatch ---
commit 975e1f8f6c4a34bb9458d846d2ded822cbc82f04
Author: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>

can: usb: f81604: fix struct f81604_int_data size mismatch

This commit removes the __aligned(4) attribute from struct f81604_int_data
so its size matches the actual 9-byte hardware data size. This prevents
valid interrupt messages from being incorrectly discarded as short URBs.

Closes: https://lore.kernel.org/all/A3834A07-5639-4779-844F-C5843DFC3928@dy=
netrex.com/

> diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> index f12318268e46b..4c147b9d6d690 100644
> --- a/drivers/net/can/usb/f81604.c
> +++ b/drivers/net/can/usb/f81604.c
> @@ -169,7 +169,7 @@ struct f81604_int_data {
>  	u8 rxerr;
>  	u8 txerr;
>  	u8 val;
> -} __packed __aligned(4);
> +} __packed;

[Severity: High]
This is a pre-existing issue, but by fixing the struct size and enabling
normal interrupt processing, this patch actively unmasks a use-after-free
on device disconnect.

Looking at f81604_close(), cancel_work_sync() is called before the URBs
are unregistered:

drivers/net/can/usb/f81604.c:f81604_close() {
    ...
    cancel_work_sync(&priv->clear_reg_work);
    close_candev(netdev);

    f81604_unregister_urbs(priv);
    ...
}

If an interrupt URB completes concurrently with a device disconnect,
could the URB completion handler schedule the work again after
cancel_work_sync() has already completed?

drivers/net/can/usb/f81604.c:f81604_handle_can_bus_errors() {
    ...
    if (priv->clear_flags)
        schedule_work(&priv->clear_reg_work);
    ...
}

If so, f81604_unregister_urbs() will wait for the URB callback to finish
but leave the newly scheduled work pending.=20

When the disconnect path returns and frees the netdev and its embedded
priv struct, will the delayed work execute and dereference the freed
pointer in f81604_clear_reg_work()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-f81604-fix=
-v2-1-fc9be5581394@fintek.com.tw?part=3D1
