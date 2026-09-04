Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18763F3292
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531969; cv=none; b=YaCO1Jh6gLLk7R8QtxCGTxA3IQHwENcUjydouDJnNMgYX2GDrFT/veYhuZt6S5g1ON1m1r3c/E2yZuBcxofNfzQkaS1ea+U/VZ8s4e5cVARBu1RGqXc5vxUXWdZvxxp3XNaYX6Eb75ww4igXT/ZbEUZVr13m6BfipXWtDHdGEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531969; c=relaxed/simple;
	bh=JQuefiiFxWpcCRFQyKhkugLdH9OtVjXnVs2TQmhRzag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LuRFoLqBfy1oxSmJlGNi7Ruv79UO1jC5qY033b5Ff/mpUakOIn3rxsj7tA9u10ty9tRYZ/3R9933jQFm/1Wjno/CncRyLjJ1tKChxbjLfbvSVS/SnMziat0f6EOikylaFV4JfnbWHVqjRU4wArX1jDkQxRodlycYkvdeGplYrWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKYWNuA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKYWNuA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB371F00A3D;
	Fri,  4 Sep 2026 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531966;
	bh=reN6pTx9bu3qULnBgyVleRjNCBgABgaoHOngYGg12yo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lKYWNuA50CePfrbVRakNDdli6zIxlbXLLMKWKEcI1FLpsl2Unw42nWsqIBTEBg1a4
	 qke+PaeUtO2Wk1gi7XFa2xPZZzm82W/dkCQzi6+/hjnHJWGdyITPGTp10vnVmI6TKJ
	 o0UxwemlYJeKg6HtrGLJRBfUdVxdke7Gmhy9eNswNgGT/yzzcRedehSLMUbZenYFKO
	 nx0OXyxlk77SnbstqmWtWab8hzZv/NWVxIjt35HXq/R2/LHYGtNVZOZCsf6EPrqTJ7
	 7qA0w23ofvfIhJ7BFDiYdXMjNW9/K3IdGnRULH+v0un5hZy9muuHVG3oHIfMP68UZu
	 w64JNMDQqMTsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v3 3/3] can: add can diag interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Filippo Storniolo" <fstornio@redhat.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260904-feat-can-diag-v3-3-bdcebf07b373@redhat.com>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20260904-feat-can-diag-v3-3-bdcebf07b373@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 14:26:05 +0000
Message-Id: <20260904142606.6FB371F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Index-based resumption in can_diag_dump() causes skipped or repe=
ated sockets without notifying userspace via NLM_F_DUMP_INTR.
--

commit 8ae9bc3a24d9d75317a64a778b0ca0dc88c6a32a
Author: Filippo Storniolo <fstornio@redhat.com>

can: add can diag interface
   =20
Add the can_diag interface for querying sockets from userspace. The ss(8)
tool can use this interface to list open sockets. The userspace ABI includes
netlink request and response structs with socket information fields.

> diff --git a/net/can/diag.c b/net/can/diag.c
> new file mode 100644
> index 0000000000000..647a94636a548
> --- /dev/null
> +++ b/net/can/diag.c

[ ... ]

> +static int can_diag_dump(struct sk_buff *skb, struct netlink_callback *c=
b)
> +{
> +	int num =3D 0, s_num =3D cb->args[0];
> +	struct can_diag_req *req;
> +	struct net *net;
> +	struct sock *sk;
> +
> +	net =3D sock_net(skb->sk);
> +	req =3D nlmsg_data(cb->nlh);
> +
> +	lock_can_diag_mutex(net);
> +	sk_for_each(sk, &net->can.sklist) {
> +		if (num < s_num)
> +			goto next;
> +
> +		if (sk_diag_fill(sk, skb, req,

[Severity: Medium]
Will this simple index-based resumption (num < s_num) cause skipped or
repeated sockets without notifying userspace if the list is modified between
dump iterations?

A netlink dump of CAN sockets can require multiple messages, forcing
can_diag_dump() to return and resume later. If a concurrent thread creates
or destroys a CAN socket, altering the layout of net->can.sklist while the
mutex is dropped, iteration by index becomes inaccurate.

According to the Netlink uAPI guidelines, if iteration during a dump may sk=
ip
or repeat objects, NLM_F_DUMP_INTR must be set on the affected messages. Th=
is
is normally implemented by maintaining a generation counter and recording it
in cb->seq to detect list modifications.

> +				 sk_user_ns(NETLINK_CB(cb->skb).sk),
> +				 NETLINK_CB(cb->skb).portid,
> +				 cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				 sock_i_ino(sk)) < 0)
> +			goto done;
> +next:
> +		num++;
> +	}
> +done:
> +	unlock_can_diag_mutex(net);
> +	cb->args[0] =3D num;
> +
> +	return skb->len;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-feat-can-d=
iag-v3-0-bdcebf07b373@redhat.com?part=3D3
