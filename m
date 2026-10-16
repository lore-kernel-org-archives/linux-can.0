Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE826C385;
	Fri, 16 Oct 2026 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134002; cv=none; b=Pj1zuDjS/xY1Hkp8xKTzeuz8roz6MHMM4IFQm02NNxesMfQVFgFf/AMzTQLj3yMelwJ6ZLoRc/k1QjKTkyGKbVuEW97opDS6gBUL9knzP1YUAeNLi9e/vHOU0RCk6mUQgUshmjyaxuFKAKHZcpo/pCjA/BxjQSa7xFjNqKPfmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134002; c=relaxed/simple;
	bh=8oaxSKh+8WoofAvlfK9hGF4WVXWUAEOOOuzvpWeEkWQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSTLFV0FtskCDv3Dp5DM0m1RMIVR0lwOZZTbAEuj1sIgaD2F7ksDmT5Jk5HaIhvwU5urjVvtc7OgsHrXKqVPqEOPl++E6QgMj2ZXXELMYJxcSzWTfjXhIUzK1VcamVmM+3u4qLoa3vIXicd1dCSJF2jS1Xe4e7i5cplPm85DWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSxGSKth; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSxGSKth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A481F000C4;
	Fri, 16 Oct 2026 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792134000;
	bh=7DT2BsSllpTY9IaBZSpPqD3pqh0UvkhF2kAGCAJLOjw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gSxGSKthwwBd/911ZGcnAgEXd9FfEp5x2HLkrgTIPv0gTAsKrDdJC4u9Nl1GI9ioA
	 3vyB4kIokymQISckcDdhWg/3uJzhVd/+PnVrLx+RvOWK0+0z7ScdBAqIN4dYG1/hyL
	 lm0X5jC3FpsEFRdEn5qNaTPhDtThD4w2E9Xs1sp9xV+QXJO3TgC0C0oBNPuaQr6VcM
	 eoTn3QV8RKpTuizPiKz57J40boZ+uN+oZ03slWjV8fBabPFrCCYwINIP4jYKAymZLv
	 Wao+Y8cBZ5XuGBqMo0OHVTyZh2BF3Ze9GH2E8IqBHuyPYflZ4PblUnZcoZlnoWVcP8
	 wo0xsyx0cFDYQ==
Subject: Re: [PATCH can-next v1 1/8] selftests: can: add J1939 test helper
 header and library
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alexander.hoelzl@gmx.net, quchaosheng000406@163.com,
 penguin-kernel@I-love.SAKURA.ne.jp, kuba@kernel.org
Date: Fri, 16 Oct 2026 06:59:59 +0000
Message-ID: <179213399918.1406898.1255916338662682889@kernel.org>
In-Reply-To: <20261014154435.3577983-2-o.rempel@pengutronix.de>
References: <20261014154435.3577983-2-o.rempel@pengutronix.de>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] j1939_lib.sh is new and is installed through TEST_FILES in
  tools/testing/selftests/net/can/Makefile.
- [Medium] send_recv_verify() in j1939_tests.h says it verifies that len
  bytes 'arrive byte-for-byte on rx', but it cannot catch a delivery…
- [Low] j1939_lib.sh installs `trap cleanup EXIT INT TERM`, but cleanup()
  never calls exit.
- [Low] On the real-CAN path (CANIF not vcan*), setup() reprograms the
  interface with `ip link set dev "$CANIF" type can bitrate "$BITRATE"`…

--

selftests: can: add J1939 test helper header and library

This adds j1939_tests.h, which holds the shared C helpers for the J1939
selftests, and j1939_lib.sh, which holds the shared vcan setup, teardown
and test runner. No tests use them yet; the following patches in the
series add the tests.

> diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
> index 5b82e60a03e7..e2092c289109 100644
> --- a/tools/testing/selftests/net/can/Makefile
> +++ b/tools/testing/selftests/net/can/Makefile
> @@ -6,6 +6,8 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
>  
>  TEST_PROGS := test_raw_filter.sh
>  
> +TEST_FILES := j1939_lib.sh
> +

[Severity: Medium]
Does net/can also need a TEST_INCLUDES line here?

j1939_lib.sh sources ../lib.sh, and net/lib.sh in turn sources
lib/sh/defer.sh. net/can/Makefile does not declare either file for
installation.

net/lib.sh is only installed through TEST_FILES in net/Makefile. The top
level selftests Makefile only pulls in the net lib dependency when TARGETS
contains net, drivers/net or drivers/net/hw:

tools/testing/selftests/Makefile:
    ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)

With make TARGETS=net/can install, or when net/can is packaged on its own,
would every J1939 wrapper added later in the series (test_j1939_base.sh,
_opts, _addr, _wire, _multi) fail at the source line? They would then run
with ksft_skip, check_err, log_test, tests_run and EXIT_STATUS undefined.

net/mptcp/Makefile handles the same dependency with:

    TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)

test_raw_filter.sh already has a similar gap. This patch, though, adds a
new shared library that the following tests depend on, and the gap is
still there at the end of the series.

