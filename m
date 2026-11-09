Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224266;
	b=o6Twq0hs2sIqjk3xA7J2QJC066THdPlOibG/TWghmeBPA7o0pHtHE3YudH8hGQXDAj4E
	 VnQRLfrYmznlV3tpGHI2KUmj+Wgc/F2SEcg/y+y+qFqC/AYldHNy/ebPYdHLefAXp2L/E
	 D2FCWhnvp7tk8JodpYHEA6rf7TwHzDyvGCpjE5wOYVSJmgfk6iNNFpX2acfNd4MrRt+Mt
	 ztZDcdZTpkxFwqSIXKR9lMDYHGfF0FsYkHSrQLhqSh0eyxc04kAQII/XIoWPye8Zn5Vlq
	 iA1M/IE2+7SHo0iUQG3o+uHyPFWsinbpBRX6BF23SXZWjzyM+mH54rnpojv+v3zKdbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224266;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2ViT3Yo4M3SsUpvja1R5K7/sF1YFo5i6DucfxLblQBU=;
	b=Cj2OwRhU39mQR75Ur2nN9z8GWlmAjSs7m0rNcJI8XLsPzM2g+d0J2lGPkCUe+syG+MHc
	 EOKwJcjhGqtdDI1ObdeBeGxnbp0VAHCrrVyW5tVgcZ3PsdY59pGvmQ8LctYbQhrh8MlrC
	 r5Ec3j90qr0DcUL0WyCHbEq40LIEkug1rdDeYRD72sQUSXuYOYVV+reE5C7WeyDZDBDJw
	 MXvJI8HtmGBD8yiPSHOnrE/3WpWvXlcH1seLJ3TIrMIXjVTTBR5nBfC9f6yUltcxMwmFB
	 NEdlQzknJG47I296wCA3/Uoxo6bQ3C0DEDkGnQ8zNcXsTSigaIvRuix2o2h2WmnkYHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsNl7ZDe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A6606A330;
	Mon,  9 Nov 2026 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsNl7ZDe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21341F0089F;
	Mon,  9 Nov 2026 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224265;
	bh=2ViT3Yo4M3SsUpvja1R5K7/sF1YFo5i6DucfxLblQBU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BsNl7ZDeGyPFQKK2Sj1fAO+4RkRF1uiZ6sP5hR44G7QzyBrQ44q9NwfvOW/fxL2n6
	 1GgkdTCTfIHUWTTx+NhQtw/CVAybuER3+EHRhrGsmvVzn14YrIP9RG2aOMLXDapPfB
	 FTcDrtf/1N9pKXuB+yw2ztzN8T96RVDxGQnnzftygYfPR6rhvkqUEyUgtq2PKSUkvR
	 zkKXPatfQr+bwb57/ifJYEpOR9/QZqsHtrXWmEdCCHNZPT9JNCB6SY/bThhSbCYMbK
	 i8P762UuS7STpaLKdWxNs40zTEM5U939heEyAKA/tqh6mf9b9LN5u7HKTI45OKXUFm
	 CfMbFacbIj/wg==
Subject:
 Re: [PATCH net v8 03/10] can: rockchip_canfd: retry the outstanding TX buffer
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol@kernel.org,
 heiko@sntech.de, socketcan@hartkopp.net, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 wg@grandegger.com, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Mon, 09 Nov 2026 11:37:44 +0000
Message-ID: <179422426444.994134.7825659732864102594@kernel.org>
In-Reply-To: <20261108-rockchip-canfd-restart-close-v8-3-3e7a23fd9eae@qq.com>
References: <20261108-rockchip-canfd-restart-close-v8-3-3e7a23fd9eae@qq.com>
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

- [Low] The commit message for "can: rockchip_canfd: retry the
  outstanding TX buffer" states the user-visible failure ("the pending…

--

can: rockchip_canfd: retry the outstanding TX buffer

This patch changes rkcanfd_xmit_retry() so the erratum 6 retransmission
uses tx_tail instead of tx_head to pick the TX buffer. The goal is to retry
the frame that is still pending rather than the next free buffer. It is
tagged for stable with a Fixes: tag pointing at a5605d61c7dd.

> Use tx_tail to retry the outstanding buffer. Otherwise, the pending echo
> entry can remain incomplete and leave the TX queue stopped.

[Severity: Low]
The tx_tail indexing looks correct. The stable justification is harder to
check, though, because the stall described here depends on how the
hardware handles TX_REQ(n), and the commit message doesn't say.

The controller has one TX frame register window (RKCANFD_REG_FD_TXFRAMEINFO,
RKCANFD_REG_FD_TXID, RKCANFD_REG_FD_TXDATA0..) and two request bits. Every
frame is written into that shared window in rkcanfd_start_xmit() before
TX_REQ(tx_head) is issued.

rkcanfd_xmit_retry() has one caller, rkcanfd_rxstx_filter(). That caller
only gets that far when the nominal frame echo_skb[tx_tail] is EFF:

drivers/net/can/rockchip/rockchip_canfd-rx.c:rkcanfd_rxstx_filter() {
    ...
	if (!(cfd_nominal->can_id & CAN_EFF_FLAG) ||
	    (cfd_rx->can_id & CAN_EFF_FLAG))
		return 0;
    ...
	rkcanfd_xmit_retry(priv);
    ...
}

While the tail frame is EFF, no further frame can be queued:

drivers/net/can/rockchip/rockchip_canfd-tx.c:rkcanfd_get_effective_tx_free() {
    ...
	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_6 &&
	    rkcanfd_tx_tail_is_eff(priv))
		return 0;
    ...
}

So whenever the retry runs, exactly one frame should be pending, and it
should be the last frame written into the shared window.

If writing TX_REQ(n) latches the current window into buffer n, wouldn't the
old TX_REQ(tx_head) have resent the correct frame? The echo would then
match echo_skb[tx_tail] and completion would go ahead normally.

As far as I can tell, the stall only happens if buffer n keeps its old
contents and TX_REQ(n) resends them without reloading from the window.

Was the stall actually seen on hardware, or is this mainly making the slot
indexing consistent with the echo_skb[tx_tail] model? The Erratum 6 comment
in rockchip_canfd.h has a canfdtest reproducer, and a5605d61c7dd carries a
Tested-by for the depth-2 change.

Could the commit message say which TX_REQ(n) behaviour the fix relies on,
or add a Tested-by or reproducer, so stable backporters can judge it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae%40qq.com
