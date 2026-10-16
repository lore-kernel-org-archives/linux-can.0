Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75653E49C2;
	Fri, 16 Oct 2026 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134018; cv=none; b=TwqjLJhM7Yqi1KnxrRw0ECPVQlf1zqk9I+GEENQ4guGJp1Uc8BGaqxKsoO8L1WfLjXiCcSItZp+XHDr9jI3V89g+2y+bsRuTkUiTQVNC/LEm+S3Gy12XoD4pemNMSQTGEUnBSoou7wsaFhT3CbXeYMDAfUYD5vKmfjxVr3+HOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134018; c=relaxed/simple;
	bh=S9zcJQhk2vvhsE4gWkS0DdL6lwktRQKpn2g3eIh46yI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wm/8ZP/qKkSM1uQN36/W+/T+F3wEjpTM0zgLU5eJb+Yt9NvS/E5jtvIPF1b3mGApe17ii+khQw8r3KwgnAHL7v4sPg6Guez+TdOUObacW8OX6T1EXHByP+fSDPu7MuPQMPnglAoRM6KY5SeuxEb6LkU6r8rksQuFRJSVgrYc9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2+008s+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2+008s+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37D81F000C7;
	Fri, 16 Oct 2026 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792134007;
	bh=4+cn8ewrjOecbSF6/zei3Nbc/uIgVqYRGth5saecA3g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j2+008s+s3CCHqg5AVI0boRTFQP72TtyHyh00Vlr1pUGhpBtnw9FlCBUhPAtFGhsD
	 9XV7B2VPlIox9EqxOF0TCFW79sfJIc5NwtBT3EETNmmmANLwUiBbZMwemh/q+LAFf+
	 moZXXHtPR7IcZONVbjwCNGIqE0dPwZhT1QH41lkBoaQsJsRKd8bEpfjM3RQeTYpn1P
	 8JG69cHyzejGal8/oH4DwFQ6NDyD7fo6Sg56yfQHzoqwYV9eDreYPozcvve6LLHEm8
	 METQZgN44feZOrXJLOHxb5RPvONSyKgnATSGKpB3uMCadwoqx3079qH/ir1mKNQNsZ
	 BXsAJEwT/N6GQ==
Subject: Re: [PATCH can-next v1 5/8] selftests: can: add J1939 wire-format
 tests against CAN_RAW
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alexander.hoelzl@gmx.net, quchaosheng000406@163.com,
 penguin-kernel@I-love.SAKURA.ne.jp, kuba@kernel.org
Date: Fri, 16 Oct 2026 07:00:06 +0000
Message-ID: <179213400640.1406898.2222807046631827570@kernel.org>
In-Reply-To: <20261014154435.3577983-6-o.rempel@pengutronix.de>
References: <20261014154435.3577983-6-o.rempel@pengutronix.de>
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

- [Medium] On a real CAN interface, tx_to_raw_send_recv() in
  tools/testing/selftests/net/can/test_j1939_wire.c can check the wrong…
- [Low] The TX tests check only part of the CAN id, although the file
  header (lines 6-8) says they verify 'the expected CAN id (priority,…
- [Low] The RX tests do not check how the kernel parses the source
  address or priority, although the file header says frames are checked…
- [Low] The commit message overstates the gap the test fills.

--

selftests: can: add J1939 wire-format tests against CAN_RAW

This adds test_j1939_wire, which pairs a J1939 socket with a CAN_RAW
socket so the CAN frames on the wire are checked in both directions. It
covers PDU1 (destination specific) and PDU2 (broadcast) single frames,
both for J1939 TX seen on CAN_RAW and for raw-injected frames received
on a J1939 socket.

> The base test only exercises J1939-socket-to-J1939-socket
> transfers, which stay on the local delivery path inside one netdevice, so
> the on-wire format is otherwise unchecked.

[Severity: Low]
Is this description accurate?