>  TEST_GEN_FILES := test_raw_filter
>  
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/net/can/j1939_lib.sh b/tools/testing/selftests/net/can/j1939_lib.sh
> new file mode 100644
> index 000000000000..7b7fff228b16
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/j1939_lib.sh

[ ... ]

> +# Only undo what this script actually did: delete a vcan we created, and bring
> +# down an interface only if we brought it up. A failed setup() (e.g. CANIF
> +# already exists) must not disturb a pre-existing interface.
> +created=0
> +brought_up=0
> +
> +setup()
> +{
> +	if [[ $CANIF == vcan* ]]; then
> +		ip link add name "$CANIF" type vcan || exit $ksft_skip
> +		created=1
> +	else
> +		ip link set dev "$CANIF" type can bitrate "$BITRATE" || exit $ksft_skip
> +	fi
> +	ip link set dev "$CANIF" up || exit $ksft_skip
> +	brought_up=1
> +}
> +
> +cleanup()
> +{
> +	if [ "$brought_up" = 1 ]; then
> +		ip link set dev "$CANIF" down 2>/dev/null
> +	fi
> +	if [ "$created" = 1 ]; then
> +		ip link delete "$CANIF" 2>/dev/null
> +	fi
> +}

[Severity: Low]
On the real CAN path (CANIF not vcan*), setup() reprograms an existing
interface to $BITRATE. It does not save the previous bittiming. cleanup()
only undoes brought_up and created.

Does this leave the interface at 250 kbit/s after the test? The same
question applies when the following ip link set ... up fails and setup()
exits with brought_up=0.

Bittiming survives down/up, so the next user of the interface would bring
it up at the new rate. That seems to contradict the comment above about
not disturbing a pre-existing interface. test_raw_filter.sh behaves the
same way.

[ ... ]

> +trap cleanup EXIT INT TERM
> +setup
> +
> +tests_run
> +
> +exit $EXIT_STATUS

[Severity: Low]
cleanup() never calls exit. In bash, when the INT or TERM trap returns,
the script carries on with the next command.

If the signal arrives between setup and tests_run, could the test binary
still run against the vcan that cleanup() just deleted? J1939_SETUP_IFINDEX
would fail and log_test would report a FAIL.

If the signal arrives while the binary is running, log_test and
exit $EXIT_STATUS still run after the trap returns, and the EXIT trap then
calls cleanup() a second time.

bash also runs the EXIT trap on these signals. Would trap cleanup EXIT be
enough on its own, as in test_raw_filter.sh?

> diff --git a/tools/testing/selftests/net/can/j1939_tests.h b/tools/testing/selftests/net/can/j1939_tests.h
> new file mode 100644
> index 000000000000..dd70a7d60ec7
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/j1939_tests.h

[ ... ]

> +/* poll() + recv(): returns the recv() result, or -1 on timeout/error. */
> +static inline int recv_timeout(int s, void *buf, size_t len, int timeout_ms)
> +{
> +	struct pollfd pfd = { .fd = s, .events = POLLIN };
> +
> +	if (poll(&pfd, 1, timeout_ms) <= 0)
> +		return -1;
> +	return recv(s, buf, len, 0);
> +}
> +
> +/* Send len bytes on tx and verify they arrive byte-for-byte on rx. 0 / -1. */
> +static inline int send_recv_verify(int tx, int rx, const void *buf, size_t len,
> +				   int timeout_ms)
> +{
> +	uint8_t *rx_buf = malloc(len);
> +	int rc = -1;
> +
> +	if (!rx_buf)
> +		return -1;
> +	if (send(tx, buf, len, 0) == (ssize_t)len &&
> +	    recv_timeout(rx, rx_buf, len, timeout_ms) == (int)len &&
> +	    memcmp(buf, rx_buf, len) == 0)

[Severity: Medium]
Can send_recv_verify() catch a delivery that is longer than len?

rx_buf is exactly len bytes, and recv_timeout() calls recv(s, buf, len, 0).
For an oversized datagram, j1939_sk_recvmsg() does:

net/can/j1939/socket.c:j1939_sk_recvmsg() {
    ...
	if (size < skb->len)
		msg->msg_flags |= MSG_TRUNC;
	else
		size = skb->len;
    ...
	return size;
}

So recv() returns len and the MSG_TRUNC indication is lost. An over-long
delivery, for example from a TP/ETP reassembly regression that adds
padding bytes, would pass both the == (int)len check and the memcmp() over
the prefix.

Later in the series, test_j1939_base.c and test_j1939_addr.c use this
helper to check payload integrity at the transport size boundaries.

Passing MSG_TRUNC as an input flag won't work, because j1939_sk_recvmsg()
returns -EINVAL for any flag other than MSG_DONTWAIT, MSG_ERRQUEUE and
MSG_CMSG_COMPAT. Would a len + 1 receive buffer, or recvmsg() with a check
of msg_flags, work instead?

> +		rc = 0;
> +	free(rx_buf);
> +	return rc;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014154435.3577983-1-o.rempel%40pengutronix.de
