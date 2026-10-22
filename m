Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678524;
	b=3Z/yDVKNyvV65+jWS+V/CGB++8+XNRNEBA3HBXreY8VIz0gIllC7neLC0iIVOgfR8fJs
	 Cmjlg2Nno67ot7HYlhsNAD9IcEvxfZvNwHtkerCqktve9UEu4kxtmPIpxrRCOjg5TbOW4
	 saRQTf1U45/cVo/QtIybbvWqGptKXLoyPMTZ1hgU72sQ55s74V3zU4K+sS4NGjp+OxXHj
	 xm7SZT077fKj6/P0+GcRctGArbIcSbKzg8su/g5Wdq6n63ow3IB1YDvJfWkQQzID+A5a9
	 yVvDx5IGVIKg9S47ykP+zZvWlYr21yOp9x8/i0Pn0S7sZJNWFcHQHWF/oA4P7tNz2Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678524;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2UaCelFKwSvlDwAx0qoUh5UH+vXQ0rUeP4Ohw7vmt5k=;
	b=ytEcTcXTpDHm/xAdizwgvXrbDo1bY3Ger5IYOi5IT5UT11ra08duQRaibajQtHMVTZVn
	 q+xnwAShOpTPqWQWr5IoW7jP1sHUxyKSLh9Hzv0dxdWAq2ewHpZcqbtzWOqC8zayM5VSQ
	 mOioIE8HDk8QPR9M0kM5mfaVwA9S8w0kMb6kI2+fySJ14pONM/KXy7ZKiQNzGkC0Zgk7j
	 90Q0U82zje1owa7xfrQN3XhNRr8c64XLzvYcde5h8aEWiOSfYyhR7cVXpQGj7RFzjRojr
	 D0IJfrBlIEgFH5Hb3Bx7Mp9FVfsJKeMG84UX3k5S0xgXeyEP+4zyFzyqiUv/L4RZo7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=k5CbTgzI;
	arc=none smtp.remote-ip=212.27.42.1
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7E606A322;
	Thu, 22 Oct 2026 14:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22B7E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=k5CbTgzI
Received: from stf-laptop (unknown [IPv6:2a02:8424:8fef:6e01:68ea:cb82:d40f:9275])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 506F4B0053D;
	Thu, 22 Oct 2026 16:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792678522;
	bh=2UaCelFKwSvlDwAx0qoUh5UH+vXQ0rUeP4Ohw7vmt5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5CbTgzIcBTViRfBpZPrkS/B4KhcT7u2yb7FRIAIzWIuysdwrUl31+AdLOFHnx8PC
	 ip1g5n2/mL4r8F/cGMzluhGLqznNuZRfTL/cArm+bhXX0ICEfoWAp1lq3dQM8888r+
	 TDFP7XoQjZESxfxA6jn0Et/CXDc6Isj+i3X6cnn1Wga4iR8zic0yKr+OosB7BGWNNN
	 Y07hzKmsROhRBxcQ4TtEc85ESPF5z9Nbr4SP+EINxYSYSWF5WQddnipGoXK89sQ/nA
	 +xp9n/wWHNk+uHPq9+sfknvUkDseYOSj4nYBGtR+zyJst46QQC0Yg6kb4UzjPOs6yU
	 ifBu8VC+R2YYQ==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	error27@gmail.com,
	wg@grandegger.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v5 10/10] can: peak_usb: only dump received bytes on decode error
Date: Thu, 22 Oct 2026 16:15:04 +0200
Message-ID: <20261022141504.222900-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179264020123.3131.12155600294986434879@kernel.org>
References: <20261020-canfd_check_channel_idx-v5-10-a62b35b867f0@peak-system.fr> <179264020123.3131.12155600294986434879@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 22/10/2026 05:36, netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: High]
> Does this rate limit cover the FD and Pro adapters?
[...]
> Should the adapter-level dumps and their netdev_err() calls also be rate
> limited? Or could the core dump be skipped for adapters that already
> dump? Either way, each decode error would be dumped at most once and
> always under a rate limit.

Right, the PCAN-USB FD and Pro decoders dump the URB themselves, without
any rate limit. In v6, this patch also removes these two dumps, so that
an undecodable URB is dumped only once, by
peak_usb_read_bulk_callback() and rate limited, and it rate limits the
error messages the decoders print about the received data. The subject
changes accordingly.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but I noticed it in the Pro
> decode path. pcan_usb_pro_decode_buf() in pcan_usb_pro.c reads
> pr->data_type before it checks rec_ptr against msg_end:

Yes, fixed by a new patch in v6, see my reply to patch 8.

Thanks!

Stéphane

pw-bot: cr
