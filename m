Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071879;
	b=yMDW3JCfoyCjtgh3CrgJkFelEHd8KJNRwD9JD1H4f5UI0ZEgDRTXnaVbmo6r11Fy1C8B
	 9VuQp8A0WJOUdr4AUj98PVq/nCHUUD1VaXIJxE/kwb3l1FtZ1+q6uKnTt6hrsphCthhVM
	 nbhJPNKCxnTJpQtAlCgbD5Nt4vzo7o9Ps1ZBjDRABEoTA9CyUsrLmGftI+5ePwo16iUBX
	 HaiE299neZZ+KhHg141JfoLqAxuY4kEXyRy3fxyzFJXTqb5jF8IVfL7yrUfHcvZIq1iHP
	 Zks4f7Ff1bAomjwelgk0WV9zHKJhvPOe88OypZT8H3uHeZrJIWuLjGJo86FK4g6xytA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FumZNvLAP3ED/34qodGOcbiLmIISEGhi+wd5f3+khLk=;
	b=leRPDL6gusXBLHtBaTLVp6cRA2x1J3YcJOnd0LfQhxew9WGU+Hv3ftYXPP4bOxU9pMpc
	 ozvWBSjqKYQZGBUih2KdGsz5CuZ3XugjjysG4oHkZi9YY2WPxssLifynajsyhGCvl3GSF
	 qlI+uVD4LvNcsGbosbp/8aeKd28+haa1YQ4GtYDTyS44vey040oGDQNa1A7wWD72elO4s
	 xsIlFqREVR9ub8kv85u0s2TAe6gmI6J2Rt86k3BuPRQ3HiAWAVbpMxDRDfl/GuzIfuQsd
	 OhUjIGYTRghAnoFsP3LeHPmUgwyo4YKe6wMuz4ykd5e7NCqTMUKmvdj/Jiqw4cjvEsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f4meJjGM;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77543606A31A
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 03:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77543606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f4meJjGM
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so353511f8f.0
        for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 20:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793071878; x=1793676678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FumZNvLAP3ED/34qodGOcbiLmIISEGhi+wd5f3+khLk=;
        b=f4meJjGM1sNti28R+ChWYEByNP8Avx7P91CW7Tu61rkSyrhC/zF4ct509PawNUmfGT
         x3Eug8V/hhBmBTeWrSu4fIyJ9biTRHlLncm+JY0UAHhwLkqBR8p1C1hNj5FcKifSkm4V
         OEHVioSNYyz2rPjwTXnEgToDcCMI4EOlqcoeDRbHYRrV/k+4o08yEaVIJ41rTaZO30da
         7DkOhIHDJwV1qOdZ5L4RfnyCdfmItVmdJ4QLNrzQ61D4l1BvWgEHNnpeXRGHGfL2RqIl
         djYf0e+vGndi4N3zqm5+iSRxm2H1bwZagm1EO9Zc2WjWm20ht9rneQI4G7D3JY4WEQBF
         2lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071878; x=1793676678;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FumZNvLAP3ED/34qodGOcbiLmIISEGhi+wd5f3+khLk=;
        b=rdSrjwJcdxqygM88zNTYdsrZT3LXVyv0u30xKWlK5Jinfd7EzQvlwlTmagk2ZmL20+
         4rLLVVMoLKbjfxbDtMtqC8Lj36y6ozY2a/MP4SGeiR3BtW2ZkWZc+9Mi4rAJ0wm1jT1K
         9h0FGWrgV3S8Cl3hXqohBhYc0xt+S5drdQWQGUm8KorxvVgpDc0/amzQ9uTr6LTSoy/u
         6/3Ac+iS60UPUTluOM7mVjGgjL63RUUts7Zf+0wMyJTCgodKQt/44rwd0qyNoE2eCi2b
         65G6N/EPuqAYlrfoAY+hhney/bvL1VcXkMaMBNnsj18809XLgegXeVH4tByC8DhuU5o5
         vJGQ==
X-Forwarded-Encrypted: i=1; AKwUvBylyjgvz4Z7QfRvFcE2OAOU7eJVX8D9MU9GGg48TNRmkIgmA4Nne0eDmmvwUuI5qMmQyYBLi58W/hQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYnrJ+MkOcwwFQOOBJYUpqjxs/q1tjgEGtbBySDluR9yeoY3oI
	GkFrXjVsZvatPzlP0OccoZXHtVDeeuUFePZDEX7ZsPI/mYry928wolrjhfCfWx06Bx0=
