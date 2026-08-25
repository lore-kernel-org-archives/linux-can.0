Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D793254A0
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787626216; cv=none; b=h8yKSezC01xDz2OzcwR1eWywZbWOP1C3yefiogDvsuttMLRxivrbAG6hDNcyyziyOGgbXHFB2+66r5aphVGfoABdq1998W/wtZmPguG/LIOhfFhGU68roPAYM1NnvVNC884dLzdn4cjy5EL5tFvGDhlN1zmGCA+lSVmv9VESxig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787626216; c=relaxed/simple;
	bh=VZGv3nP8pjnZdO2V6lGttvQqZy/jkYuM5+4UwJWTg/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2gS2nISuDKCsNuWUsFAI7rM3BJ90ktud3Y748KqmJfEvFaJ4xpDwMAMl0ztxxt/MF7C/VAbGAPU+D4uTVdoODF6gAn2xbbbAGoJUpIEWMwtHjrcdbInVCDYnYmz/jOniHwvsCDRWfSQmaK+D55qK4aoq0cZcV12geL3surOyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li9AQ1xl; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li9AQ1xl"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c70f69d3fso4695676d50.1
        for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 19:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787626214; x=1788231014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZGv3nP8pjnZdO2V6lGttvQqZy/jkYuM5+4UwJWTg/A=;
        b=Li9AQ1xl9rRWAXtiRb7rn2OIS4axYHuqp0n39q2xx6fYGTp3FRB+tQ3Rf5h3FTsZ+r
         Yi4GiqxewggxUNLANeIqa0CB5OUL6M3TLygS7TrG3iiARoRihWSQS0jPmsp7oIk/6kau
         IPZDCOfnskSWp1gSVuKNDToDhIF4Rhbi2MOep8paU+fWz9aWMyFuGLz58Xaablpn/VXu
         2yKBgRjcKg3iclcCVSiigXAycy7WeM70HBGSeQqsR6BAmnxziyRY8WOrTTCJAYBUGeUs
         dOWCOdSWGQUAoxERM+F7Wg3zqqcy+oJMsOYnmbiQxh3KfNhDC1akQDsUB0sqtfphAleZ
         r+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787626214; x=1788231014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VZGv3nP8pjnZdO2V6lGttvQqZy/jkYuM5+4UwJWTg/A=;
        b=O95gXl7LeOkhE2tZvaqk8VQdW70FNKLjXJ5zIJdf2M1a3lSoE3OqkHBWy50YqldY3W
         6rmeRI12Cg5iKGR0U1qgMWRdc9hlEYn+j55x1Lw/xOgLw2t8mJHJLGhifKt4EzoChneU
         Kv7uAIM+dy1u7DKTQNlO+7hQoQoz9Kj7ZQHZkFdRh0miazG9ppToZgGVeoJILfM9uVAE
         KoE2OgrquegFkwiXMtIoY/BAixgrsyo1CGxZv4PiS4ktg/izRv/8UP1sh5Lv7RiSn84c
         F9mJigVcSSPOyh45nm0c4swNoogVbIxq8xNsHkn8zzyn3BxzcohbFHoNTcDuDu/ELYjy
         7ijg==
X-Forwarded-Encrypted: i=1; AHgh+RrcuX/R3J6Kb6uUFMLg1Pgs/rXg7/XkNxBp2F2UNAKrXYDrFWilnvSo/s6Em5TYRrFqgH4WrIEWTqw=@vger.kernel.org
X-Gm-Message-State: AFuF++n5JiMBb+qyEe4FxYDKuEhOXctJi9J+bLzO1a3SHI1YCi8qHgo6
	6WBvkKwroju6cGXTbGJqtMKoXO4orQRQH8aeCeZOx4NWpBwJuox0xATY
X-Gm-Gg: AR+sD12jan3xL1UhcVs7r3JxkihxGh493l77onX7XsTjTIeCsqggx/twPfEZXFLKYK/
	aQNx9ORdwwB43Gq3qTlNMAtb0eTscvoY1lkBn4yEaTiKUSrbqWRUXfvVX/sjRDBR6dDK2+9su3o
	/U21vKQoNdwKSaUTcQPKaxzNPkcwbM1FMLTIplB26KFqavu9qCPXbfBuxlkQRI77QjGfQBZJEUo
	gSr03ZfWan0oVrOO266EXlN8zKpkdJm24mjNA2dhB8cugj3PJjBsW7wt+zFAgaMdePStYRive1c
	H8m8RUllTbqc705jpnEp2yv0N3L/sfoMOSGbsTAD+3/J22JQuDmjMqPU3btFhXoUALMbbiBzHsF
	iYmJHfta8EeOfPkKUIejudPqGbYax4b2e2rq7MQ9LwNQRmYLw8XkGpMqs2rim2gXB2ep/mxnxUu
	LpSehzwopsL2IlDPn4nJdOxf+KK1OPXqjOmAnz1mLRuqHKQtNjdn3JCzc3jonJLTX2D9s=
X-Received: by 2002:a05:690c:c6d3:b0:854:5db3:4ed0 with SMTP id 00721157ae682-854783a0e38mr15676447b3.31.1787626214359;
        Mon, 24 Aug 2026 19:50:14 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cabe2570fsm42799507b3.38.2026.08.24.19.50.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 19:50:13 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: blbllhy@gmail.com
Cc: AutonomousCodeSecurity@microsoft.com,
	linux-can@vger.kernel.org,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	o.rempel@pengutronix.de,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net,
	xmei5@asu.edu
Subject: Re: [PATCH net v2] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Mon, 24 Aug 2026 22:50:11 -0400
Message-ID: <20260825025011.13898-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825024110.12021-1-blbllhy@gmail.com>
References: <20260825024110.12021-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please disregard my previous reply; I accidentally sent the response to
the v1 review.

On Mon, Aug 24, 2026 at 09:53:43PM +0000, sashiko-bot@kernel.org wrote:
> Should there be an additional check to enforce that the returned
> cmd_len is large enough to contain the extended struct payload?

Yes, but this is a pre-existing command-specific structural validation
issue. Auditing each extended handler's minimum length is outside the scope
of this patch.

> Does this change break USB stream reassembly for valid fragmented
> commands?

Yes. An incomplete size field must be buffered rather than treated as a
format error. I will preserve incomplete fragments, complete an extended
size field before reading it, and send v3.

Thanks,
Cen
