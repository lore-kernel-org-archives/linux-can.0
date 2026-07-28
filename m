Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA1224234
	for <linux-can@vger.kernel.org>; Tue, 28 Jul 2026 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208813; cv=none; b=BrLp8/7UQglI+Gg7gjsJb7vDUJO1utHHdK3pPPuPPjmEtLGh+oelhMQFzDp9QMrSWimGaPaJnlKgsOZrTXVNkdD3ouEwrYrB42kL9jT309VqiIWULiIWQBVTynP5iiB31LX48350YfZo1h5mdGS/JL0Vo4ARwK5VSvk8xdFd8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208813; c=relaxed/simple;
	bh=HAHWn1OF6QsPy+razmbuM3FSGHyelPkTNv3wCgyB4uE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fvlNS16DLeRAQNdJjeBLV0DA05bQadHyCheiPTqZ2SOdI6+I30TF1QVc+wImmXfgx/RNkkn3GzolDaI/q0f1jCZreuCXtZ3FGesDwJn+k2xobGr7SkKtKdEcaS1T7xfz8fyClBdxf+on4Uj2NOx0oT1rmEkNllt8cF7aTYua2K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkRDhUZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkRDhUZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7241F000E9;
	Tue, 28 Jul 2026 03:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785208812;
	bh=F5z3tvwEriD744uzV8mn09yR9fiawLiWCN3BlDe5fpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HkRDhUZRbHrbP74PvlhS80lWoo6EJuisXqCNXHdxLbd6WU6UqUReqJhuaJ9prQGzJ
	 yCoNlBNTT2BVVl23jtQKeh3MGeo3oXzMbPEi8oID+uMaaHca6Of5HcQ960teHISRY8
	 wtws1cy0Vl6DF86dkMRfh8NtZKBoq3wkFlzReNSEvvBVyY4tNGxSVKsKypYdnFWvtF
	 K9XZ9S9fh/ycrIxbYlg10gBLoDiGq43v704HvSQxkFbWoEPKkG9TNqemOwESe1hFL2
	 W5e3XQJWeSNtGklwM14r7C3V64TZXv9FUh23MRV0QQb/HNZVwaF5rrq6f/4PGmZeyM
	 Ntv2u/goS1Dww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: isotp: check register_netdevice_notifier()
 error in module init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Minhong He" <heminhong@kylinos.cn>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260728031038.76524-1-heminhong@kylinos.cn>
References: <20260728031038.76524-1-heminhong@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 03:20:11 +0000
Message-Id: <20260728032011.CF7241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Registering the CAN protocol before completing all fallible initia=
lization steps creates a race window leading to a Use-After-Free crash if i=
nitialization fails.
--

--- Patch [1]: [PATCH net] can: isotp: check register_netdevice_notifier() =
error in module init ---
commit 5f2f7a58360e9a2c18b5d6a9a724f468f79227d1
Author: Minhong He <heminhong@kylinos.cn>

can: isotp: check register_netdevice_notifier() error in module init

This commit adds a check for the return value of register_netdevice_notifie=
r()
in the isotp module initialization. If the notifier registration fails, it
now unregisters the CAN protocol and returns the error.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 54becaf6898f1..65e890cafd7a9 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1908,12 +1908,18 @@ static __init int isotp_module_init(void)
>  	pr_info("can: isotp protocol (max_pdu_size %d)\n", max_pdu_size);
> =20
>  	err =3D can_proto_register(&isotp_can_proto);
> -	if (err < 0)
> +	if (err < 0) {
>  		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err=
));
> -	else
> -		register_netdevice_notifier(&canisotp_notifier);
> +		return err;
> +	}
> =20
> -	return err;
> +	err =3D register_netdevice_notifier(&canisotp_notifier);
> +	if (err) {
> +		can_proto_unregister(&isotp_can_proto);
> +		return err;
> +	}

[Severity: High]
Does this error path introduce a use-after-free risk if userspace creates a
socket before the module initialization completes?

If can_proto_register() succeeds, the protocol is immediately exposed to
userspace. If a concurrent thread creates an ISOTP socket before
register_netdevice_notifier() fails, the socket will hold pointers to the
module's protocol operations.

When the module initialization aborts and returns an error, the kernel will
free the module memory. While can_proto_unregister() removes the protocol
from the registry, it does not revoke already-created sockets. As a result,
any subsequent operations on the existing socket will dereference freed
module memory.

Would it be safer to move the fallible register_netdevice_notifier() before
can_proto_register() to avoid exposing the protocol before initialization
is guaranteed to succeed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728031038.7652=
4-1-heminhong@kylinos.cn?part=3D1
