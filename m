Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224274;
	b=K8VOSY45cPM5b5picha0xdwydWPYPRC4akEMpFcOK5KImx+E7arlVczhEbpEdICKtqBX
	 eE9Uu8vgg4eql8ovsfNNKIPdClfUv/LX7QU62ddsuck9popGr+f3BLzNU3TfDKgGI48RJ
	 6ej/Dt+rr5bVMsuSoErduEKZX9igHMA87GCjL0G/DT8AJSQ6zO4g9Dg1KFyb/+rSVkSgz
	 D5U0iJMuMj9UTdAu+IuvDn1N6H5+YY9TA+PoATjqiu9L/kNptnjhdnGbJp66w4mG3I2Ek
	 8LbwyVjXPy7FHSphN2CokMMNM0Mdge1ER1hmzSeAbDf9IQmQ0ZNyRvQbL7K6m0O6J7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224274;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rd3+z6vq2TMUkUnwow78Fgj3dJ0i765N3091XiypQOI=;
	b=u56ibBYzpvU5wiyoQeKxMjV9ZWEQh9IHCwbAt+Q33eOuNZG7+uRBX9Xwhp/gcZTRnENu
	 l+VhszLblH+ptkFkIk+dCutBwzHjvb0ObxyXiFMBAylesUan6RL9dEooO9N0Ku8liHy+x
	 mWCevz+C1uk5pfxN/IhKiajaJqegOHdt0KothP/sPH4lUZlT2r2DPSY3QoczbnsXFCnsr
	 ujVNkX4Sgp6/hmXFsGG0r6MQtNKHNOywC+vPXNbv/1i0urDp1chkyiesoZaNYIWCJdlvP
	 Ay+sNYefOGw7YTB2EekuZLWdjoFsUT/akIMGM+00BuxAfmrQF/idPyU/K08wT9sRvBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Er3jM619;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ADD606D80A;
	Mon,  9 Nov 2026 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Er3jM619
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1163F1F008A1;
	Mon,  9 Nov 2026 11:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224274;
	bh=rd3+z6vq2TMUkUnwow78Fgj3dJ0i765N3091XiypQOI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Er3jM619QoitPT+MyCqskB0zPJIXAu03U7PIFLgXR4BLHZFlgq3I/idooQVpJ9ElO
	 9vld4JK12+j8i5s5JI6l6GfSi6RtA4wOcPi0XoPgWCh/j/EOxW5mu4OSTosNswqB39
	 NlQDJ//yQTySjepJ1gJRY8gt76cTIytu17wE1flL0dv0bBKG1lu74MqQydeQX1lRXW
	 P85ECnQNre4WnS2k3RhG0esyaFt1RNofreLm3v72hFoJAg6feC7zrABkMwZsfFoNs8
	 5APGh6jkpjLHiikXU43zuRUEiq0bPAsvIy3s3yxKc70ZtpBRQN08Id4fl4iAC/1nKX
	 /s8Ka7W76MqRA==
Subject: Re: [PATCH net v8 10/10] can: rockchip_canfd: serialize timecounter
 timestamp conversion
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
Date: Mon, 09 Nov 2026 11:37:52 +0000
Message-ID: <179422427265.994134.1596521443425790522@kernel.org>
In-Reply-To: <20261108-rockchip-canfd-restart-close-v8-10-3e7a23fd9eae@qq.com>
References: <20261108-rockchip-canfd-restart-close-v8-10-3e7a23fd9eae@qq.com>
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

- [Low] The fix only works because the preceding series patch "can:
  rockchip_canfd: prevent timestamp work from rearming after bus-off"…

--

can: rockchip_canfd: serialize timecounter timestamp conversion

The commit takes timestamp_lock around timecounter_cyc2time() in
rkcanfd_skb_set_timestamp(), so a conversion can no longer run while the
timestamp worker is inside timecounter_read(). It also updates the
comment on timestamp_lock in struct rkcanfd_priv to say that the lock
covers tc.

> Hold timestamp_lock across timecounter_cyc2time(), using the same lock
> as timecounter_read() and timecounter_init(). Keep the SKB timestamp
> assignment outside the critical section.
>
> TX completion nests timestamp_lock inside tx_lock; no timestamp-lock
> holder acquires tx_lock.
>
> Fixes: 4e1a18bab124 ("can: rockchip_canfd: add hardware timestamping support")
> Cc: stable@vger.kernel.org

[Severity: Low]
Should this commit message state its backport prerequisites?

At 4e1a18bab124, struct rkcanfd_priv has no timestamp_lock and no
timestamp_active field. Also, rkcanfd_timestamp_work() calls
timecounter_read(&priv->tc) with no lock held before it calls
schedule_delayed_work().

The statement "using the same lock as timecounter_read() and
timecounter_init()" is only true once the preceding patch in this
series is applied:

  806691a20048 ("can: rockchip_canfd: prevent timestamp work from
  rearming after bus-off")

That patch adds the lock and the active flag. It also adds the locking
in rkcanfd_timestamp_work() and rkcanfd_timestamp_start():

drivers/net/can/rockchip/rockchip_canfd-timestamp.c:rkcanfd_timestamp_work() {
    ...
	spin_lock_irqsave(&priv->timestamp_lock, flags);
	if (priv->timestamp_active) {
		timecounter_read(&priv->tc);
    ...
}

The paragraph about lock nesting also depends on tx_lock. That lock comes
from the earlier patches "can: rockchip_canfd: serialize TX state and
command writes" and "can: rockchip_canfd: serialize TX with bus-off and
restart".

A plain cherry-pick onto a tree without 806691a20048 would fail to build,
and that patch carries the same Fixes: tag and Cc: stable. But suppose
someone adapts this patch by hand and only adds a lock in
rkcanfd_skb_set_timestamp(). The timecounter_read() in the worker would
still run unlocked, so the race would stay open.

Other patches in this series include a note such as "Backports must
include the preceding TX serialization fix...". Could a similar note be
added here, naming 806691a20048 and the tx_lock patches as prerequisites?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae%40qq.com
