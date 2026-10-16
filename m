Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1883E411E;
	Fri, 16 Oct 2026 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134019; cv=none; b=lba54Cwz0hbuakBZrO2DX++IkvYnwUeVTvkk/A8DEhIcOnX/uUaBkLTHvqm8lGcxyGylNC/NvmdplHO3Fpe0uSIY0d9oKZaHSlv08aqsDRrBSEbcepQnMD+EFdnQZGi1Sp4+T+7nhNzEclkCxhGsaSX7hl0akbK0N5VSNw+BUYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134019; c=relaxed/simple;
	bh=2pwiQhJYWfRnAPyxfKKXeka/GDNPXpsaD0C6YvXmX/s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=guAD71t7VI/lC71OTSxziwliLXHzkA8UPw14k3DW6tP4lIiol+zlrUC7cGE5BzbTzQEN+veqqHqsq/Rx28GxaMRUtHIBwlG5k/BHzEtPeXzo5Wui6B1hJVxqLpUImlPszbeQ3inXrAF7pXTbKd7D1gjKyJV8gfQLpKmGTDvV4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNd8zpYN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNd8zpYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F821F000C8;
	Fri, 16 Oct 2026 07:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792134008;
	bh=fqcz5DDxh0WRC+T23TktfLkYQ28AegR+Q6SHPEsgbp8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RNd8zpYNop4JrsIsdvq2YfV6uOZMXOavEEC/H+io3GAO/JbUmssiR6Femac3YlIWI
	 HNja3M5ZJULoMH128ksvoEggQGF2ciN0HWOgXzMa1F2H6qj7LbNfHGPYXAj8zKS/re
	 38a0vuwjDDTRXLN2TpxMvo6Zq7VSWN/rJJWsCaEjqj0VvRHfmhsW7FmU497GjPOYE3
	 lmtiNeFCndGsTtv3tX8bCLuhFSENLIV/oE/1ja6jxv0lCpfQps2DOtRt1WhwzMKXID
	 i+yuVQIesWvy40bM5cAc+yEoMzjP62RLVG5dLqxwZ05xeCRX0jxgKoPKHBgLHIT/HH
	 J7T8Xc2PuUt4Q==
Subject: Re: [PATCH can-next v1 6/8] selftests: can: add J1939 TP/ETP
 multi-frame tests against CAN_RAW
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alexander.hoelzl@gmx.net, quchaosheng000406@163.com,
 penguin-kernel@I-love.SAKURA.ne.jp, kuba@kernel.org
Date: Fri, 16 Oct 2026 07:00:07 +0000
Message-ID: <179213400774.1406898.17439713276450411907@kernel.org>
In-Reply-To: <20261014154435.3577983-7-o.rempel@pengutronix.de>
References: <20261014154435.3577983-7-o.rempel@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Neither transmit test checks that the kernel completed the TX
  session after the peer's EOMA.
- [Low] The TP/ETP transmit tests accept DT frames shorter than 8 bytes,
  which the kernel's own transport receiver rejects.
- [Low] Both receive tests would accept an oversized reassembled datagram
  as a correct round-trip.
- [Low] The transmit tests would pass an out-of-order TP/ETP data stream,
  because unpack_dt_into() reorders the packets before the payload is…

--

selftests: can: add J1939 TP/ETP multi-frame tests against CAN_RAW

This commit adds a kselftest that pairs a J1939 socket with a CAN_RAW
peer and runs TP and ETP multi-frame transfers in both directions. The
raw peer answers the kernel's RTS/CTS/DPO sequencing, and the reassembled
payload is compared against the sent pattern. The test also checks the
size fields of the EOMA the kernel sends on receive and of the RTS it
sends on transmit.

> diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
> new file mode 100644
> index 000000000000..1f27ee58f48c
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_multi.c
> @@ -0,0 +1,453 @@

[ ... ]

