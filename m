Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D93E558A;
	Fri, 16 Oct 2026 07:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134015; cv=none; b=uy6CHKVrmzkWXREz4HWO87L22dv3MM4kwHu6SeNBVhouf8bYgfzoyxmXgtJ93dse6Ujo88CtqHquceEM+XYeLmItK7aAgHZToaViCOI+YU5CyIRk9o6nO6TTvEHVFbAIqzY/q/9+FTlP//RPfTMJbXA4GSLmDwKez9up1ipX8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134015; c=relaxed/simple;
	bh=m5RmNVlRhiZHSy0Sd+Dzphi/drTc8/FWs56IG3cLrww=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHmxeUye6rt+DBrk2gvC7aiB/RvW8KET7FpKonQoIUeo44Jkve4f4bLOC69l7jcX8kC3ORxaiN2E5MdMTMDj8np84Hn8f5/H3cTEHpiMDEctyowKq6koi8NUbetIcyuc4XSsJNrsO0f0AKBZorjTeGO8EcgEKU3lXtNCQXCWnlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftH19gvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftH19gvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F981F000C4;
	Fri, 16 Oct 2026 07:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792134005;
	bh=iZ0zjSBd5/ua9Opszr8Ahaz/InA7d5FIV/WlSa+YubM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ftH19gvH/Zi/12yvnWFyZ0uz1l3Nmvg/aqUFSAppkpHPVKMrrOjq+uEEkhQ+cZKd6
	 NmFmTyQq0N3PU/bvLs+B4yTWQwopmDM9+4ghRcCPWwzvZKq8jijahfdgiS1g6HL2eA
	 cweGpgxjkG76f+JeCVbiubWmbPR/G4nJcJhc0BHexceBe/eG2ogs1Q10yif5wgNo+L
	 bRiVd1JXi3fP8Q7bSGC1/5RTRrqhUmAjLOMus5suKwTF2K5ojjcKQd8CJmoKx6Lzg2
	 GMihlVpxvvdI1zcf22s+cCI0QV0q7pqBbePvv3UZtAIjBRSD6j47/WXax34+gg8eUr
	 4pz58fzn0AdcQ==
Subject: Re: [PATCH can-next v1 3/8] selftests: can: add J1939 socket option
 and metadata tests
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alexander.hoelzl@gmx.net, quchaosheng000406@163.com,
 penguin-kernel@I-love.SAKURA.ne.jp, kuba@kernel.org
Date: Fri, 16 Oct 2026 07:00:03 +0000
Message-ID: <179213400338.1406898.2140966543430053967@kernel.org>
In-Reply-To: <20261014154435.3577983-4-o.rempel@pengutronix.de>
References: <20261014154435.3577983-4-o.rempel@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] FIXTURE_SETUP(j1939_opts) always calls J1939_SETUP_RAW(self,
  0).
- [Medium] raw_prio() takes the first frame received on the unfiltered
  CAN_RAW socket and returns J1939_ID_PRIO(frame.can_id & CAN_EFF_MASK).
