Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E21B4223
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810759; cv=none; b=ttvMAg5csq5/7MdvRkFF+PMTVVRl2bjCszT72oEG8PeejM95OIfPlXP7Jvtrp3ZluxaVrXeNlGvTpXmqNd0B7fitaM2tpuVRvdfvniBI7g8ZgZam1IZypjpTOnGpbrHbJR3Ur6RxMajJ91tPJhotyrBaoOi80v0a9ythWjtt3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810759; c=relaxed/simple;
	bh=wz0QWMRQKg4OnRErALbmyJggv7TZGILU3iOTa874PG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+dlF7Ma+vAQjaBRSBLcX/ZOcr3O9OqZJvSd7Lqn8X6K/8FDO7PpsOvmkHeXPlDzfgGnnM/oBwiivf/BulqvqpJkZp06H9d7eeVY53B/NOEvJzIjcsxVF9rLviIArdlsz6BiBcnBG/VhfpuZC4pb1FCDtE3wkTg3nzk40SXE39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=o/HY8OQW; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="o/HY8OQW"
Received: from mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8b0f:0:640:dbc5:0])
	by forward500d.mail.yandex.net (postfix) with ESMTPS id EF16C82058;
	Thu, 27 Aug 2026 08:58:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net (smtp) with ESMTPSA id iwWcbN5dBOs0-RnkgyIP2;
	Thu, 27 Aug 2026 08:58:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1787810327; bh=wz0QWMRQKg4OnRErALbmyJggv7TZGILU3iOTa874PG4=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=o/HY8OQWL/y8iTv0zE1oq0mZ26p9bYnU9qwCTvp2w67J0ulBeDiuXvxoj4FIJRqFB
	 8+p9cOOAeleHZLB7QXZKAuePvtoIrZaIdDEsd5q9t17fHedJli2DAdiOv13KkpuLeX
	 HJRlF8tlsp3wc51PqGfW8jbyaCTc9OQfvWyaUtVU=
Authentication-Results: mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <e6a2025c-6c98-49c7-99da-7219dedc185f@yandex.ru>
Date: Thu, 27 Aug 2026 08:58:44 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: j1939: cancel all pending ECUs on device stop
To: Oleksij Rempel <o.rempel@pengutronix.de>, sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>
References: <20260824155406.246942-1-dmantipov@yandex.ru>
 <20260824160844.4FBFF1F000E9@smtp.kernel.org>
 <ao5y3Mp5yotE1zOY@pengutronix.de>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <ao5y3Mp5yotE1zOY@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/26 8:00 AM, Oleksij Rempel wrote:

>> - [High] AB-BA deadlock between `priv->lock` and `hrtimer_cancel()` when stopping the device.

Will likely resend with an extra quirk, see https://syzkaller.appspot.com/text?tag=Patch&x=14fe5625580000.

>> - [High] Unconditional cancellation of all ECUs on any socket closure breaks address claiming for the entire CAN interface.

Sure it breaks address claiming. But, and this is the question for real
(not like me) CAN experts: if the device is forced to stop, what else we can do?

Dmitry
