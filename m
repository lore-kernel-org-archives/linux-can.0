Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082073;
	b=i1H5Bf6w3y3T/tUqcXzOYN6HTIBIWvwqZ3721UffEsZCFx8ibUda4aZlH1uW65xVP1Mj
	 NVkuzuIHtvBgxiJSGazv9qJVyA8y3CrSgWjC8SUubHd9QQq58W60z/BXNkbVyZMVP+Tjz
	 S6XCvetLBLRPipwXqwAQ+Z5w0I6+LFyFECG/QNpovviykldZPi9O2Wkcqg3BmzMIhoExn
	 pfEIC3P7pAyM++X4YuE7d9K7dB1BZ+XBDKDbjVJJyXZxUhdj8CzPdUvwusfzXR2e7buyn
	 CaPp3RGYEEneS2C/xkvfeqqHMizSv1/WFGeAgBsEKSDK7xUCvyY9ZxsQnLZUOw7UIoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082073;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uwRlO2ubicwOjA4itRhvsrI7LKvz1GsSjq/hgP4IYPE=;
	b=GHUiuSqf9X34FhxXgoYrj0I93jKK5ukrMYvg/RW2MQm2I84m0Qjd8oLYchP7l/clYXmn
	 kHQMVDmyq8WwX42mSiCJOtbejlLmISuNGpsl8NensyhOn3BBmd8Y0Ko2pkg2nJPPqK2rD
	 jMuIegFXQNNHzscAru5gS0z3bT8dV8kUUDCWjpg0g8zPymVTKtvrZKZkxLk+5VnOa2X2b
	 H6eVHnaCtO6PLHhMayHh9HCfwSWT9YVG5pgCURwd6G5mZMCogiuDcXA3qIxEPPtkJekp3
	 zJJ4vZDeTA8ICDF7BcYJ3KVuunXm7zoDZVgAj4FKplDbA5xtTiegpz/Kmh6PXVmiJJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBaahrFQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044A606A337;
	Thu, 19 Nov 2026 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBaahrFQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7801A1F000C7;
	Thu, 19 Nov 2026 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082072;
	bh=uwRlO2ubicwOjA4itRhvsrI7LKvz1GsSjq/hgP4IYPE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mBaahrFQRnkt3usk7Fv2KbeIVZsMsvHuI1OT5+pDHq5mVs9lg1g2QqYSquD2hS1w/
	 gRHZuYn8a5WpGFzotj6vMZT3vX2jjG4NlefKgGButNuxJCtiuPqo5pCA1JzNO9SrlN
	 UQxKorvAYka7EjVzzP5L0ea387PoEDFR1ZpZxQ3OhUnpIK3AfBYR5mHxauUU1SgUeK
	 97RDWj73f1HrRzGkB1zkwVO3NpnYGCNVG1p+iGc+MKb2rHTo2X5pB5SKpg9MbSlhwf
	 jT5kSc43R2G8NJjh7+FKvVhsQ5Lame20vEk6kKuH9b3aOrIkf6nJxtkKhcRVafweAI
	 f0U4DvYWL2Hhw==
Subject: Re: [PATCH net-next 09/12] can: ifi_canfd: don't discard the IRQ
 lookup error in probe
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 dev.kurt@vandijck-laurijssen.be
Date: Thu, 19 Nov 2026 09:54:32 +0000
Message-ID: <179508207207.3136.4339679451321533549@kernel.org>
In-Reply-To: <20261118092955.1283165-10-mkl@pengutronix.de>
References: <20261118092955.1283165-10-mkl@pengutronix.de>
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

- [Low] The commit message for "can: ifi_canfd: don't discard the IRQ
  lookup error in probe" presents a user-visible failure as fact ("The…

--

can: ifi_canfd: don't discard the IRQ lookup error in probe

This commit changes ifi_canfd_plat_probe() to return the error from
platform_get_irq() unchanged, instead of turning every failure into
-EINVAL. As a result, -EPROBE_DEFER now reaches the driver core.

Link: https://patch.msgid.link/165f3fccb8faf1db65e8f18dbee4694c95266e31.1792118040.git.chaosheng.qu.linux@gmail.com

> The driver matches through an of_match_table ("ifi,canfd-1.0"), so
> of_irq_get() returns -EPROBE_DEFER while the interrupt controller has not
> been probed. The probe overwrites it and the driver core stops retrying,
> leaving the device unbound even though the interrupt controller appears
> later.
>
> Return the lookup error unchanged, as the neighbouring CAN platform drivers
> do, e.g. previous commit ("can: cc770: don't discard the IRQ lookup error
> in probe").

[Severity: Low]
The code change looks correct, and the mechanism is real. of_irq_get()
returns -EPROBE_DEFER when irq_find_host() finds no domain, and the old
return -EINVAL made that a permanent probe failure.

Can any in-tree platform actually hit this failure? The "ifi,canfd-1.0"
compatible appears only in ifi_canfd_of_table. No binding document or DTS
uses it, and the only testing note is "Build tested on x86_64".

The message reads like a fix for a confirmed user-visible failure. It has
no Fixes: tag, though, and it doesn't say the problem is latent. With
neither, a stable backporter or AUTOSEL can't tell whether to take it or
how far back it should go.

The cc770 commit that this message uses as its model was edited to say
"This is a robustness and consistency cleanup, this issue has not been
seen on real hardware."

Could this message use the same framing? The other option would be a
Fixes: tag naming the commit that added the driver.

A smaller point: "previous commit" doesn't match the applied history. The
commit directly before this one is "can: janz-ican3: don't discard the IRQ
lookup error in probe", not the cc770 change.

The cc770 change is already applied. Would the usual commit <sha>
("title") form be clearer here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118092955.1283165-2-mkl%40pengutronix.de
