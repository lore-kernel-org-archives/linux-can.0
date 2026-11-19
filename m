Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132478;
	b=UN44YPXNTgarfxogASNDealoFq3bi4wDBBvdMsFMkYuKCkFovg3UYxoDHNLkPk9ppk+s
	 swNWyk1DFfC7LZo9iV5ylc1SZuprAn1x2Nbz42ubHCDFghdWyawnHZlHhYOf4iOhh94+8
	 8+DVY6xgstrob/SPCRuW0MnnIXGGTBo+UHjUSDqGpb/O/AtJGVxLm3AwY0/6lvVMOVlHs
	 gownw1YWGIwEww6uw9gHh4X9uaEYy6N3xiE3S0+CB0yXKg4TfLWlcObCqgEpxMoojbpFV
	 uh+01Kze0tYUcc5JPgcWv5sqbMJ4fmtNHYuxVyYzsx5cD3Np2NaEUH+awHVDzJKYncw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132478;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=12ZSxNtzN2/RK0wVV1a0rB4b6IXbcwkOy/ggx5peZS8=;
	b=WJhS6ZSmylw/B60tp7pDmeIuCIaEPhz30BAgHiREtwAaF7Oaw6RUEHV9qc9euxv/MVnU
	 lRP9oLbTaK53pxR0oCaDryJfbBQ+H/W/MZ40o2ogEnGy4NCg2YFxAoSGQZiTM5BEQIPwz
	 XzZ1cJhF6ELdWL/Ewj/LBbAvdcxZYmwXYFckYqMCrcYj9WjE+2p6/FzGCE2zO7IxsqQtB
	 mpChqF4vT6GH+E3j2TpW6icmc9QugTrtlVGB7A8IkO0LvrEID6vy7j0hzF1DZGdjf+sRE
	 I2n1c/7YJ1R1o5pvGf8r9sl6b4pUgpESj4iIYMC4KAVgNtKidO6441/1J4saqSZCOdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9ZlWS1P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F37606A325;
	Thu, 19 Nov 2026 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9ZlWS1P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451291F000C4;
	Thu, 19 Nov 2026 23:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795132478;
	bh=12ZSxNtzN2/RK0wVV1a0rB4b6IXbcwkOy/ggx5peZS8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a9ZlWS1P7Ku8B8lKMPE3IOzC8ySlc3z+93UsUAgIeUMg5IsveXaIw3Qy9wFcZU4HS
	 zm92zwiLiBdJObY0wz5othEcP3qEQeevULXHTgJhfQUnotB9gHWdfNDDFpG1IbPuou
	 ERJpUHeIoECUwcQLJHLlQnEpcy3APbLvTX/vnKGitsrylJXTE1HmJMpKu6tVytojRT
	 QIVtesCv0MXZz4f2ZMJF5gpiZiBlRsAUfb2lHmCmrNybR9Lhjq/VLShpws94IJUMt6
	 +1zfesNub7oc+G92az7RWCpN6NeFc2OqNnoVb2v4AtXmEgrAK5GoE3ulFnrCrhL30H
	 WzuK1nYrCdHGw==
Subject: Re: [PATCH can-next v4 2/9] selftests: can: add J1939 test helper
 header and library
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Thu, 19 Nov 2026 23:54:36 +0000
Message-ID: <179513247684.3132.16965169120419676697@kernel.org>
In-Reply-To: <20261118-j1939-selftests-v4-2-756768d32ff2@pengutronix.de>
References: <20261118-j1939-selftests-v4-2-756768d32ff2@pengutronix.de>
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

- [Low] Baseline decision: false positive.

--

selftests: can: add J1939 test helper header and library

This commit adds the shared code for the upcoming J1939 selftests: the C
helpers in j1939_helpers.c/.h, the harness glue in j1939_tests.h, and the
j1939_lib.sh vcan setup and runner. It also adds j1939_gw, which sets up
CAN gateway rules so that the CAN_RAW peer can sit on its own vcan,
separate from the J1939 sockets.

> diff --git a/tools/testing/selftests/net/can/j1939_lib.sh b/tools/testing/selftests/net/can/j1939_lib.sh
> new file mode 100644
> index 0000000000000..796022760e487
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/j1939_lib.sh

[ ... ]

> +setup()
> +{
> +	vcan_setup "$CANIF"
> +
> +	# shared or none: no second vcan
> +	[ "$j1939_peer" = gateway ] || return 0
> +
> +	if [ "$CANIF_RAW" = "$CANIF" ]; then
> +		echo "SKIP: CANIF_RAW is CANIF ($CANIF); set another CANIF_RAW or J1939_SHARED_IF=1"
> +		exit "$ksft_skip"
> +	fi
> +
> +	vcan_setup "$CANIF_RAW"
> +
> +	# rtnetlink does not load can-gw on demand
> +	modprobe -q can-gw 2>/dev/null
> +
> +	if ! "$(dirname "$0")/j1939_gw" "$CANIF" "$CANIF_RAW"; then

[Severity: Low]
This isn't a bug, but at this patch tools/testing/selftests/net/can/config
still contains only:

CONFIG_CAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m

In the default gateway mode, setup() needs CAN_GW. The checks in
j1939_test_main() need CAN_J1939, and CAN_RAW too when a test passes
J1939_NEEDS_RAW:

	if (can_proto_missing(SOCK_DGRAM, CAN_J1939)) {
		fprintf(stderr, "# kernel lacks CAN_J1939\n");
		return KSFT_SKIP;
	}

A kernel built only from this fragment would skip every J1939 test.

At this patch nothing goes wrong. TEST_PROGS is still only
test_raw_filter.sh, so no test reaches j1939_lib.sh or j1939_test_main()
yet.

The next patch in the series, "selftests: can: add J1939 base functional
tests", adds the first J1939 test. In the same patch it adds
CONFIG_CAN_GW=m, CONFIG_CAN_J1939=m and CONFIG_CAN_RAW=m to the fragment,
so this is resolved later in the series.

Would it be clearer to add those options here, next to the library and
j1939_gw that depend on them, or is the current split intended?

> +		echo "SKIP: cannot route $CANIF <-> $CANIF_RAW (can-gw?); try J1939_SHARED_IF=1"
> +		exit "$ksft_skip"
> +	fi
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118-j1939-selftests-v4-0-756768d32ff2%40pengutronix.de