> +/*
> + * Scatter a received DT frame's payload into buf at the offset implied by its
> + * sequence number. base_pkt is the 0-based absolute packet the 1-based seq is
> + * relative to (0 for TP, the DPO offset for ETP).
> + */
> +static void unpack_dt_into(uint8_t *buf, size_t total, unsigned int base_pkt,
> +			   const struct can_frame *frame)
> +{
> +	unsigned int abs_pkt = base_pkt + (frame->data[0] - 1);
> +	size_t off = (size_t)abs_pkt * 7;

[Severity: Low]
unpack_dt_into() places each payload at the offset given by the frame's
own sequence byte. Would the TX tests still pass if the kernel sent the
DT frames out of order?

In tp_tx_to_raw(), the loop increments got for every TP_DAT frame. It
never checks that frame.data[0] == got + 1. The inner loop in
etp_tx_to_raw() also never checks that the block-relative sequence
equals i + 1.

A permuted stream such as 2, 1, 3, ... with matching payloads would
still rebuild the expected rx_buf, and the memcmp() would pass.

The kernel's own receiver only advances on in-order packets, in
j1939_xtp_rx_dat_one():

    if (packet == session->pkt.rx)
        session->pkt.rx++;

So a conforming receiver would stall or abort on such a stream. Could
both TX loops assert the expected sequence number?

[ ... ]

> +static int tp_rx_roundtrip(FIXTURE_DATA(j1939_multi) *self,
> +			   unsigned int max_cts_pkts, int *max_want_out,
> +			   struct can_frame *eoma_out)
> +{
> +	uint8_t payload[TP_SIZE], rx_buf[TP_SIZE];

[ ... ]

> +	if (recv_timeout(self->j1939, rx_buf, sizeof(rx_buf),
> +			 J1939_RECV_TIMEOUT_MS) != (int)sizeof(rx_buf))
> +		return -1;
> +	if (memcmp(payload, rx_buf, sizeof(payload)) != 0)
> +		return -1;

[Severity: Low]
Can this length check catch a delivered datagram that is larger than
TP_SIZE?

recv_timeout() calls plain recv() into a buffer of exactly
sizeof(rx_buf). j1939_sk_recvmsg() reports an oversized datagram only
through msg_flags, and it returns the number of bytes copied:

net/can/j1939/socket.c:j1939_sk_recvmsg() {
    ...
	if (size < skb->len)
		msg->msg_flags |= MSG_TRUNC;
	else
		size = skb->len;
    ...
}

Suppose a reassembly regression delivered 203 bytes instead of 200
(pkt.total * 7 rounding plus trailing 0xff padding). recv() would still
return 200, and the memcmp() would pass.

The same gap exists in etp_rx_from_raw(), where the recv_timeout() of
ETP_SIZE bytes would not notice 6006 bytes delivered instead of 6000.

The commit message says "the reassembled payload is checked byte for
byte", but the length of the datagram that reaches the socket is never
checked. Would it help to receive into a larger buffer, or to use
recvmsg() and check for MSG_TRUNC?

[ ... ]

> +TEST_F(j1939_multi, tp_tx_to_raw)
> +{

[ ... ]

> +	while (got < num_pkts) {
> +		ASSERT_EQ(recv_for_peer(self->raw, J1939_PF(TP_DAT), SA_PEER, &frame,
> +					J1939_RECV_TIMEOUT_MS), 0)
> +			TH_LOG("missing DT after %u/%u packets", got, num_pkts);
> +		unpack_dt_into(rx_buf, TP_SIZE, 0, &frame);
> +		got++;
> +	}

[Severity: Low]
Should this loop also check that frame.can_dlc == 8 for each DT frame?

match_peer_dest() in j1939_tests.h, used by recv_for_peer(), only
compares the PF and PS fields of the CAN ID. unpack_dt_into() then
copies at most the bytes still needed.

The kernel's own receiver rejects short DT frames in
j1939_xtp_rx_dat_one():

    if (skb->len != 8) {
        /* makes no sense */
        abort = J1939_XTP_ABORT_UNEXPECTED_DATA;

On transmit, full-length DT frames depend on the padding in
j1939_tp_tx_dat():

    if (j1939_tp_padding && len < 8)
        memset(skb_put(skb, 8 - len), 0xff, 8 - len);

If that padding regressed, the last DT frame would go out short. That is
5 bytes for packet 29 with TP_SIZE, and 2 bytes for packet 858 with
ETP_SIZE. rx_buf would still match, so both tp_tx_to_raw() and
etp_tx_to_raw() would pass.

> +
> +	/* acknowledge with EOMA */
> +	ctl_dat_init(dat, TP_CMD_EOMA);
> +	put_le16(&dat[1], TP_SIZE);
> +	dat[3] = num_pkts;
> +	ASSERT_EQ(send_ctl_frame(self->raw, PRIO, TP_CTL, SA_LOCAL, SA_PEER,
> +				 dat, PGN_DATA), 0);
> +
> +	EXPECT_EQ(memcmp(payload, rx_buf, sizeof(payload)), 0);
> +}

[Severity: Low]
After the EOMA is sent, the test only compares rx_buf, and rx_buf was
filled from DT frames received before the EOMA went out. Does anything
confirm that the kernel actually accepted the acknowledgement?

The TX session is only acked and completed in j1939_xtp_rx_eoma_one():

    session->pkt.tx_acked = session->pkt.total;
    j1939_session_timers_cancel(session);
    /* transmitted without problems */
    j1939_session_completed(session);

Several failures would still let tp_tx_to_raw() pass:

  - a bad-PGN match in j1939_xtp_rx_cmd_bad_pgn()
  - a failed session lookup
  - a T3 timeout abort after the last DT

etp_tx_to_raw() has the same gap: it ends right after sending the ETP
EOMA. In both cases, teardown closes the sockets before any abort or
completion can be observed.

The commit message says the tests drive the round-trips "in both
directions", but the last step on the TX side is never verified. Could
the tests wait for SCM_TSTAMP_ACK on the j1939 socket, or check that no
TP.Abort follows on the raw socket?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014154435.3577983-1-o.rempel%40pengutronix.de