X-Gm-Gg: AYBFou3hq5Hu7UIbdY47VI30W2bC/IeZbfcg9YgMafdGauL85rmzkh2KkDn/MLsYyla
	+OSqCLiRnZzLHy19Z45s9GbVQ1hfJj7AdlLiuzpWe0rh72azfd2dnoKMVtNMBhFj1x7iVv68K9Z
	YuOCCKo+9ZdHXrufUFuSfD7A0kAWJ0xEJzkgkA7YzsbLUCb5MiVOLFly75uilcjqAvFYTee0CtO
	ulQWq07p1rWStKE2QkajkHrg/zjLUrdYzqs90kOv7TMOBSbw5DlYYvO6yKgdD6Rr8Yw6IC+WeaE
	sYaV6/+dmHY7YoTAaxRItj/ag9qhUhmzQMgobgHrVWpni9YhWIXW8xbE14oIkKrnNQ+qLM5QLmP
	tOm8gRz8W+UiiQmh/ngTY/0kYPiXhrMulkwigRJ/xz1K8XESs+Cc3ObWH5q4uDrkMQTAA9KicT6
	l1EtglXTmJEPfngrmaN7WKHTCjwDZNHf+K9tiK+uTGszXA1cHOnDJbqsLw/4wNCVKBaKcVoKIfb
	EXefvavx8C2tC10Rb9NibmMyxLatzg6HfxrUEa62He/mgUvSusVqObPxvoW2QJAh4mghooJ1Urv
	6gfOQy/wDTb3///6ZeKJjnIMK8pjUgAAizaXuHwRSWxTBYiRAhk45cvHwBaI/ZlL9l/IVL6uw2P
	1plRVLhjfSwJ63MVRwsgGoFGQ2Tkx1dKFa6QgQJVfG9rsCH5aLUFX+cP/h4KHvUp3EkLJnekV9B
	HbWRdEOZIfmxGVyrt7NS1kTcux
X-Received: by 2002:adf:fe48:0:b0:48e:1aa5:fd77 with SMTP id ffacd0b85a97d-48e55a15f74mr2006076f8f.15.1793071877451;
        Mon, 26 Oct 2026 20:31:17 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b2ac-9b01-6900-1f92-d182-4435.310.pool.telefonica.de. [2a02:3100:b2ac:9b01:6900:1f92:d182:4435])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8c05sm25685718f8f.49.2026.10.26.20.31.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 20:31:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3.2] can: j1939: fix j1939_ecu refcount leak
Date: Tue, 27 Oct 2026 04:31:04 +0100
Message-Id: <20261027033104.76618-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <3958917c-1484-41e8-8d62-99575edbf980@I-love.SAKURA.ne.jp>
References: <7df4f6c6-b53f-42d6-9725-e60b763d01f6@I-love.SAKURA.ne.jp> <3958917c-1484-41e8-8d62-99575edbf980@I-love.SAKURA.ne.jp>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> 	list_for_each_entry(ecu, &priv->ecus, list) {
> -		if (ecu->name == name)
> +		if (ecu->name == name && j1939_ecu_valid(ecu))
> 			return ecu;

This also hides a live, named ECU from j1939_local_ecu_put() during
unregister. The netdev core sets reg_state to NETREG_UNREGISTERING before
issuing NETDEV_UNREGISTER, so j1939_ecu_valid() is false when a bound
socket reaches this cleanup path:

    j1939_netdev_notifier()
      j1939_sk_netdev_event_unregister()
        j1939_local_ecu_put()
          j1939_ecu_find_by_name_locked()


The lookup then returns NULL. j1939_local_ecu_put() warns and returns
without dropping the socket's ECU reference. That keeps the ECU's netdev
and j1939_priv references alive, preventing netdev_wait_allrefs_any()
from completing.

This is based on source review with AI assistance. I have not reproduced
the unregister hang at runtime.

Could teardown use a lookup that permits NETREG_UNREGISTERING and a dead
rx_kref, while retaining the nonzero ecu->kref check? The registration
and receive-lifetime restrictions are needed when acquiring new users,
but cleanup must still find the ECU whose reference it owns.

The ecu->kref check remains necessary because zero-reference entries stay on
the list until the RCU callback removes them.

Thanks,
Karl
