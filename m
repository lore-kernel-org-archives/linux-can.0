Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549721;
	b=OQfSSJl0LYFfXoWsBy6P1+gQoLBXRdJfRU4IJ6ANcFcSNVGV1Ll70CtLxs1ydzF45ba1
	 xF5IxuGOfGmU8mQHPJn8vh/ntQhSm+AkUtPoZDs73vCg7/bRVebyapqVkm6aWab9kXeqS
	 1A/NBbWaLKNIABuoMkbC/ENmoOGU5JCsFJ9TTkjzF1eFRxRBE75IZe2cPE2eh+4krTXZr
	 7quR3cMk6oT6u6GgdFlrl0FOmkABKsDLJ/dwIsaynwD8OAM4V6bfjcq30tCc7VQOLwEy4
	 hnje5tz6fParqf7gY9Azsq7KSxleVYMAZlZ8ZADsAMu6pXA0AkGkde9PX9Y3ZILT/IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549721;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rLY2YoytpZKIMCK+OlU7rT12SKBNAp8v3ovHTlr1y94=;
	b=WbgSKgwsns0Ww4S7QOZvIEyJjGK7DSGZJLUhCXzDf87r/y3HQLdDAv5wHkrr3B5FP5Dp
	 45Kw0b3AnDnkN9JH15Zf6df1N+HokC47UnfgprZ7XUFD7jekuA1dosLU8xo61flBjTpab
	 fXbXzLIhDt3VG3X3kU4SQp2eUSaQpVIA5+DrATXyZEiI9Mu50oaNE+WB9SprDcC/9H1Lw
	 D7vljFqESU9gCzvKD/okmXYcRUB8LTfR35WOLCms5syZ4ers7ygp8aEJmd6ErmKoNx4/E
	 dzTWZopLCmOOLFZcqs/Ow22007V+2WncKdWA+HmF2jb2WQLL3XCbowwcz0NRUD5I5nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aie+El2k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8E606A31C;
	Fri, 13 Nov 2026 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aie+El2k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931241F000C4;
	Fri, 13 Nov 2026 06:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549720;
	bh=rLY2YoytpZKIMCK+OlU7rT12SKBNAp8v3ovHTlr1y94=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Aie+El2koObfODXYt08Pzl4EAbPT706GxJHPiGoKZdAx167f3X48FR9hj1e3xSi/+
	 inNL7swX3BnQiaDUBLvw839zPSJsin0L/RNq5KTSCH8aDFWG5TgqKR+ZbHpHrqA1tT
	 8LByp4UnDcKx2NU+O+tQSGOUa5o4mHMCK9jVOwYe6+tKSPHIoEKcRFg2KX4BwO4UiW
	 RqApzbfIquL+gVU1g7rXzWJp6O8jZccZ1cRI5bIOX2cIk02f0dmAarXCp0678fThTy
	 haGPrv3ziMmaSI7N4XDNS85IVeViSvIaJdQOSNgA8vaUCIZf2a06pbqrHiqQ8NvK+a
	 N9/iMMBfXTGpA==
Subject:
 Re: [PATCH can-next v3 3/9] selftests: can: add J1939 base functional tests
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Fri, 13 Nov 2026 06:01:59 +0000
Message-ID: <179454971912.488853.3001942751202375383@kernel.org>
In-Reply-To: <20261111-j1939-selftests-v3-3-5a80277ab363@pengutronix.de>
References: <20261111-j1939-selftests-v3-3-5a80277ab363@pengutronix.de>
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

- [Low] test_j1939_base never opens a CAN_RAW socket, yet it skips the
  whole suite when CAN_RAW is missing.

--

selftests: can: add J1939 base functional tests

This adds a J1939 functional selftest. It sends between CAN_J1939 sockets
over vcan and checks payload integrity for single frame, TP and ETP sizes,
the boundaries between them, and single-frame and BAM broadcast. It also
enables CONFIG_CAN_J1939 and CONFIG_CAN_RAW in the selftest config.

> diff --git a/tools/testing/selftests/net/can/test_j1939_base.c b/tools/testing/selftests/net/can/test_j1939_base.c
> new file mode 100644
> index 0000000000000..7bf492c767bf6
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_base.c
> @@ -0,0 +1,236 @@

[ ... ]

> +int main(int argc, char **argv)
> +{
> +	return j1939_test_main(argc, argv);
> +}

[Severity: Low]
Is this binary skipped on a kernel that has CONFIG_CAN_J1939 but not
CONFIG_CAN_RAW?

In j1939_tests.h, j1939_test_main() makes every J1939 binary depend on
CAN_RAW:

	if (can_proto_missing(SOCK_RAW, CAN_RAW)) {
		fprintf(stderr, "# kernel lacks CAN_RAW\n");
		return KSFT_SKIP;
	}

test_j1939_base only uses SOCK_DGRAM/CAN_J1939 sockets:

- pair_up_ok() calls j1939_open_flags() and j1939_connect_ok().
- bcast_needs_so_broadcast calls j1939_open().
- The data path is send_recv_verify_ok() and recv_timeout() on those
  sockets.

Nothing in this file calls open_raw(), open_raw_rcvbuf() or
J1939_SETUP_RAW.

On such a kernel, the single frame, TP, ETP, size boundary, broadcast, BAM
and SO_BROADCAST tests would all report SKIP, even though they could run.

The v2 changelog says CONFIG_CAN_RAW is added here because "every test
needs it". That seems true only because of this check, not because of
anything the base test does.

Could the CAN_RAW check move into the binaries that actually open raw
sockets, or become a per-binary or per-test requirement?

The check itself came from the earlier patch in this series ("selftests:
can: add J1939 test helper header and library"). This is the first binary
that gets skipped by it for no reason.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-j1939-selftests-v3-0-5a80277ab363%40pengutronix.de
