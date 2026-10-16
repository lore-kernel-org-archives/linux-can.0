Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1043E51F7;
	Fri, 16 Oct 2026 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134013; cv=none; b=BK2/r3LX0oaHa6O4k5dJfsUMa2rc6spThV4sQjgg4yXN0FVSx9/gXAKqrz8v68OkNQga/Z8DW+uyA81Nppynswd7zRD4vRNp0kwEiqFCdFC9+ajwQIARNvuI24Vvg/UYsWNyJC5MIO9QOBll8MrluuGv9s3qh2VcLogBM0JQRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134013; c=relaxed/simple;
	bh=N9OEIDejLgP1mg8ClZhR/OfE44BCp9t+LhoFgG9mzVU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ba+GVaI4hab9zWfmQEp46RAqzd3ePiT+d/5HKxm+s1War4g6vN13GK7s2RbyRs0ZvWdupcJihUv17+FZ3CpI/VY3fyZlgFe7Xc+0w4fckeBTAlXKa2hrpiVrJ/+i3y8/4LzKzBugE/N4UHJ4jItNH2bIAMnUhkeSSabSKXc4Nbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKSCX5FY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKSCX5FY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035781F000C5;
	Fri, 16 Oct 2026 07:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792134003;
	bh=zjSBFayPw/nXlQZbC0GW0Ttenf1/COvhxj288ABy6AQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QKSCX5FYJH6U8BBuer7NIvvyO6q/FVl4kxqmzwRKOmD1k9TiDflAelxqdMJzcdYno
	 2NlprRVSEF/haoRSkqYCNHm4U+HskZB/eOcBTFBWfNSGKHlZdLomo13H/2N8p4eAqw
	 ItZo+Rp4mtK8QRIFqsa4sLvLBok4G8KHT+d6IRcLdsFWXWKBVyQYBU+2neLl/QXHRh
	 sZPu7spdYsIIkzE7QAhyyxXvaLymVDcA1DUbskCsXW2t9yYWWPY7BiEK95ipsGlPOD
	 71jTVbbpoiRs6+qYd9fTFH5mMX/ZpWPW2ELYuFwLZVj55muEyG3xf5O+JmhvqALaW0
	 I/bLA+la9NKkg==
Subject:
 Re: [PATCH can-next v1 2/8] selftests: can: add J1939 base functional tests
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alexander.hoelzl@gmx.net, quchaosheng000406@163.com,
 penguin-kernel@I-love.SAKURA.ne.jp, kuba@kernel.org
Date: Fri, 16 Oct 2026 07:00:00 +0000
Message-ID: <179213400068.1406898.3869778574324463301@kernel.org>
In-Reply-To: <20261014154435.3577983-3-o.rempel@pengutronix.de>
References: <20261014154435.3577983-3-o.rempel@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] test_j1939_base.sh breaks when net/can is installed on its
  own.
- [Low] roundtrip() in test_j1939_base.c is documented as checking that
  the payload is "received byte for byte", and size_boundaries claims to…
- [Low] Baseline decision: false positive for the concrete scenarios
  given.
- [Low] roundtrip() in tools/testing/selftests/net/can/test_j1939_base.c
  (lines 104-106) prints `errno %d` whenever send_recv_verify() fails.

--

selftests: can: add J1939 base functional tests

This adds a kselftest for the SAE J1939 socket interface. It opens a
sender and a receiver CAN_J1939 socket on a vcan interface and checks
payload integrity for single frame, TP, ETP, the size boundaries between
them, and single-frame and BAM broadcast. The test runs through a new
test_j1939_base.sh wrapper that sources j1939_lib.sh.

> diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
> index e2092c289109..cf4bd2461a6c 100644
> --- a/tools/testing/selftests/net/can/Makefile
> +++ b/tools/testing/selftests/net/can/Makefile
> @@ -4,10 +4,16 @@ top_srcdir = ../../../../..
>  
>  CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
>  
> -TEST_PROGS := test_raw_filter.sh
> +LOCAL_HDRS := j1939_tests.h
> +
> +TEST_PROGS := \
> +	test_raw_filter.sh \
> +	test_j1939_base.sh \
>  
>  TEST_FILES := j1939_lib.sh

[Severity: Medium]
Will test_j1939_base.sh still work when only net/can is installed?

The wrapper sources j1939_lib.sh, which is in TEST_FILES. But j1939_lib.sh
then sources a file from the parent directory:

tools/testing/selftests/net/can/j1939_lib.sh:
    net_dir=$(dirname "$0")/..
    source "$net_dir/lib.sh"

net/lib.sh then sources $net_dir/lib/sh/defer.sh.

