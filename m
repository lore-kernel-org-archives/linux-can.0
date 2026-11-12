Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520181;
	b=Kg0nhTMZ8+vm9rIjCe/IonaUW9aUWmk0E4A0gDrCMl/btceNk//zSWS4o6uRYu0AjAgK
	 CopAVhqib0LP3D+lXjNm7/d/Fble/M3pSsBiNvA/cf8mjILcO7qmHKeiPAy5MDcgHNSFc
	 qq5MORbAaHHXGSOeNbVdN4cKduuxAaJCtlTRFoo3NaJBXf4Z4uYpRpWfpIKnFnYM0oMwc
	 xq35fH7EJeHyYsHNhy/YGcz+Iin2d7Lw4irR7AV44Wdl1AOusj2rV83jBEmyT/MwfiiTn
	 rtmfs/xaVqw8A0IktPyzvoRLZLapC8hUkjZ6SaJOF+UKm0yN/r+9BWUyWy2MMacT4XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520181;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wRMOb17O5phBW+GpxeAAqa2imT8sjbBIBEeJUnW2A8Q=;
	b=4mfW76NQg9sKswB6Arn67RUw4eDR+nXoTsTz4Id9He+JEfklk+iZluKGrnPNcI/cf2xn
	 uVujyZBtD0P1hBYNFqrLo6psyNhIB1kr0GLyjLBlXJCAi5IEp1tfEPw0KDwOhdaRPTuLs
	 9PYEjjuWZYuLjNHUa5rxEjZENcPou+A0IojfRXbM+I520FK83bVNlxU3bqNcxDZ29NNlZ
	 M5gzGAA0V1ODsjgQSwp9H0ejHSA1EO6dTJpVKX8Aou9PJNWvk25Mf3/wL8kXOrrsVpMeL
	 r4lD7t4a5WmzXLb/fktjqqGMn2uJEM9mDxQ8wD3lryPTSb+Z36DyhQtQVLrMe0HMZsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBA1zS6M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0CE606A887;
	Thu, 12 Nov 2026 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBA1zS6M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8531F000C4;
	Thu, 12 Nov 2026 21:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794520181;
	bh=wRMOb17O5phBW+GpxeAAqa2imT8sjbBIBEeJUnW2A8Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oBA1zS6MLJTulLyyrRcANKlHHGuSV3Y5sh6Vl6vg9Fpm1TDaVwh/+9DHvSr5uuv5Z
	 Qbt7E+Zb1cz9XcYgkUPPh9A8LQDlPKUolxL+IsUDKjC0iysFpkbP0iKnif4p2c12JL
	 j5I6uL36uYyzWatfEyRbIBBnocqvj9gyHTa7UCLwX95VgwxlwY3fU4tgSu3GStwuMN
	 9NnYbouSjWwFCVGr8R2hO15lM4tAjrXzoHr4cjpXTmZmHMy2+6xPD9yw7K362O7SKb
	 dn8WYjp8FylDQvptc9IYI+DUpZqT1Kq8Np8Pb6rXZnXmXtqevHwGdkiZ7uuhGcY3Nw
	 eitbFqOqawfvg==
Subject: Re: [PATCH net v7 3/4] can: j1939: drop the message when the
 reassembled skb is gone
From: netdev-bot+sashiko@kernel.org
To: quchaosheng000406@163.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 12 Nov 2026 21:49:40 +0000
Message-ID: <179452018024.488853.2874336452045412196@kernel.org>
In-Reply-To: <179410166346.60581.12668181404057434786@163.com>
References: <179410166346.60581.12668181404057434786@163.com>
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

- [Low] The new NULL branch in j1939_session_completed()
  (net/can/j1939/transport.c) drops the reassembled message without…
- [Low] This patch makes the comment in j1939_xtp_rx_dpo_one()
  (net/can/j1939/transport.c, lines 1871-1883) out of date.

--

can: j1939: drop the message when the reassembled skb is gone

This adds a NULL check in j1939_session_completed() on the skb returned by
j1939_session_skb_get(). A failed lookup now drops the reassembled message
instead of passing NULL to j1939_sk_recv(). The commit message says
pkt.dpo is already bounded when an EDPO is received, so this is defense in
depth.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index b0e62822b56e4..5f05c15114ce4 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1269,9 +1269,19 @@ static void j1939_session_completed(struct j1939_session *session)
>  
>  	if (!session->transmission) {
>  		se_skb = j1939_session_skb_get(session);
> -		/* distribute among j1939 receivers */
> -		j1939_sk_recv(session->priv, se_skb);
> -		consume_skb(se_skb);
> +
> +		/* Defense in depth: pkt.dpo is range checked when an EDPO is
> +		 * received, so the lookup should always find the skb.  Drop the
> +		 * message rather than hand a NULL skb to j1939_sk_recv() if the
> +		 * offset arithmetic ever regresses.  The only other caller of
> +		 * j1939_session_skb_get(), j1939_simple_txnext(), already does
> +		 * this.
> +		 */
> +		if (se_skb) {
> +			/* distribute among j1939 receivers */
> +			j1939_sk_recv(session->priv, se_skb);
> +			consume_skb(se_skb);
> +		}

[Severity: Low]
If the offset arithmetic does regress, would anyone notice?

When se_skb is NULL, the message is dropped with no WARN. session->err
stays at zero, and nothing is queued for userspace. The only output is the
netdev_dbg() in j1939_session_skb_get_by_offset(), which is off unless
dynamic debug is enabled.

On the userspace side, j1939_session_destroy() only reports RX_ABORT when
session->err is set:

	} else if (session->err) {
			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
	}

A receiver using SOF_TIMESTAMPING_RX_SOFTWARE would see
J1939_ERRQUEUE_RX_RTS, and possibly RX_DPO. After that it would get
neither the data nor an RX_ABORT.

The commit message also says:

    a dropped message is a lost datagram.

For an RTS/CTS receive session, j1939_session_completed() is reached from
j1939_xtp_rx_eoma_one() when the receiver's own EOMA comes back on
loopback. By then the originator has already been told the message was
delivered, so the two sides would disagree about delivery.

This branch cannot be reached in the current tree.
j1939_xtp_rx_dpo_one() rejects dpo >= session->pkt.total before storing
it, and TP and BAM sessions keep pkt.dpo at 0. The concern is that the
guard would not catch the regression it was added for.

Would WARN_ON_ONCE(!se_skb) plus setting session->err (for example to
-EBADMSG) fit better here? That would show the condition in the logs and
deliver the RX_ABORT errqueue notification.

[Severity: Low]
This isn't a bug, but this change makes a comment in
j1939_xtp_rx_dpo_one() out of date. That comment was added by "can: j1939:
validate the EDPO packet number" and still says:

	 * j1939_session_completed(), which asks j1939_session_skb_get() for a
	 * packet past the end of the queued skb, gets NULL, and passes it to
	 * j1939_sk_recv().

With the new if (se_skb) check, a failed lookup no longer reaches
j1939_sk_recv(). Without the EDPO bound, the message would now be
silently dropped after the receiver's EOMA has been sent.

Could that comment be updated along with this change? The last patch in
the series, "can: j1939: reject a CTS that names more packets than the
message has", only touches j1939_xtp_rx_cts_one(). The comment is still
stale at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179410166344.60581.3898011861151549156%40163.com