Earlier patches in this series already look at on-wire CAN ids through
a CAN_RAW peer. raw_prio() in test_j1939_opts.c (from "selftests: can:
add J1939 socket option and metadata tests") decodes the priority:

    return (int)J1939_ID_PRIO(frame.can_id & CAN_EFF_MASK);

source_sa_on_wire() in test_j1939_addr.c (from "selftests: can: add
J1939 addressing and concurrency tests") checks the source address:

    EXPECT_EQ((int)J1939_ID_SA(frame.can_id), SA_TX)

J1939-to-J1939 traffic also does not take a shortcut inside the stack.
j1939_send_one() builds the full CAN id and loops the frame back through
can_send():

net/can/j1939/main.c:j1939_send_one() {
    ...
	cf->can_id = canid;
	cf->len = dlc;

	return can_send(skb, 1);
}

j1939_can_recv() then decodes the looped-back frame, so the base test
already exercises encode and decode. It only misses errors that are
symmetric between the two.

Could the commit message describe what this patch actually adds? That
is the PF/PS/full-PGN and payload checks for PDU1/PDU2, plus delivery
of injected raw frames to J1939 data sockets.

> diff --git a/tools/testing/selftests/net/can/test_j1939_wire.c b/tools/testing/selftests/net/can/test_j1939_wire.c
> new file mode 100644
> index 000000000000..8f5113394f99
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_wire.c
> @@ -0,0 +1,170 @@

[ ... ]

> +static int rx_single_frame_check(FIXTURE_DATA(j1939_wire) *self, bool bcast,
> +				 pgn_t pgn, uint8_t da, const uint8_t payload[8])
> +{
> +	uint8_t rx_buf[8];
> +
> +	if (bcast)
> +		self->j1939 = j1939_open_flags(self->ifindex, J1939_NO_NAME,
> +					       SA_LOCAL, pgn, J1939_OPEN_BCAST);
> +	else
> +		self->j1939 = j1939_open(self->ifindex, SA_LOCAL, pgn);
> +	if (self->j1939 < 0)
> +		return -1;
> +
> +	if (send_raw8(self->raw, PRIO, pgn, da, SA_PEER, payload))
> +		return -1;
> +
> +	if (recv_timeout(self->j1939, rx_buf, sizeof(rx_buf),
> +			 J1939_RECV_TIMEOUT_MS) != (int)sizeof(rx_buf))
> +		return -1;
> +
> +	return memcmp(rx_buf, payload, sizeof(rx_buf)) == 0 ? 0 : -1;
> +}

[Severity: Low]
Does this check how the kernel parses the source address or the
priority? The file header says an injected frame "is parsed and
delivered to the J1939 socket". However, recv_timeout() is a plain
recv(), so the sockaddr_can holding the parsed SA/PGN is thrown away.
Only the payload gets compared.

The RX socket is bound but never connected. j1939_sk_match_dst() only
applies the source address filter to connected sockets:

net/can/j1939/socket.c:j1939_sk_match_dst() {
    ...
	/* Source address filter */
	if (jsk->state & J1939_SOCK_CONNECTED) {
    ...
}

Suppose j1939_can_recv() decoded skcb->addr.sa wrongly (to any value
other than 0xff), or decoded skcb->priority wrongly. The payload would
still be delivered, and rx_pdu1_from_raw and rx_pdu2_from_raw would
pass. Wrong PGN or DA parsing would stop delivery, so those are only
covered indirectly.

Would it work to use recvfrom() here and check that
addr.can_addr.j1939.addr == SA_PEER and addr.can_addr.j1939.pgn == pgn?
The SCM_J1939_PRIO cmsg could also be checked.

> +static int tx_to_raw_send_recv(FIXTURE_DATA(j1939_wire) *self, bool bcast,
> +			       pgn_t pgn, uint8_t da, const uint8_t payload[8],
> +			       struct can_frame *frame)
> +{

[ ... ]

> +	if (send(self->j1939, payload, 8, 0) != 8)
> +		return -1;
> +
> +	if (recv_timeout(self->raw, frame, sizeof(*frame),
> +			 J1939_RECV_TIMEOUT_MS) <= 0)
> +		return -1;
> +
> +	return 0;
> +}

[Severity: Medium]
Can this return an unrelated frame when CANIF is a real CAN interface?

FIXTURE_SETUP opens self->raw with J1939_SETUP_RAW(self, 0), which keeps
the default accept-all filter, before the J1939 socket exists. The first
frame it returns is assumed to be the one the J1939 socket just sent.
Nothing checks SA, PGN or destination before tx_pdu1_to_raw() and
tx_pdu2_to_raw() assert on its fields.

j1939_lib.sh supports non-vcan interfaces explicitly:

tools/testing/selftests/net/can/j1939_lib.sh:setup() {
	if [[ $CANIF == vcan* ]]; then
		ip link add name "$CANIF" type vcan || exit $ksft_skip
		created=1
	else
		ip link set dev "$CANIF" type can bitrate "$BITRATE" || exit $ksft_skip
	fi
    ...
}

If another node sends a frame on that bus, the PRIO/SA/PS/PF/payload
checks run against that frame, and the TX tests fail on a correct
kernel. A freshly created vcan has no other traffic, so the default run
is not affected.

j1939_tests.h already has a helper for this case. The comment in
recv_match() says:

	/*
	 * Non-matching frames (other traffic on the bus) must not refresh the
	 * timeout, or a busy bus would keep the loop alive forever. ...

Could this use recv_for_peer(self->raw, J1939_PF(pgn), da, frame, ...)
for PDU1, and a recv_match() predicate on the full PGN plus SA_LOCAL
for PDU2?

The same unfiltered pattern is already in source_sa_on_wire() and
raw_prio() from earlier patches in this series. This patch adds new
instances of it.

Also, the file header says "The vcan interface is set up by the caller
(see test_j1939_wire.sh)". The wrapper accepts non-vcan interfaces too,
so the header does not match.

> +/* J1939 TX -> CAN_RAW: destination-specific (PDU1) single frame. */
> +TEST_F(j1939_wire, tx_pdu1_to_raw)
> +{
> +	uint8_t payload[8] = { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88 };
> +	struct can_frame frame;
> +	canid_t id;
> +
> +	ASSERT_EQ(tx_to_raw_send_recv(self, false, PGN_PDU1, SA_PEER, payload,
> +				      &frame), 0);
> +	id = frame.can_id & CAN_EFF_MASK;
> +
> +	EXPECT_EQ(J1939_ID_PRIO(id), PRIO);
> +	EXPECT_EQ(J1939_ID_SA(id), SA_LOCAL);			/* source address */
> +	EXPECT_EQ(J1939_ID_PS(id), SA_PEER);		/* destination (PS) */
> +	EXPECT_EQ(J1939_ID_PF(id), J1939_PF(PGN_PDU1));

[Severity: Low]
Does this cover the whole CAN id that the file header promises ("the
expected CAN id (priority, PGN, source and destination)")?

Both tx_pdu1_to_raw() and tx_pdu2_to_raw() mask with CAN_EFF_MASK
before any assertion, so CAN_EFF_FLAG (and RTR/ERR) are never checked.
j1939_send_one() builds the id with the flag set:

	canid = CAN_EFF_FLAG |
		(skcb->priority << 26) |
		(skcb->addr.pgn << 8) |
		skcb->addr.sa;

A regression that dropped CAN_EFF_FLAG would still pass.

For PDU1, the PGN check here only covers PF (bits 16-23). The DP and
EDP bits (24-25) are never checked. tx_pdu2_to_raw() compares the full
PGN with (id >> 8) & J1939_PGN_MAX, so the two TX tests check different
things.

j1939_tests.h already has j1939_canid(), documented as "Encode a J1939
single frame the way the kernel does on transmit", and send_raw8() uses
it on the RX side. Would a direct comparison like this cover every
field in both tests?

    EXPECT_EQ(frame.can_id, j1939_canid(PRIO, pgn, da, SA_LOCAL));

> +	ASSERT_EQ(frame.can_dlc, sizeof(payload));
> +	EXPECT_EQ(memcmp(frame.data, payload, sizeof(payload)), 0);
> +}

[ ... ]

> +/* J1939 TX -> CAN_RAW: broadcast (PDU2) single frame. */
> +TEST_F(j1939_wire, tx_pdu2_to_raw)
> +{
> +	uint8_t payload[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };
> +	struct can_frame frame;
> +	canid_t id;
> +
> +	ASSERT_EQ(tx_to_raw_send_recv(self, true, PGN_PDU2, J1939_NO_ADDR,
> +				      payload, &frame), 0);
> +	id = frame.can_id & CAN_EFF_MASK;
> +
> +	EXPECT_EQ(J1939_ID_PRIO(id), PRIO);
> +	EXPECT_EQ(J1939_ID_SA(id), SA_LOCAL);			/* source address */
> +	EXPECT_EQ((id >> 8) & J1939_PGN_MAX, PGN_PDU2);	/* full broadcast PGN */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014154435.3577983-1-o.rempel%40pengutronix.de