This Makefile has no TEST_INCLUDES, so lib.mk doesn't install ../lib.sh
or ../lib/sh/*.sh for this target. The top-level selftests Makefile only
adds net/lib for these targets:

    ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)

After "make -C tools/testing/selftests TARGETS=net/can install", wouldn't
the new test fail at the source step with "No such file or directory"
instead of running or skipping?

Other net subdirectories with the same dependency declare it. For example,
net/mptcp/Makefile has:

    TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)

test_raw_filter.sh already sources ../lib.sh the same way. Since the new
test depends on it too, could a similar TEST_INCLUDES line go in here?
The Makefile still has no TEST_INCLUDES at the end of the series.

[ ... ]

> diff --git a/tools/testing/selftests/net/can/test_j1939_base.c b/tools/testing/selftests/net/can/test_j1939_base.c
> new file mode 100644
> index 000000000000..59f1448b7fb2
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_base.c

[ ... ]

> +/*
> + * Send a deterministic payload of the given size on tx and verify it is
> + * received byte for byte on rx. Returns 0 on success, -1 otherwise.
> + */
> +static int roundtrip(FIXTURE_DATA(j1939_base) *self, size_t size)
> +{
> +	uint8_t *tx_buf;
> +	int rc;
> +
> +	tx_buf = malloc(size);
> +	if (!tx_buf) {
> +		fprintf(stderr, "# alloc failed\n");
> +		return -1;
> +	}
> +	fill_pattern(tx_buf, size);
> +
> +	rc = send_recv_verify(self->tx, self->rx, tx_buf, size,
> +			      J1939_RECV_TIMEOUT_MS);

[Severity: Low]
Can this check catch a message that arrives longer than it was sent?

send_recv_verify() in j1939_tests.h receives into a buffer of exactly len
bytes and compares only those len bytes:

    uint8_t *rx_buf = malloc(len);
    ...
    recv_timeout(rx, rx_buf, len, timeout_ms) == (int)len &&
    memcmp(buf, rx_buf, len) == 0)

On the kernel side, j1939_sk_recvmsg() truncates without an error and
returns the user buffer size:

    if (size < skb->len)
        msg->msg_flags |= MSG_TRUNC;
    else
        size = skb->len;
    ...
    return size;

Plain recv() can't see the MSG_TRUNC output flag. So if TP/ETP reassembly
ever delivered extra bytes, every subtest here would still pass. That
includes the 9/1785/1786 cases in size_boundaries.

Passing MSG_TRUNC as an input flag won't work either. j1939_sk_recvmsg()
returns -EINVAL for any flag other than MSG_DONTWAIT, MSG_ERRQUEUE and
MSG_CMSG_COMPAT.

Two options that might work: receive into a buffer of at least len + 1
bytes and require recv() to return exactly len, or use recvmsg() and
check msg_flags. The helper is unchanged at the end of the series, and
test_j1939_addr.c uses it too.

> +	if (rc)
> +		fprintf(stderr, "# round-trip failed at size %zu, errno %d\n",
> +			size, errno);

[Severity: Low]
Is errno meaningful on every path that reaches this message?

When poll() times out, recv_timeout() returns -1 without setting errno:

    if (poll(&pfd, 1, timeout_ms) <= 0)
        return -1;

A memcmp() mismatch or a short send()/recv() count also leaves errno
unchanged. A timeout or a data mismatch would then print whatever errno
an earlier call left behind, often 0.

Could the timeout and mismatch cases print their own messages?

[ ... ]

> +/* exact size boundaries around single / TP / ETP transitions. */
> +TEST_F(j1939_base, size_boundaries)
> +{
> +	static const size_t sizes[] = { 8, 9, 1785, 1786 };
> +	size_t k;
> +
> +	for (k = 0; k < ARRAY_SIZE(sizes); k++) {
> +		ASSERT_EQ(pair_up(self, SA_RX, SA_RX, PGN_PDU1, 0), 0);
> +		EXPECT_EQ(roundtrip(self, sizes[k]), 0)
> +			TH_LOG("failed at boundary size %zu", sizes[k]);
> +	}
> +}

[Severity: Low]
This isn't a bug, but does this test, or tp_roundtrip and etp_roundtrip,
check which transport was actually used?

Only payload delivery is checked. A one-sided transmit selection bug in
j1939_tp_send() would still be caught. The receive side checks the size
on its own in j1939_xtp_rx_rts_session_new() and aborts the session:

    else if (len <= J1939_MAX_TP_PACKET_SIZE)
        abort = J1939_XTP_ABORT_FAULT;
    ...
    else if (len < J1939_MIN_TP_PACKET_SIZE)
        abort = J1939_XTP_ABORT_FAULT;

However, the TX and RX paths share J1939_MAX_TP_PACKET_SIZE. A symmetric
change to that constant would not be noticed by this loopback-only test.
Nothing here checks whether TP.CM_RTS (0x10) or ETP.CM_RTS (0x14) went
out on the wire.

The later "selftests: can: add J1939 TP/ETP multi-frame tests against
CAN_RAW" patch does check the RTS command on the wire, but only at sizes
200 and 6000.

Would it make sense to add the 8/9/1785/1786 sizes there, or to reword
the "exact size boundaries" comment here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014154435.3577983-1-o.rempel%40pengutronix.de