- [Low] test_j1939_opts.sh cannot run from a selective install of the CAN
  selftests (e.g. `make -C tools/testing/selftests TARGETS=net/can…

--

selftests: can: add J1939 socket option and metadata tests

This adds a new J1939 selftest, test_j1939_opts, that covers:

  - SO_J1939_FILTER
  - SO_J1939_SEND_PRIO, observed on the wire through a CAN_RAW socket
  - SO_J1939_PROMISC
  - unconnected sendto()
  - a bind() with the wrong address family
  - SO_J1939_ERRQUEUE TX-completion notifications

It also enables CONFIG_CAN_RAW in the test config fragment.

> diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
> index cf4bd2461a6c..24a57edb912c 100644
> --- a/tools/testing/selftests/net/can/Makefile
> +++ b/tools/testing/selftests/net/can/Makefile
> @@ -9,11 +9,13 @@ LOCAL_HDRS := j1939_tests.h
>  TEST_PROGS := \
>  	test_raw_filter.sh \
>  	test_j1939_base.sh \
> +	test_j1939_opts.sh \
>  
>  TEST_FILES := j1939_lib.sh

[Severity: Low]
Can test_j1939_opts.sh run from a CAN-only install, such as
make -C tools/testing/selftests TARGETS=net/can install?

The wrapper sources j1939_lib.sh, which does:

tools/testing/selftests/net/can/j1939_lib.sh:
    net_dir=$(dirname "$0")/..
    source "$net_dir/lib.sh"

net/lib.sh then sources lib/sh/defer.sh. This Makefile lists only
j1939_lib.sh in TEST_FILES. Nothing installs ../lib.sh or ../lib/sh/*.sh.

Other net subdirectories declare these files. For example,
net/mptcp/Makefile has:

    TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)

The top-level selftests Makefile adds net/lib as an install dependency
only for the net, drivers/net and drivers/net/hw targets, not for net/can.
Even when net/lib is added, it does not install net/lib.sh.

In the installed tree, sourcing ../lib.sh would fail. That leaves
ksft_skip, tests_run, check_err and log_test undefined, so the test can't
run.

test_raw_filter.sh has the same gap. The first patch of this series
carried it into j1939_lib.sh, this patch adds another test that depends on
it, and nothing later in the series fixes it.

Would a TEST_INCLUDES line like the mptcp one fix this?

[ ... ]

> diff --git a/tools/testing/selftests/net/can/test_j1939_opts.c b/tools/testing/selftests/net/can/test_j1939_opts.c
> new file mode 100644
> index 000000000000..f761a42db213
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_opts.c
> @@ -0,0 +1,305 @@

[ ... ]

> +/* Read the next CAN frame from a raw socket and return its J1939 priority. */
> +static int raw_prio(int raw, int timeout_ms)
> +{
> +	struct can_frame frame;
> +
> +	if (recv_timeout(raw, &frame, sizeof(frame), timeout_ms) < 0)
> +		return -1;
> +	return (int)J1939_ID_PRIO(frame.can_id & CAN_EFF_MASK);
> +}

[Severity: Medium]
Can raw_prio() decode a frame other than the one the test just sent?

self->raw comes from open_raw_rcvbuf(). That binds without a
CAN_RAW_FILTER, so CAN_RAW's default receive-all filter applies.

raw_prio() returns the priority of the first frame that arrives. It does
not check that J1939_ID_SA() is SA_TX, J1939_ID_PF() is J1939_PF(PGN_A) or
J1939_ID_PS() is SA_RX.

j1939_lib.sh supports real CAN interfaces as well as vcan:

    else
        ip link set dev "$CANIF" type can bitrate "$BITRATE" || exit $ksft_skip
    fi

On a bus with other nodes, a frame from another node could arrive between
FIXTURE_SETUP and the J1939 send. raw_prio() would decode that frame
instead. send_prio_default and send_prio_set would then compare its
priority with 6 or 3, and could fail or pass wrongly.

j1939_tests.h already has recv_match() and recv_for_peer() for this case.
The comment in recv_match() covers it: "Non-matching frames (other
traffic on the bus) ...".

Could raw_prio() use one of these, matching on source address, PF and PS?

On the default private vcan only the test's own frame is on the bus, so
the default run gives a reliable result.

[ ... ]

> +FIXTURE_SETUP(j1939_opts)
> +{
> +	self->tx = -1;
> +	self->rx = -1;
> +	self->raw = -1;
> +
> +	J1939_SETUP_IFINDEX(self);
> +
> +	J1939_SETUP_RAW(self, 0);
> +}

[Severity: Medium]
If a kernel has CONFIG_CAN_J1939 enabled but no CAN_RAW support, should
these tests be reported as skipped instead of failed?

J1939_SETUP_RAW() opens socket(PF_CAN, SOCK_RAW, CAN_RAW) through
open_raw_rcvbuf() and then calls ASSERT_GE() on the result. A missing
CAN_RAW protocol therefore fails the test instead of skipping it.

J1939_TEST_MAIN() says it will "Skip (rather than fail) when either is
missing", but it only probes CAN_J1939:

    probe = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
    if (probe < 0) {
        if (errno == EAFNOSUPPORT || errno == EPROTONOSUPPORT)
            return KSFT_SKIP;

CONFIG_CAN_RAW is a separate tristate, which is why this patch adds it to
the config fragment. Without it, all nine tests in the fixture fail in
setup.

Seven of the nine never use self->raw:

  filter_pgn
  sendto_unconnected
  bind_wrong_family
  errqueue_tx_completion
  getsockopt_send_prio
  getsockopt_promisc
  getsockopt_errqueue

Only send_prio_default and send_prio_set use it, through raw_prio().
Nothing later in the series changes this.

Could the raw socket be opened only in the two send_prio tests? Or could
the test skip when CAN_RAW is not available?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014154435.3577983-1-o.rempel%40pengutronix.de
