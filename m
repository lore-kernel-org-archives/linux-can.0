Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAAE4B7A31
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596562; cv=none; b=IuqbOizJ1hEKm2jnJhTOrCJ7OXHYXmYucveX18H9tR4XchwMSIJrHJ4bje65o+d4PEzgKbh4sfgVNsZcSoOcBvzKyjRcBJydVgDX8sM4uBtEhrrV6IK55UqUSujVcogZMzxM4emFKHmm6BPDLhGXblqaBnEUTFIgZse0BP3E3Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596562; c=relaxed/simple;
	bh=wuBm7wQKvGKBHX0ufsK0qRbYaOC++SdFrKllsCNx+Gs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bl5DQ2+Kvzl84phf8vV95wK8jL30ypH8NhiX3XhjoLPGz2/92gGB88lEVP3xHubOK7Xd36ucLQ/hO2IQtd9xUysYG7WjEpiJLYNhMw8RSMJiCh613ZSi1iIQ3zH3rHnm0UH/iBPkL+qWU2oLvkmyqbMWg+R5jeGZx26FdWm/Xnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vlkd4jCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vlkd4jCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC3C1F000FF;
	Mon, 28 Sep 2026 11:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790596560;
	bh=D+mVBa8Km4p7HseMGbS9EVyj/lWY2iFFlGuox9SwE90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vlkd4jCT3c2dxL24S9qRR0hNclV1nd7xA/rGjpiEvkNDk/VCe9ALyfJDWCLeqlNfG
	 L5OMUuVHzpd/UzCm9n4qYoRf99APyLJnr/8f9lveuPTxicYkYbLLv41EPTVa216a9V
	 7n5nkYn202D9LtHLL5dxOeKpkXnkWwMOzLtFnYaqgv7sgFBe7doZkM2B2hZ9eJevxB
	 3pzHmjFZSCxaGc6vL3YVvFIbXw/8zm17C3n1p7Gx//wWTLU9k9iJ8zaia85ia/Aq4m
	 P3WZ2uXZx8ghe7jU+ZmWGxy57d2C4ovnZYqgw/X8vNj9GFQL+4FrNyjE+TrDj2gFHN
	 xVVgb5SawbWTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selftests: can: add isotp frame-type tests
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260928114551.2148536-1-quchaosheng000406@163.com>
References: <20260928114551.2148536-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 11:55:58 +0000
Message-Id: <20260928115600.4FC3C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: alignment and strict aliasing violation via byte arra=
y cast
- [Medium] selftests: tests fail unconditionally on kernels lacking CAN XL =
support
--

commit b7b667ec4c19dd41b74b7f4ee25cdee4ffaf4702
Author: Quchaosheng <quchaosheng000406@163.com>

selftests: can: add isotp frame-type tests

This commit adds an ISOTP frame-type test to verify that the CAN transport
channels are correctly separated. It ensures that CAN XL frames are not
mistaken for flow control frames on both Classic CAN and CAN FD channels.

> diff --git a/tools/testing/selftests/net/can/test_isotp_frame_type.c b/to=
ols/testing/selftests/net/can/test_isotp_frame_type.c
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_isotp_frame_type.c
[ ... ]
> +static int iface_max_xl_len(const char *ifname)
> +{
> +	struct sockaddr_can addr =3D { .can_family =3D AF_CAN };
> +	unsigned char buf[CANXL_MTU];
> +	struct canxl_frame *cxl =3D (struct canxl_frame *)buf;

[Severity: Medium]
Is this cast safe on architectures that enforce strict alignment? Since buf
is an unsigned char array on the stack, it is only guaranteed to be 1-byte
aligned. Casting it to struct canxl_frame * and writing to 32-bit and
16-bit fields like cxl->prio and cxl->len could lead to unaligned memory
access crashes. Also, does this violate strict aliasing rules, which are
enabled by default in the tools/ directory?

> +	int s, one =3D 1, ret =3D -1;
[ ... ]
> +static int inject_xl(int tx, unsigned int frame_len)
> +{
> +	unsigned char buf[CANXL_MTU];
> +	struct canxl_frame *cxl =3D (struct canxl_frame *)buf;

[Severity: Medium]
As with iface_max_xl_len above, does this stack-allocated byte array cast
cause unaligned accesses and strict aliasing violations when writing to
cxl->prio and cxl->flags in inject_xl?

> +
> +	memset(buf, 0, sizeof(buf));
> +	cxl->prio =3D ID_RX;
> +	cxl->flags =3D CANXL_XLF | 0x7f;	/* read back as canfd_frame.len */
[ ... ]
> +static int open_observer(const char *ifname)
> +{
> +	struct sockaddr_can addr =3D { .can_family =3D AF_CAN };
> +	int s, one =3D 1;
> +
> +	s =3D socket(PF_CAN, SOCK_RAW, CAN_RAW);
> +	if (s < 0)
> +		return -1;
> +	addr.can_ifindex =3D ifindex_of(ifname);
> +	if (addr.can_ifindex < 0)
> +		goto err;
> +	/* the First Frame is a CAN FD frame: without this the observer is
> +	 * blind and the precondition check below reports a false alarm
> +	 */
> +	if (setsockopt(s, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &one, sizeof(one)) < =
0)
> +		goto err;
> +	if (setsockopt(s, SOL_CAN_RAW, CAN_RAW_XL_FRAMES, &one, sizeof(one)) < =
0)
> +		goto err;

[Severity: Medium]
The commit message states "a host without CAN XL support still gets flow
control and padding coverage", but this setsockopt causes open_observer
to return -1 if the kernel lacks CAN XL support.

Since the Classic CAN tests assert that open_observer succeeds via
ASSERT_GE(self->obs, 0), won't this cause the tests to fail entirely on
kernels without CAN XL support rather than skipping or running the non-XL
portions?

> +	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0)
> +		goto err;
> +	return s;
> +err:
> +	close(s);
> +	return -1;
> +}
> +
> +static int open_injector(const char *ifname)
> +{
> +	struct sockaddr_can addr =3D { .can_family =3D AF_CAN };
> +	int s, one =3D 1;
> +
> +	s =3D socket(PF_CAN, SOCK_RAW, CAN_RAW);
> +	if (s < 0)
> +		return -1;
> +	addr.can_ifindex =3D ifindex_of(ifname);
> +	if (addr.can_ifindex < 0)
> +		goto err;
> +	if (setsockopt(s, SOL_CAN_RAW, CAN_RAW_XL_FRAMES, &one, sizeof(one)) < =
0)
> +		goto err;

[Severity: Medium]
Similarly, does this unconditional setsockopt for CAN_RAW_XL_FRAMES in
open_injector prevent the non-XL tests from running successfully on a
kernel without CAN XL support?

> +	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0)
> +		goto err;
> +	return s;
> +err:
> +	close(s);
> +	return -1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928114551.2148=
536-1-quchaosheng000406@163.com?part=3D1
