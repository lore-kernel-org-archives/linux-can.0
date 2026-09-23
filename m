Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30536B054
	for <linux-can@vger.kernel.org>; Wed, 23 Sep 2026 03:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132568; cv=none; b=ie/ZSNngJWh25p6JDJqryk+IaGPnzPH7EHJdRpFnXyPJTQgDKf8uszDi7aQ397GFg34rO+gVFf46wjFNGyOAlXl0FgOwNbaZGF1e59Dh88nTRgYFH2r07/cYYN4r8einkoHPk3U/kLs6UsNa3Km284Vcok/qYy2Dqo9MNWjufBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132568; c=relaxed/simple;
	bh=LRBAJF7rKUqJGO8UE632wgNlKRGAIeeXPSXkinc5FAY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cPpoHxagGvBNtIQWpt9EFQW1quaYRKlw0MxRRQpq9PaEZr7TIzNei51EQkTd6AwVn9is8hanEicg3Q9cKZznRs7nQVsE8mg4nDKuGYZskINcgpJD74Bd7PowQS1BkFmucV4OGN4AagJEsB3Qs0gH2QJi+SaD4mYsDm5QkdWPju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3UWExrN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3UWExrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE791F000FF;
	Wed, 23 Sep 2026 03:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790132567;
	bh=axlaro/ZhHBvcIElBXtCKLQXJ3mGciKhYnvNy2BxCt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W3UWExrNZrQjESsG2Zgz+8aWPYfEonLZmSqDdKLwDmXNxFcS/zUKu6G9HYMM8pn5j
	 ny8ONUUc6KcmKyKSBQZytcZ9Y+1h81NOTiVCZDmLm48RcvvghUtWoG8iggJC92Cfql
	 CV5XBy2VCq2B/2TITwG7DBxJ+/M/5xzu0Sk8Sm6PyOqJJFHPcQx0CacuA3y75i+T3Z
	 /DQGVSbmqVhT7OKzotgULm4KvWxvgfWiEBw37CoU0ICgO7N3d30ovX20dD5wyodTDl
	 SrDdSEt6mGta3Eev0v4vMi9d375ysHr0R8PW/j0EXznKie5snuzcBl5qJGeY+s/E2M
	 7Z7k5YOjd3z0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests: can: add CAN XL raw socket tests
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260923025317.374997-1-quchaosheng000406@163.com>
References: <20260923025317.374997-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 03:02:46 +0000
Message-Id: <20260923030246.CFE791F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kselftests/can: missing XL capability check causes test failure
--

commit 0db65e488a9ffaf096720dc302fd90d7dbdccbc6
Author: Quchaosheng <quchaosheng000406@163.com>

selftests: can: add CAN XL raw socket tests

This commit adds a set of CAN XL tests to `test_raw_filter.c` utilizing a
vcan interface. It tests payload round-trips, frame validation, CAN FD
dependencies, and VCID filtering.

> diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/te=
sting/selftests/net/can/test_raw_filter.c
> index bb8ae88542737..53f0c9d829ed0 100644
> --- a/tools/testing/selftests/net/can/test_raw_filter.c
> +++ b/tools/testing/selftests/net/can/test_raw_filter.c

[ ... ]

> +static int open_xl_socket(int send_xl, const struct can_raw_vcid_options=
 *vcid)
> +{
> +	struct sockaddr_can addr;
> +	struct ifreq ifr;
> +	int one =3D 1;
> +	int s, ret;

[ ... ]

> +	addr.can_family =3D AF_CAN;
> +	addr.can_ifindex =3D ifr.ifr_ifindex;
> +
> +	ret =3D bind(s, (struct sockaddr *)&addr, sizeof(addr));

[Severity: Low]
This is a pre-existing issue, but does passing this struct to bind() leak
uninitialized stack memory to the kernel?

The addr struct has padding and a large union (can_addr) that are not fully
initialized by setting just can_family and can_ifindex. Could this trigger
memory sanitizer warnings when sizeof(addr) bytes are copied across the
user/kernel boundary?

[ ... ]

> +/* Without VCID options the VCID is stripped on TX and a VCID-tagged fra=
me is
> + * not forwarded on RX
> + */
> +TEST(canxl_vcid_stripped_by_default)
> +{
> +	struct can_raw_vcid_options pass =3D {
> +		.flags =3D CAN_RAW_XL_VCID_TX_PASS,
> +	};
> +	struct canxl_frame tx, rx;
> +	int tx_sock, rx_sock, ret;
> +
> +	tx_sock =3D open_xl_socket(1, &pass);
> +	ASSERT_GE(tx_sock, 0)
> +		TH_LOG("CAN XL not supported on %s", CANIF);
> +
> +	rx_sock =3D open_xl_socket(1, NULL);
> +	ASSERT_GE(rx_sock, 0);
> +
> +	fill_canxl(&tx, 8, 0x11);
> +	tx.prio |=3D 0x42 << CANXL_VCID_OFFSET;
> +
> +	ret =3D write(tx_sock, &tx, CANXL_HDR_SIZE + tx.len);
> +	ASSERT_EQ(ret, CANXL_HDR_SIZE + tx.len);

[Severity: Medium]
Does this test lack a check for CAN XL support before executing?

Other tests in this file check if the interface can handle CAN XL frames:

	if (!can_iface_supports_xl())
		SKIP(return, "%s does not support CAN XL", CANIF);

Without this check, if the tests are run on a system with only a classic CAN
interface, the write() will be rejected with -EINVAL because the MTU is too
small. Won't this cause a false positive test failure at the ASSERT_EQ check
instead of gracefully skipping the test?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923025317.3749=
97-1-quchaosheng000406@163.com?part=3D1
