Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AA18DB1A
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787718737; cv=none; b=HbzHetksgjQe1hECshD0638+8si8+b0X73o/QyD/DNtbzwJQT4HDCXSE8CtGhOsDszzhwDqsgstnrdxWafdrVaAX26WKcRcfgvYuOQnIaNWl1rPk9Hr734HOza53XsJNPqqEyWe05HyICFzoyZSYLOuYgX25BhbB5lY5t4YWcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787718737; c=relaxed/simple;
	bh=bP/R0qRwuRYhPdgmtfPE2qJ7BfGoGQBTaSoWyfiZRRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1RltFVp8lEAPE4UPPncmypFquBqNhMO0uAr1NCBhie31PT5QV+nyjFLHSmfGKcZlL0elfn+IdNGb1RZeHyM0vZwSu0pfj9+5ULIeK/pAoWfRCwfZ9UNFvI7czZ4Y82Ly4Lo1iqb/wYbmYqj3ecpZC06AVMGlL4EFz2Em2kfx/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdVOhmZQ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdVOhmZQ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81ecf499af9so8554337b3.1
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 21:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787718735; x=1788323535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bP/R0qRwuRYhPdgmtfPE2qJ7BfGoGQBTaSoWyfiZRRE=;
        b=IdVOhmZQ/BLGb3U6v1DdLUDSuIkk/zG4QDd1wMeGy6J5uZK2JYDGwURfy0AGpa7I1D
         Mh4THmh7wjd2NvRlWfBZDhMBI1TeYuw4dy70mWJMZXcLJ9f1gc0mEovm3wxvRoGVJcAd
         MjfKsjE1IfCS9CgRNZ5WjOIjF7bfQL0oQRcNT6qJFK1P6uNsiTVVfJ+RI+F1OCxOkXwf
         gdJunbQpMV6GVm/hswuyJto0dLfCRMF6sxks3quSsRAp/AZkMUA/+vOjyXO/e97lcPi5
         o8ALGYvzbmD31htamv2XsF38SDZ5lM3PbQscZRES6kcnU5+hEragAn6Tfrqzcg0F+J/G
         QJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787718735; x=1788323535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bP/R0qRwuRYhPdgmtfPE2qJ7BfGoGQBTaSoWyfiZRRE=;
        b=OxITfGsSt48HWkKjezw3+0idOQZTLK7ePLgCgrrtQFvWHYvDvvfI9Hvyl7NjZiPND1
         kbS+NKRxbPRImjwudixF64LWrCj8hwMvnSIQbgP2pIpd9nH8sr7ql7UVCbtGjA0o0Hwk
         qq6AhrPpztmhgHULNTYN1Nofskkm4xAj2k64VaE+J9n50YsPu5DcIsN7Q7NsbK62hZr0
         96Dtqx248oc9pjxVzNX8Y4kf1sHvQ80Pzr5ItPLkSDnnO3eOcEeg3xC8Kcm2o+LnSfDF
         8cRjr0CngHF5n88l4bL4f+a15Wk04t5DGKhxSNEu6DU1s3IwjVSo8N7U+72JgyOv69pb
         dt7w==
X-Forwarded-Encrypted: i=1; AHgh+Rqr0SO3UKhoaz3MdDUPYpb3Px9ILF+hqALabEAGdcW1UkGZaiaB9/t1UAyzViX1n8BlVTquVUjy/YY=@vger.kernel.org
X-Gm-Message-State: AFuF++nfKHpbNvZBg89wVMpkB7DCHXEHYp0ckzcMNT43wOQMC5WeRc7d
	qkOJGM3vzgxXKnvwijsfHpNG2LRvx94Dj5UKjfSluRG2fQfFGfe/hySI
X-Gm-Gg: AR+sD13/AOnlmFv+JUpusar7mKTrmFYEgqpythEdjdC4JmWlX0rGMo5GIob30ZUYRAO
	LPy1nltfyKf6IjE/+ubBZq39sY06eqPDvkIcynqOtQ0I+2IE6CJWKSJd0TbyUuiTuVpxrJV18/N
	n/wf0YiRcSSUVigN3QTCIfARE5pSZa1G0RL5ef8eJ5dvmWjdGE55dPIzvfBOI29Yg2rwWIgVit6
	S7BmCK/WeFi+NdvKfqm2H1bPh9ipZL4WokVx0Joqs4t9cHpY/Vk8Uh6oEyMM/PgdqhvajtkWmGB
	XC8oIWHQDVze2DOfizi/3mJmr71MgLetPJCk6du985933ZR+GqV4tj0+80z8q4AOUxBqq5LvBrQ
	JrAPqf3vkP3FM/N2BSZXws6rUpRqsfPGLbejM8l4rNfgdegDq8aI+7sp+lm9fJ8nndCdnptvW3b
	4d/VFwff/iebTO4sKkZFIBViOj8TqSGrQP7nUHpka4pz4xVxVkFdmtN082AtAv4Yol4FQ=
X-Received: by 2002:a05:690c:61c1:b0:854:d9d0:46b5 with SMTP id 00721157ae682-8573f8e40f2mr18236597b3.19.1787718735400;
        Tue, 25 Aug 2026 21:32:15 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-857053853absm10609357b3.3.2026.08.25.21.32.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 21:32:14 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: sashiko-bot@kernel.org
Cc: blbllhy@gmail.com,
	linux-can@vger.kernel.org,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net
Subject: Re: [PATCH net v3] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Wed, 26 Aug 2026 00:32:13 -0400
Message-ID: <20260826043213.49431-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826014955.B9ECE1F000E9@smtp.kernel.org>
References: <20260826014955.B9ECE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 26, 2026 at 01:49:55AM +0000, sashiko-bot@kernel.org wrote:
> This is a pre-existing issue, but does kvaser_usb_hydra_cmd_size_rx()
> need to enforce a minimum payload length for the extracted cmd_len based
> on the command type?
>
> Can this cause a slab-out-of-bounds read past the end of the USB URB
> buffer?

This pre-existing command-specific structural validation issue was
discussed in the v2 review [1] and should be handled independently of this
patch.

No other issues were reported for v3.

Thanks,
Cen

[1] https://lore.kernel.org/all/20260825025011.13898-1-blbllhy@gmail.com/
