Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271472F7F01
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148956; cv=pass; b=mpVPhZiOQE0Uak3TxiCznxTm1p6YJFfZ6z3+BVYkvabX853xbmlY0/EEasZHTbIluW5pd5ZG2MEYp/OEM7egByxYEOJMKyKC9LPKsue5sh6r5WANOeOF5zMSvc1dlHoYf47wJszWTii7Kx7/d3agWa9NJ5nEWFs4fl+PY4d75Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148956; c=relaxed/simple;
	bh=1778yq4yNdm9yTP+L+5Cf9g+TI0YJXSjKJb+YxBJfuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GfzLIxiHmtC5S5deXdBqOcw9/gmTLHCvCtBwpckt9gWRQUAkL1ur9b7N9NlU4UUiUybGdZCrtHB2Ls9qggCFLElykc0xJUiMH/tjHofvdPsxQixgbaeIp5xfoiRlm8bCekjnwNQBpvyIALQweZY+Qh+3bCf4rCOMNjJNKXOknn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=YwApWAVF; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="YwApWAVF"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 16FAF201B55;
	Fri, 16 Oct 2026 13:09:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792148951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvwqvVQG2gJEUf/DbP+dtOKt5TzFXCnY+m+/FOULEaU=;
	b=YwApWAVFtrEPlWTN2aYQz3RtUJA/V1jhZORrWjFHQVB2bbbRI7fnhrsvPjjXOlt5Yg32eF
	Xlb56RcJjxTsqf4v6TdZTJ0SMFhMXgFzT+EZZb5yRxilQ2f7xeHrOmdXqbvqFgcpGzyd/E
	nNu/ez7cqCei25rKDUQoMl0U9up2sdAow/9CZV2K5QpW8jREmrc7qYEIYmyw7ZcwL27bj4
	871DCBL15dEuJMgx86GxHtAONvHJJXQMwQReilzPcVG61wp2tPKMSLk/diErnP4RxFC0i1
	/spCtJV3EHSoYMzrml3/AF35k16QUKbDVlG4EPQ9mFHGTzQPQxNIdowk6yiMLg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792148951; a=rsa-sha256;
	cv=none;
	b=IJH1g8AKvoBdPuf/WdlSqa005IoKxtXZADFiyhWgdnfDzhcPDuJGPP4yHUUGt3q913Gfuz
	y6mn+eej7ZykwjuDba9ZW2D8+9sFtAA45kO3/iIWVv3BNzpxUWcn1kMPIcQ6NEngj8omWM
	y/UY1vbMofdRpiUNmf64JUrNm5Ep3Lp30ErNnr3gOc1cOdQDB8bipJuAfIq+P/yb/oidM5
	9X0CSTucD4s+iLLuGm6ESWImhLHrp7P1AaiFjlPsClpbNnRf5sj9cYQ4aoDX6wMzfFfHaW
	Kl723QmNmMRmpSJ6tfVGlUv0iv6vfUcgkZOwwT2ZU2lFrrlRz/lbjB/8xUj9Ng==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792148951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvwqvVQG2gJEUf/DbP+dtOKt5TzFXCnY+m+/FOULEaU=;
	b=a6RaJX9X6FUFPi1mgTezvcCD8lRqD95kYpfsXtoZXsm7o7bnCeMdhVduwZCXKrZNvPgxp6
	EdmCne4R9GnUgy6xHekHNCUTCS4zSgZZtUIxWP3BgB1/ozPUXEnXFoj4UyDjTtxl0R6Jab
	HJv5UhsLKWzAP0DFxPKazULAFIC/RunUN2FUa9QPvOszZ0sgtX238xVd6yTLKl1lVts6vF
	7PqdG61aLL1pmeAcPFfFE7xsXpSqJ7DzGAEBJCmaYSEJBe8sTqWl5/3Muk9rnqtnFrfrw3
	BjRhNZQOeV7y7hE7ICFGikgQOXCeLc4eXEkZt39ZS84x6VY2KYAXxQDz45tK6A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHfoE-006Aly-3B;
	Fri, 16 Oct 2026 13:09:11 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B7ADA5C60A6;
	Fri, 16 Oct 2026 11:09:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20261016103706.410678-1-socketcan@hartkopp.net>
References: <20261016103706.410678-1-socketcan@hartkopp.net>
Subject: Re: [PATCH can-next v3] can: proc: remove pointers from CAN
 specific proc output
Message-Id: <179214893971.1262810.1226021327766339616.b4-ty@b4>
Date: Fri, 16 Oct 2026 13:08:59 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=324; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=qVKivvwBXzNYGFR1NmiQ+iuS413SFEsclnXoYfR2j0k=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6xHr53cMfLtHTHaLX2HUekg0981JRppnrZldsV+gOb
 v+MVEuOjlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEyEaS8jw5Gjod9nuf822Fur
 ESP6VlGee5KJpd6GLT89xfpbgk+WzWP4K662KkjBs+7djeSbswrnv3kvVab249aGW4rcF/oY13l
 v5wYA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54


On Fri, 16 Oct 2026 12:37:06 +0200, Oliver Hartkopp wrote:
> can: proc: remove pointers from CAN specific proc output

Applied, thanks!

[1/1] can: proc: remove pointers from CAN specific proc output
      commit: 2e8d76f6b54b58d77c617483dfbbd816ac5da8e8

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>

