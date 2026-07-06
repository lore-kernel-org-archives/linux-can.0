Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D825782D
	for <linux-can@vger.kernel.org>; Mon,  6 Jul 2026 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378371; cv=none; b=mTFdFAD2obo5vETVFUkn8h02rQhnUvKbvbbIBktZ2UpeyRDbb0/IF8YeYFqfmiK3WmKjhD4ABjs+iXzkpRm/8McLvYxNU27D6tuIB//XD2obbFWPLXMJBhslbtCUfxGnwPjX98YL3x/oP81JULEVTt/OA3EhOBu4PSjb693stds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378371; c=relaxed/simple;
	bh=O5+dwgkfQpyq3CCTNwD3WdP9YIJmkUrUQ8dQMNRMQUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=muW5uz/XPziPQ6uhaR805cQC7RIAG8yMR0eUYy2o/73MnGiLcfRxvVsUsGDUodRVhbx7OL9j0OoChOMeCKHM2uvbFjjvj3yx0Ef/Wxcbafdk6LDi6uQ6ZxXyUWMADL41ThGIVpFZxAl9uNmR3oHftcVsjAEXxyATVnpU6nMAdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsI/VQdL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsI/VQdL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD261F00A3A;
	Mon,  6 Jul 2026 22:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783378370;
	bh=F7nW1AhMrvJP4f1TqyU0YtT/8xWdJZQX9ORlhR6Knxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TsI/VQdLeQmBl+E1MaT3mXHj5LZtegjOPTemMgmX5PVKtB3fXv7jPpi7dMVkpd3jw
	 B7cJY2DIpZKQPABO2/URfX/hEywwaglzbOBvYuFRWRZER9BMqNWMYpBVzJtwBpFuVs
	 QqqXtcIoFcYhkazHKjkWqaBwQj0g7hJGgMD5CNsFwqJ0zjE7VmjzK9BTGVx7euo8SR
	 gUKrTg5DKYG/0ixI2GZsEh9kJOahBEOzRe2FicHSrDZ38oXEOpkQ6Ecyioc5sXoTc9
	 Ct+hrjEhGEPlNg1fBH4SeEe9vMpVk/W4oTg4nwDFqfrnLSDxKQYhTiPSnEHz3LE39U
	 p+LNg6THvGmPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] j1939: add J1939 rx CTS tests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGFuZGVyIEjDtmx6bA==?= <alexander.hoelzl@gmx.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260706224548.100451-3-alexander.hoelzl@gmx.net>
References: <20260706224548.100451-1-alexander.hoelzl@gmx.net>
 <20260706224548.100451-3-alexander.hoelzl@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 22:52:49 +0000
Message-Id: <20260706225250.0FD261F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing closing quote in bash script `test_rx_cts.sh` causing un=
expected EOF syntax error, breaking the test.
- [Low] Incorrect `sizeof()` argument used when validating the received abo=
rt payload.
- [Low] Strict timing assertions might cause flaky test failures on heavily=
 loaded CI systems.
--

--- Patch [3]: [PATCH v4 3/3] j1939: add J1939 rx CTS tests ---
commit 21e063d80602f46f314c362808e394f235e646f9
Author: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>

j1939: add J1939 rx CTS tests

This commit adds tests to verify the correct behavior of received J1939
CTS messages. It covers normal segmented transmission, transmission resuming
after a hold, aborting on requested already acked messages, and aborting on
too many retransmit requests.

> diff --git a/tools/testing/selftests/net/can/test_rx_cts.c b/tools/testin=
g/selftests/net/can/test_rx_cts.c
> new file mode 100644
> index 0000000000000..1b437792d6772
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_rx_cts.c
[ ... ]
> +	/*
> +	 * The actual timeout is 1050ms. We define an acceptable window
> +	 * to account for CI scheduling variations.
> +	 */
> +	ASSERT_GE(elapsed_ms, 1000)
> +		TH_LOG("Abort received too early: %ld ms", elapsed_ms);
> +	ASSERT_LE(elapsed_ms, 1500)
> +		TH_LOG("Abort received too late: %ld ms", elapsed_ms);

[Severity: Low]
This isn't a bug, but could this strict timing assertion cause flaky test
failures?

An upper bound of 1500ms provides only a 450ms window for the 1050ms kernel
timeout, which might be easily exceeded due to thread scheduling delays und=
er
heavy load on oversubscribed or virtualized CI runners.

[ ... ]
> +	/* Now send a CTS for an already acked frame */
> +	memcpy(tx_frame.data, CTS_1_FRAME_PAYLOAD, sizeof(CTS_1_FRAME_PAYLOAD));
> +	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
> +	ASSERT_GT(res, 0)
> +		TH_LOG("failed to send second cts(1) with raw sock: %d", errno);
> +
> +	res =3D recv_payload(self->raw_sock, ABORT_DUP_SEQ_PAYLOAD, sizeof(DATA=
_2_PAYLOAD));

[Severity: Low]
Is this the correct size constant to use here?

It appears sizeof(ABORT_DUP_SEQ_PAYLOAD) should be used instead of
sizeof(DATA_2_PAYLOAD), even though both evaluate to 8 bytes.

[ ... ]
> diff --git a/tools/testing/selftests/net/can/test_rx_cts.sh b/tools/testi=
ng/selftests/net/can/test_rx_cts.sh
> new file mode 100755
> index 0000000000000..b2064ea7851e2
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_rx_cts.sh
[ ... ]
> +test_rx_cts()
> +{
> +	./test_rx_cts
> +	check_err $?
> +	log_test "test_rx_cts

[Severity: Medium]
Does this missing closing double quote cause an unexpected EOF syntax error
during shell parsing?

This would completely prevent the test script from running.

> +}
> +
> +trap cleanup EXIT

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706224548.1004=
51-1-alexander.hoelzl@gmx.net?part=3D3
