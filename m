Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68350190462;
	Wed, 14 Oct 2026 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016387; cv=pass; b=GxKgDRgMHGrz4/0QttTMOuRGsKOxUypx1uB4v8jx8HE/z1bBd1FbAk5CUc0IlB7xG0z58HNMjSGt5mzxFpitRtW4LulUXQWHatwNe7H967VNm+pMMNJ9BLvrvN7/33Y7YL0Zyn1nsbAZZfRd6WJcWf1ipuekeecPfvfK/OnZb7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016387; c=relaxed/simple;
	bh=grdwJaaVVpAXNJvuGt7NJkgB4SzXbFJH8+mZb4FLS4A=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=TXL42SZOI/oIm32gULWiss6XA9nZj4bufj/K0tU1IjYJs0hcqYlv5Cwc+JyKz5hsXD0iYknSRlL4ssde/d0E26r4Ya/zSBaxWT9f6fJpIGGlMMW+cpC78IMB5XBUPnZ/kFl9dag6dBOUBcgbl5chOWRlpbQNeY6nKX0h/NuDpMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=W6zCboNi; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="W6zCboNi"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 34770200563;
	Thu, 15 Oct 2026 00:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792016379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lf2GisXrodBcAwr/nzpjC52HhvbNXakJ4xQTWtJmjWg=;
	b=W6zCboNibhtLfhUv6ssikXR0cfb9AJVDAQ5tXRR7N2NxCm7pqIPiowRreV/BJ54ZS1kHRw
	71XPCFPD2mkFIrsFWCdQyotG07LMIrnytaZ+y27SPO6PaYlEZP6Wi+Gnw2BWBfHI7ml3ig
	k8q5PV3TQ95L4nl8jo4MJpbX6IG5jqDRjBN2ODCZysFFOqJ16RbhSZ2Uiw6AECwSPu3b2x
	w+ftqAnLznq18PUTA/bJP+D0jFCz6FVVVb98gHr7N2weY4O87UQDtDI5om2IDgSpc4b9sX
	B3DRdeph2oVTICDLtCzMcXmQEXULJ6EB39TUQ9rdRyJBDuKD3ICLsO6XtMgBAg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792016379; a=rsa-sha256;
	cv=none;
	b=dpurStDd4V6Hdk1GPBZKk2WOQ0cingOn6EXUTBtOQwBYt59AX10r5i9IG+TgknIfhxINyS
	mr8KVbgGnJ0IWC1kRNiuUgpAYjyLqYmoVk4MGMggjA2orcXTAv1gNaYHlD47oOcsdag9js
	kZarn3xTo61NUGhYmtlabqSojrEvDwzUxKIo03Q/02vilDtECbEOf1Map1AwEMqyWRcd+c
	DeqmY//xkVarRFEURgesDEpvf5u6BT6e0LB+ZhtRIh5PhbfmduvijgWEqIgnq7i9TKtlxj
	uWCABW2cvQdiWEcSJ1F/Any5DYtq+ViYZoQj0qNt0bnzqoxqyJFg1BAAiUWUUQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792016379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lf2GisXrodBcAwr/nzpjC52HhvbNXakJ4xQTWtJmjWg=;
	b=W4n36aANnHOONozi/6DGPzGawWHPpK3CpFshn84IetpyNIbPKW4yINmTMtCpvcZEMm3DJS
	2wWO0jgk8hj0yfU6GXzoCO9793551C9ihtJlffte3Wr1Cpc2UJXISHXhvmFWIFpS2MkGYg
	Ijm++XakY2iRq00nNkgQyzCvYd3mzBowv13ZOOv9102+xIULnVSYetktn4jECSyG2JzIDp
	wCNCpD8R2zzIT2jj8SfoIJTjPfHvtadlEUUNvxPKwwLRxVfHw+YjbfA9ZKrQz+be9ssCdq
	PcBB74A3u4lAaI8nd2Fm+WN8oqGM5TZHuiH1pQqgJbAw0l7MsUZ06uSL9hDS1w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH7Jz-005vV8-0L;
	Thu, 15 Oct 2026 00:19:39 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C53E95C45EF;
	Wed, 14 Oct 2026 22:19:38 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH can-next v1 0/8] selftests: can: add J1939 socket and
 transport tests
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Robin van der Gracht <robin@protonic.nl>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Shuah Khan <shuah@kernel.org>, 
 kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>, 
 Quchaosheng <quchaosheng000406@163.com>, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20261014154435.3577983-1-o.rempel@pengutronix.de>
References: <20261014154435.3577983-1-o.rempel@pengutronix.de>
Date: Thu, 15 Oct 2026 00:19:26 +0200
Message-Id: <179201636610.759130.1681092526534034693.b4-review@b4>
X-Mailer: b4 0.17-dev-39d60
X-Developer-Signature: v=1; a=openpgp-sha256; l=627; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=grdwJaaVVpAXNJvuGt7NJkgB4SzXbFJH8+mZb4FLS4A=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg6//9zx5MX4ubVHSnJ+TWm75ebrno5KWx5jkN32UHTz
 obm0+5uHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZhI/WFGhs03UgOeWN5kfHSk
 KtLvYsw2J89n9yKv23i7F6dLM+kFHGRkaOXu2f8oe+mGZ1ciH/3JXH/z3JMtDudVXy56sWFDZvx
 kax4A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

> net/can/j1939 has had no in-tree selftests. This series adds a kselftest
> suite for the J1939 socket layer and the TP/ETP transport, run on vcan with
> a CAN_RAW socket as an independent on-the-wire peer.
>
> The whole suite runs on vcan under QEMU and passes. Two limits span the
> series and are left for follow-up: the transport timers are checked only
> with wide windows, not tight bounds, and the ETP abort/timeout edge cases
> are not covered yet (the abort/timeout tests are TP only).

please run checkpatch on the series before sending it.

regards,
Marc

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
